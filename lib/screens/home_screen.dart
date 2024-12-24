import 'package:flutter/material.dart';
import 'add_entry_screen.dart';
import 'entry_details_screen.dart';
import '../widgets/entry_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../widgets/globals.dart';
import '../modules/entry.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Entry> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final pref = await SharedPreferences.getInstance();
    final String? entriesString = pref.getString('journal_entries');
    if (entriesString != null) {
      setState(() {
        _entries = List<Entry>.from(
          jsonDecode(entriesString).map((e) => Entry.fromJson(jsonDecode(e))),
        );
      });
    }
  }

  Future<void> _saveEntries() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(
        'journal_entries',
        jsonEncode(
            _entries.map((entry) => jsonEncode(entry.toJson())).toList()));
  }

  void _addEntry(String title, String text) {
    final date = DateTime.now();
    setState(() {
      _entries.insert(
          0,
          Entry(
            date: "${date.day}/${date.month}/${date.year}",
            title: title,
            text: text,
          ));
    });
    _saveEntries();
  }

  void _editEntry(int index, String title, String text) {
    setState(() {
      _entries[index] = Entry(
        date: _entries[index].date,
        title: title,
        text: text,
      );
    });
    _saveEntries();
  }

  void _deleteEntry(int index) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this entry?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                'Delete',
                style: TextStyle(color: buttonsColor),
              ),
            ),
          ],
        );
      },
    );
    if (confirmed == true) {
      setState(() {
        _entries.removeAt(index);
      });
      _saveEntries();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('MindLog'),
        centerTitle: true,
      ),
      body: _entries.isEmpty
          ? const Center(
              child: Text(
                'No entries yet. Start journalizing!',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: _entries.length,
              itemBuilder: (context, index) {
                return EntryCard(
                  entry: _entries[index],
                  onDelete: () => _deleteEntry(index),
                  onTap: () async {
                    final editedEntry = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EntryDetailsScreen(
                          entry: _entries[index],
                          onEdit: () async {
                            final editedEntry = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddEntryScreen(
                                  entry: _entries[index],
                                ),
                              ),
                            );
                            if (editedEntry != null) {
                              _editEntry(index, editedEntry["title"],
                                  editedEntry["text"]);
                            }
                          },
                        ),
                      ),
                    );
                    if (editedEntry != null) {
                      _editEntry(
                          index, editedEntry["title"], editedEntry["text"]);
                    }
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFF6B6B),
        foregroundColor: backgroundColor,
        tooltip: "Add Entry",
        child: const Icon(Icons.add),
        onPressed: () async {
          final newText = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEntryScreen()),
          );
          if (newText != null) {
            _addEntry(newText["title"], newText["text"]);
          }
        },
      ),
    );
  }
}
