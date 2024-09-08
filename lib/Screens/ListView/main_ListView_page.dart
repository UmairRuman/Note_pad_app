import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_notes_app/DataBase/note_database.dart';
import 'package:simple_notes_app/DataBase/note_model.dart';
import 'package:simple_notes_app/Decoration/container_decoration.dart';
import 'package:simple_notes_app/Drawer/app_drawer.dart';
import 'package:simple_notes_app/HelperClasses/customSearchBar.dart';
import 'package:simple_notes_app/HelperClasses/sendData.dart';
import 'package:simple_notes_app/Screens/GridView/mainGirdViewPage.dart';
import 'package:simple_notes_app/Screens/ListView/indiviual_notePage.dart';
import 'package:simple_notes_app/Screens/ListView/note_page.dart';

class MainListViewPage extends StatefulWidget {
  const MainListViewPage({super.key});

  @override
  State<MainListViewPage> createState() => _MainListViewPageState();
}

class _MainListViewPageState extends State<MainListViewPage> {
  DateTime dateTime = DateTime.now();
  String formattedDateTime = "";
  NoteDataBase noteDataBase = NoteDataBase();
  List<NoteModel>? list;

  @override
  void initState() {
    super.initState();
    _loadNotes();
    updateState();
  }

  Future<void> _loadNotes() async {
    List<NoteModel> notes = await noteDataBase.fetchNotes();
    setState(() {
      list = notes;
    });
  }

  void updateState() async {
    log("Update State Method Invoked");
    List<NoteModel> notes = await noteDataBase.fetchNotes();
    list = notes;
    setState(() {});
  }

  void onTapAddNotes() {
    formattedDateTime = DateFormat('yyyy-MM-dd   HH:mm').format(dateTime);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return NotePage(
          localTime: formattedDateTime,
          onReloadState: _loadNotes,
        );
      },
    ));
  }

  void onClickOnGridView() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const MainGridViewPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    updateState();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      drawer: const MyDrawer(),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue.shade600,
        title: const Text(
          "NotePad App",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: onClickOnGridView,
              child: const Icon(
                size: 30,
                Icons.grid_view_outlined,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: () {
                showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(list: list));
              },
              child: const Icon(
                size: 30,
                Icons.search,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: list == null
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  itemCount: list!.length,
                  itemBuilder: (context, index) {
                    NoteModel note = list![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onLongPress: () {},
                        onTap: () {
                          int id = list![index].id!;
                          String content = list![index].content!;
                          String title = list![index].title!;
                          String dateTime = list![index].dateTime!;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return IndiviualNotePage(
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
                        child: Container(
                          decoration: MyDecoration.containerDecoration,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
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
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
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
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
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
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 30),
        child: FloatingActionButton(
          onPressed: onTapAddNotes,
          backgroundColor: Colors.blue.shade600,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
