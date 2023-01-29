import 'package:flutter/material.dart';

import '../models/note.dart';
import '../services/api_service.dart';

class NotesProvider with ChangeNotifier {
  bool isLoading = true;
  List<Note> notes = [];
  NotesProvider() {
    fatchNotes();
  }
  void addNote({required Note note}) {
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiService.addNote(note: note);
  }

  void updateNote({required Note note}) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    sortNotes();
    notifyListeners();
    ApiService.addNote(note: note);
  }

  void deleteNote({required Note note}) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    sortNotes();
    notifyListeners();
    ApiService.deleteNote(note: note);
  }

  void fatchNotes() async {
    notes = await ApiService.fatchNote(userid: 'ador');
    sortNotes();
    isLoading = false;
    notifyListeners();
  }

  void sortNotes() {
    notes.sort((a, b) => b.dateAdded!.compareTo(a.dateAdded!));
  }
}
