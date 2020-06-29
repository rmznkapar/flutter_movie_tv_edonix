import 'package:flutter/material.dart';
import 'package:edonix/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color backgroundcolor = const Color(0XFF242131);
    return MaterialApp(
      title: 'Edonix',
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundcolor,
        primaryColor: backgroundcolor,
        accentColor: Colors.deepPurpleAccent[700],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
            title: Center(child: Text('Edonix')),
            elevation: 0,
            backgroundColor: Colors.transparent),
        body: new Home(),
      ),
    );
  }
}
