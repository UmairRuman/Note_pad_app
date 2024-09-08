import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simple_notes_app/DataBase/note_database.dart';
import 'package:simple_notes_app/DataBase/note_model.dart';
import 'package:simple_notes_app/Decoration/container_decoration.dart';
import 'package:simple_notes_app/Drawer/indiviual_favourite_Note_page.dart';
import 'package:simple_notes_app/HelperClasses/sendData.dart';

class FavouriteNotes extends StatefulWidget {
  const FavouriteNotes({super.key});

  @override
  State<FavouriteNotes> createState() => _FavouriteNotesState();
}

class _FavouriteNotesState extends State<FavouriteNotes> {
  NoteDataBase noteDataBase = NoteDataBase();
  List<NoteModel>? list;
  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void updateState() async {
    log("Update State Method Invoked");
    List<NoteModel> notes = await noteDataBase.fetchNotes();
    list = notes;
    setState(() {});
  }

  Future<void> _loadNotes() async {
    // Fetch notes and update the list
    List<NoteModel> notes = await noteDataBase.fetchNotes();
    setState(() {
      list = notes;
    });

    log(" title : ${list![0].title}");
  }

  @override
  Widget build(BuildContext context) {
    updateState();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade600,
        title: const Text(
          "Favourite Notes",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: InkWell(
          onTap: Navigator.of(context).pop,
          child: const Icon(
            color: Colors.white,
            Icons.arrow_back,
            size: 30,
          ),
        ),
      ),
      body: list == null
          ? const CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: list!.length,
                itemBuilder: (context, index) {
                  NoteModel note = list![index];
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: InkWell(
                      onTap: () {
                        int id = list![index].id!;
                        String content = list![index].content!;
                        String title = list![index].title!;
                        String dateTime = list![index].dateTime!;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return IndiviualFavouriteNotePage(
                                callbackForUpdating: updateState,
                              );
                            },
                            settings: RouteSettings(
                                arguments: SendData(
                                    dateTime: dateTime,
                                    content: content,
                                    title: title,
                                    id: id))));
                      },
                      child: note.isFavourite == true
                          ? Container(
                              // constraints: const BoxConstraints(
                              //     minHeight: 50,
                              //     minWidth: 200,
                              //     maxWidth: 200,
                              //     maxHeight: 200),
                              decoration: MyDecoration.containerDecoration,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        note.title!,
                                        style: const TextStyle(
                                          color: Color.fromARGB(95, 69, 67, 67),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "${note.content} ",
                                        style: const TextStyle(
                                          color: Color.fromARGB(95, 62, 60, 60),
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "${note.dateTime} ",
                                        style: const TextStyle(
                                          color: Color.fromARGB(95, 62, 60, 60),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
