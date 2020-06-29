import 'package:flutter/material.dart';

class CatTitle extends StatelessWidget {
  final String title;
  CatTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 20.0, top: 30.0, bottom: 15.0),
        child: Text(title,
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white)));
  }
}
