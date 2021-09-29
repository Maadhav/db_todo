import 'package:flutter/material.dart';
import 'package:db_todo/note.dart';
import 'dart:async';
import 'noteDetail.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Note('', '', ''), 'List starts');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  navigateToDetail(Note note, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (
      context,
    ) {
      return noteDetail(title, note);
    }));
    if (result = true) {}
  }
}
