import 'package:flutter/material.dart';
import 'package:noteapp/view/add_note.dart';
import 'package:noteapp/view/note_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: NoteList(),
    );
  }
}
