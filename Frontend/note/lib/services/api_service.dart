import 'dart:convert';
import 'dart:developer';

import '../models/note.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl =
      "https://note-app-using-node-api.onrender.com/notes";

  static Future<void> addNote({required Note note}) async {
    Uri requestUri = Uri.parse("$_baseUrl/add");
    var response = await http.post(
      requestUri,
      body: note.toMap(),
    );
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  static Future<void> deleteNote({required Note note}) async {
    Uri requestUri = Uri.parse("$_baseUrl/delete");
    var response = await http.post(
      requestUri,
      body: note.toMap(),
    );
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  static Future<List<Note>> fatchNote({required String userid}) async {
    Uri requestUri = Uri.parse("$_baseUrl/list");
    var response = await http.post(
      requestUri,
      body: {"userid": userid},
    );
    var decoded = jsonDecode(response.body);
    List<Note> notes = [];
    for (var note in decoded) {
      Note newNote = Note.fromMap(note);
      notes.add(newNote);
    }
    return notes;
  }
}
