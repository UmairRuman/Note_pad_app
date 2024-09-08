import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simple_notes_app/DataBase/note_database.dart';
import 'package:simple_notes_app/DataBase/note_model.dart';

class NotePage extends StatefulWidget {
  final String localTime;
  VoidCallback onReloadState;
  NotePage({super.key, required this.onReloadState, required this.localTime});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  bool isFavourite = false;
  bool isSaved = false;
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  NoteDataBase noteDataBase = NoteDataBase();
  void onClickSaveIcon() {
    setState(() {
      String title = textEditingController1.text;
      String content = textEditingController2.text;
      log(widget.localTime);
      if (isSaved) {
        noteDataBase.updateNotes(NoteModel(
            title: title,
            content: content,
            isFavourite: isFavourite,
            dateTime: widget.localTime));
      } else {
        noteDataBase.insertNotes(NoteModel(
            title: title,
            content: content,
            isFavourite: isFavourite,
            dateTime: widget.localTime));
      }
      isSaved = true;
    });
  }

  void onClickBackIcon() {
    widget.onReloadState();
    Navigator.of(context).pop;
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
              widget.onReloadState();
            },
            child: const Icon(
              color: Colors.white,
              Icons.arrow_back,
              size: 30,
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
                      size: 30,
                    ),
                    secondChild: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    crossFadeState: isFavourite == false
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(seconds: 1))),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
                onTap: onClickSaveIcon,
                child: AnimatedCrossFade(
                    firstChild: const Icon(
                      color: Colors.white,
                      Icons.save_outlined,
                      size: 30,
                    ),
                    secondChild: const Icon(
                      Icons.save_rounded,
                      size: 30,
                      color: Colors.green,
                    ),
                    crossFadeState: isSaved == false
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
                    hintText: 'Title',
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
                flex: 75,
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
                    hintText: 'Type your note here...',
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
                          widget.localTime,
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
