import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:noteapp/model/note_post_model.dart';
import 'package:noteapp/model/single_note_model.dart';
import 'package:noteapp/services/api_service.dart';
import 'note_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.noteId}) : super(key: key);

  final String? noteId;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  bool get isEditing => widget.noteId != null;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        isLoading = true;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await ApiService().getsingleNotes(widget.noteId!).then((response) {
          setState(() {
            isLoading = false;
          });

          if (response.error == true) {
            log(response.errormessage.toString());
            final errorMessage = response.errormessage.toString();
            return errorMessage;
          }
          final SingleNotesModel? note = response.data;
          titleController.text = note!.noteTitle.toString();
          contentController.text = note.noteContent.toString();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(isEditing ? 'editNote' : 'add note'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: titleController,
                        decoration: const InputDecoration(
                          hintText: 'Enter title',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: contentController,
                        decoration: const InputDecoration(
                          hintText: 'Enter content',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (isEditing) {
                              final note = PostNoteModel(
                                  noteTitle: titleController.text,
                                  noteContent: contentController.text);
                              ApiService()
                                  .updateNotes(widget.noteId.toString(), note);
                            } else {
                              final note = PostNoteModel(
                                  noteTitle: titleController.text,
                                  noteContent: contentController.text);
                              ApiService().postNotes(note);
                            }
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const NoteList(),
                              ),
                              (route) => false,
                            );
                          }
                        },
                        child: const Text('Add'),
                      )
                    ],
                  ),
                ),
        ));
  }
}
