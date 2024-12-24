import 'package:flutter/material.dart';
import '../modules/entry.dart';
import '../widgets/globals.dart';

class EntryDetailsScreen extends StatelessWidget {
  final Entry entry;
  final VoidCallback onEdit;

  const EntryDetailsScreen(
      {super.key, required this.entry, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Entry Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              entry.date,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(
              entry.text,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFF6B6B),
        foregroundColor: backgroundColor,
        tooltip: "Edit Entry",
        child: const Icon(Icons.edit),
        onPressed: onEdit,
      ),
    );
  }
}
