import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simple_notes_app/DataBase/note_database.dart';
import 'package:simple_notes_app/DataBase/note_model.dart';
import 'package:simple_notes_app/HelperClasses/sendData.dart';

class IndiviualFavouriteNotePage extends StatefulWidget {
  static const pageName = "/pageName";
  VoidCallback callbackForUpdating;
  IndiviualFavouriteNotePage({
    required this.callbackForUpdating,
    super.key,
  });

  @override
  State<IndiviualFavouriteNotePage> createState() =>
      _IndiviualFavouriteNotePageState();
}

class _IndiviualFavouriteNotePageState
    extends State<IndiviualFavouriteNotePage> {
  NoteDataBase noteDataBase = NoteDataBase();
  SendData? data;
  List<NoteModel>? fetchRecord;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data = ModalRoute.of(context)!.settings.arguments as SendData;
    textEditingController1.text = data!.title;
    textEditingController2.text = data!.content;
    log("id = ${data!.id}");
    fetchIsFavourite();
    // fetchRecord!.then((value) => log(value[data!.id].content!));
    // fetchIsFavourite();
    log("${data!.id}");
  }

  bool isFavourite = false;
  bool isUpdate = false;

  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();

  void onClickUpdateIcon() {
    setState(() {
      isUpdate = true;
      noteDataBase.updateNotes(NoteModel(
          title: textEditingController1.text,
          content: textEditingController2.text,
          id: data!.id,
          dateTime: data!.dateTime,
          isFavourite: isFavourite));
    });
  }

  void fetchIsFavourite() async {
    fetchRecord = await noteDataBase.fetchNote(data!.id);
    setState(() {
      isFavourite = fetchRecord![0].isFavourite!;
    });
  }

  void onClickBackIcon() {
    Navigator.of(context).pop;
    widget.callbackForUpdating();
  }

  void onClickFavouriteIcon() {
    setState(() {
      isFavourite = !isFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600,
        leading: InkWell(
            onTap: () {
              log("Clicked on back button");
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
                onTap: onClickFavouriteIcon,
                child: AnimatedCrossFade(
                    firstChild: const Icon(
                      color: Colors.white,
                      Icons.favorite_border,
                      size: 35,
                    ),
                    secondChild: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 30,
                    ),
                    crossFadeState: isFavourite == false
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(seconds: 1))),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
                onTap: onClickUpdateIcon,
                child: AnimatedCrossFade(
                    firstChild: const Icon(
                      color: Colors.white,
                      Icons.upload_file_outlined,
                      size: 35,
                    ),
                    secondChild: const Icon(
                      Icons.upload_file_sharp,
                      size: 30,
                      color: Colors.yellow,
                    ),
                    crossFadeState: isUpdate == false
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(seconds: 1))),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              const Spacer(
                flex: 5,
              ),
              Expanded(
                flex: 10,
                child: TextField(
                  controller: textEditingController1,
                  cursorColor: Colors.red,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    // hintText: 'Title',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 85,
                child: TextField(
                  autocorrect: true,
                  maxLines: 20,
                  controller: textEditingController2,
                  cursorColor: Colors.red,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                    // hintText: 'Type your note here...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              Expanded(
                flex: 8,
                child: Row(
                  children: [
                    const Spacer(
                      flex: 25,
                    ),
                    Expanded(
                        flex: 50,
                        child: Text(
                          data!.dateTime,
                          style: TextStyle(
                              color: Colors.white,
                              backgroundColor: Colors.blue.shade600,
                              fontSize: 20,
                              fontStyle: FontStyle.italic),
                        )),
                    const Spacer(
                      flex: 25,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
