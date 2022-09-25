import 'package:flutter/material.dart';
import 'package:noteapp/model/api_response.dart';
import 'package:noteapp/model/note_model.dart';
import 'package:noteapp/model/single_note_model.dart';
import 'package:noteapp/services/api_service.dart';
import 'package:noteapp/view/add_note.dart';
import 'package:noteapp/view/note_delete.dart';

class NoteList extends StatelessWidget {
  const NoteList({super.key});

  String formateDateTime({required DateTime dateTime}) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => Home(
                  noteId: null,
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('view content'),
        ),
        body: FutureBuilder<APIResponse<List<NotesModel>>>(
          future: ApiService().getNotes(),
          builder: (BuildContext context,
              AsyncSnapshot<APIResponse<List<NotesModel>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.error == true) {
              return Center(
                child: Text(snapshot.data!.errormessage.toString()),
              );
            }
            return snapshot.data!.data!.isEmpty
                ? const Center(
                    child: Text('No Data'),
                  )
                : ListView.separated(
                    itemCount: snapshot.data!.data!.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: ValueKey(
                          snapshot.data!.data?[index].noteId,
                        ),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {},
                        confirmDismiss: (direction) async {
                          final result = await showDialog(
                            context: context,
                            builder: (_) {
                              return const DeleteNote();
                            },
                          );
                          if (result) {
                            ApiService().deleteNotes(
                                snapshot.data!.data![index].noteId.toString());
                          }
                          return result;
                        },
                        background: Container(
                          padding: const EdgeInsets.only(left: 16),
                          color: Colors.red,
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.delete,
                              size: 32,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            snapshot.data!.data![index].noteTitle.toString(),
                            style: const TextStyle(color: Colors.blue),
                          ),
                          subtitle: Text(
                            'Last Update on ${formateDateTime(
                              dateTime: snapshot
                                  .data!.data![index].latestEditDateTime!,
                            )}',
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => Home(
                                  noteId: snapshot.data!.data![index].noteId,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
          },
        ));
  }
}
