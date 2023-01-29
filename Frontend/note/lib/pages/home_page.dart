import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../providers/notes_provider.dart';
import 'add_new_note_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final notesprovider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note"),
        centerTitle: true,
      ),
      body: notesprovider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: notesprovider.notes.isEmpty
                  ? const Center(child: Text("No Notes yet "))
                  : ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            autofocus: false,
                            onChanged: (value) {
                              notesprovider.searchString = value;
                            },
                            decoration:
                                const InputDecoration(hintText: 'Search'),
                          ),
                        ),
                        notesprovider
                                .getFilteredNotes(
                                    searchQuery: notesprovider.searchString)
                                .isEmpty
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'No Notes Found',
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemCount: notesprovider
                                    .getFilteredNotes(
                                        searchQuery: notesprovider.searchString)
                                    .length,
                                itemBuilder: (context, index) {
                                  Note currentNote =
                                      notesprovider.getFilteredNotes(
                                          searchQuery: notesprovider
                                              .searchString)[index];
                                  return GestureDetector(
                                    onTap: () {
                                      //Update

                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => AddNewNotePage(
                                            isUpdate: true,
                                            note: currentNote,
                                          ),
                                        ),
                                      );
                                    },
                                    onLongPress: () {
                                      //Delete
                                      notesprovider.deleteNote(
                                          note: currentNote);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 2,
                                          )),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            currentNote.title!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            currentNote.content!,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 5,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey[700]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ],
                    ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => const AddNewNotePage(
                isUpdate: false,
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
