import 'package:flutter/material.dart';
import 'package:mindlog/modules/entry.dart';

class EntryCard extends StatelessWidget {
  final Entry entry;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const EntryCard({
    super.key,
    required this.entry,
    required this.onDelete,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.date,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      entry.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      entry.text,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
                tooltip: "Delete",
              ),
            ],
          ),
        ),
      ),
    );
  }
}