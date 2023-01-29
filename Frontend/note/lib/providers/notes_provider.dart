import 'package:flutter/material.dart';

import '../models/note.dart';
import '../services/api_service.dart';
import 'auth_provider.dart';

class NotesProvider with ChangeNotifier {
  bool isLoading = true;
  String _searchString = '';
  String get searchString => _searchString;

  set searchString(String searchString) {
    _searchString = searchString;
    notifyListeners();
  }

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
    notes = await ApiService.fatchNote(
        userid: AuthProvider().firebaseAuth.currentUser!.uid);
    sortNotes();
    isLoading = false;
    notifyListeners();
  }

  void sortNotes() {
    notes.sort((a, b) => b.dateAdded!.compareTo(a.dateAdded!));
  }

  List<Note> getFilteredNotes({required String searchQuery}) {
    return notes
        .where(
          (element) =>
              element.title!
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              element.content!
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()),
        )
        .toList();
  }
}
