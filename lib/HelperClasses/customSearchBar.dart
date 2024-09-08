import 'package:flutter/material.dart';
import 'package:simple_notes_app/DataBase/note_database.dart';
import 'package:simple_notes_app/DataBase/note_model.dart';
import 'package:simple_notes_app/Decoration/container_decoration.dart';
import 'package:simple_notes_app/HelperClasses/sendData.dart';
import 'package:simple_notes_app/Screens/ListView/indiviual_notePage.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<NoteModel>? list;
  NoteDataBase noteDataBase = NoteDataBase();
  CustomSearchDelegate({required this.list});
  List<String>? titleList;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    titleList = list!.map((e) => e.title!).toList();
    List<String> matchQuery = [];
    for (var notesTitle in titleList!) {
      if (notesTitle.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(notesTitle);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    titleList = list!.map((e) => e.title!).toList();
    List<String> matchQuery = [];
    for (var notesTitle in titleList!) {
      if (notesTitle.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(notesTitle);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return InkWell(
          onTap: () async {
            var dataList = await noteDataBase.fetchNoteByTitle(result);
            int id = dataList[0].id!;
            String content = dataList[0].content!;
            String title = dataList[0].title!;
            String dateTime = dataList[0].dateTime!;
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return IndiviualNotePage(
                    callbackForUpdating: () {},
                  );
                },
                settings: RouteSettings(
                    arguments: SendData(
                        dateTime: dateTime,
                        content: content,
                        title: title,
                        id: id))));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              decoration: MyDecoration.containerDecoration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        result,
                        style: const TextStyle(
                            color: Color.fromARGB(95, 69, 67, 67),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
