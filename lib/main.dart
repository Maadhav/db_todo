import 'package:flutter/material.dart';
import 'note_details.dart/note_list.dart';

main(List<String> args) {
  runApp(MaterialApp(
    title: 'Tood_Database',
    theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
    home: const NoteList(),
  ));
}
