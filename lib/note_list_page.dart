import 'package:flutter/material.dart';
import 'package:flutter_dicoding_fundamental/db_provider.dart';
import 'package:provider/provider.dart';

import 'add_update_page.dart';

class NoteListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Consumer<DbProvider>(
        builder: (context, provider, child) {
          final notes = provider.notes;

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Dismissible(
                key: Key(note.id.toString()),
                background: Container(color: Colors.red),
                onDismissed: (direction) {
                  // TODO : Kode untuk menghapus note
                  provider.deleteNote(note.id);
                },
                child: Card(
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.description),
                    onTap: () async {
                      final selectedNote = await provider.getNoteById(note.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return NoteAddUpdatePage(selectedNote);
                          },
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NoteAddUpdatePage()));
        },
      ),
    );
  }
}
