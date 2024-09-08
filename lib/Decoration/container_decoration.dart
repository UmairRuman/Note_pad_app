import 'package:flutter/material.dart';

class MyDecoration {
  static Decoration containerDecoration = BoxDecoration(
    color: Color.fromARGB(255, 255, 254, 254),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      width: 1,
      color: const Color.fromARGB(255, 153, 141, 141),
      style: BorderStyle.solid,
    ),
    // boxShadow: const [
    //   BoxShadow(
    //     color: Colors.grey,
    //     offset: Offset(5, 5),
    //     blurRadius: 5,
    //   ),
    // ],
  );
}
