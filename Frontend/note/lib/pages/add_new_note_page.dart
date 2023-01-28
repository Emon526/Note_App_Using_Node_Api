import 'package:flutter/material.dart';
import 'package:note/models/note.dart';
import 'package:note/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewNotePage extends StatelessWidget {
  const AddNewNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    final notefocus = FocusNode();
    void addNote() {
      Note newNote = Note(
        id: const Uuid().v1(),
        userid: 'ador',
        title: titleController.text.trim(),
        content: contentController.text.trim(),
        dateAdded: DateTime.now(),
      );

      context.read<NotesProvider>().addNote(note: newNote);
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                addNote();
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              onSubmitted: (value) {
                if (value != "") {
                  notefocus.requestFocus();
                }
              },
              autofocus: true,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
            ),
            Expanded(
              child: TextField(
                controller: contentController,
                focusNode: notefocus,
                maxLines: null,
                style: const TextStyle(
                  fontSize: 20,
                ),
                decoration: const InputDecoration(
                  hintText: 'Note',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
