import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/note.dart';
import '../providers/auth_provider.dart';
import '../providers/notes_provider.dart';

class AddNewNotePage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNewNotePage({
    super.key,
    required this.isUpdate,
    this.note,
  });

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final notefocus = FocusNode();
  void addNewNote() {
    Note newNote = Note(
      id: const Uuid().v1(),
      userid: context.read<AuthProvider>().firebaseAuth.currentUser!.uid,
      title: titleController.text.trim(),
      content: contentController.text.trim(),
      dateAdded: DateTime.now(),
    );

    context.read<NotesProvider>().addNote(note: newNote);
    Navigator.pop(context);
  }

  void updateNote() {
    widget.note!.title = titleController.text;
    widget.note!.content = contentController.text;
    widget.note!.dateAdded = DateTime.now();
    context.read<NotesProvider>().updateNote(note: widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    if (widget.isUpdate) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                widget.isUpdate ? updateNote() : addNewNote();
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
              autofocus: widget.isUpdate ? false : true,
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
