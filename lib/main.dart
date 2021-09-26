// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'note.dart';

main(List<String> args) {
  runApp(Start(title: "sqfLite todo"));
}

class Start extends StatelessWidget {
  final String? title;
  const Start({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      title: title!,
      home: noteList(
        title: 'Practice',
        topic: 'Just for fun',
      ),
    );
  }
}
