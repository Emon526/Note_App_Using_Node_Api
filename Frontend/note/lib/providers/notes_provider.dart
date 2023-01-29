import 'package:flutter/material.dart';

import '../models/note.dart';

class NotesProvider with ChangeNotifier {
  List<Note> notes = [];
  void addNote({required Note note}) {
    notes.add(note);
    notifyListeners();
  }

  void updateNote({required Note note}) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    notifyListeners();
  }

  void deleteNote({required Note note}) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    notifyListeners();
  }
}
