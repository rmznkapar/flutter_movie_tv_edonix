import 'dart:async';
import 'dart:convert';
import 'package:edonix/screens/movie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:edonix/screens/show.dart';
// import 'package:edonix/screens/getters/get_story.dart';

int maxPost = 10;
String apiBaseUrl = 'http://image.tmdb.org/t/p/w185/';

@override
Future<List> fetchPost(int reqType) async {
  List links = [
    'https://api.themoviedb.org/3/discover/tv?api_key=2c8e3d8e85846891e2bb265dbae3e0d0&language=en-US&sort_by=popularity.desc&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false',
    'https://api.themoviedb.org/3/trending/movie/week?api_key=2c8e3d8e85846891e2bb265dbae3e0d0'
  ];
  final response = await http.get(links[reqType]);
  if (response.statusCode == 200) {
    return json.decode(response.body)['results'];
  } else {
    throw Exception('Failed to load post');
  }
}

class ListItemBox extends StatefulWidget {
  final int reqType;
  ListItemBox(this.reqType);
  @override
  _ListItemBoxState createState() => _ListItemBoxState(reqType);
}

class _ListItemBoxState extends State<ListItemBox> {
  final int reqType;
  _ListItemBoxState(this.reqType);

  List posts = new List<int>.generate(maxPost, (i) => i);
  var storyWidget =
      (Map post, BuildContext context, int reqType) => GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              if (reqType == 0) {
                return Show(post['id'], post['poster_path']);
              } else {
                return Movie(post['id'], post['poster_path']);
              }
            }));
          },
          child: Container(
              width: 160.0,
              margin: const EdgeInsets.only(left: 15.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
                image: DecorationImage(
                    image: NetworkImage(apiBaseUrl + post['poster_path']),
                    fit: (BoxFit.cover)),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
              )));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: fetchPost(reqType),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("ERROR: ${snapshot.error}");
          }
          if (snapshot.hasData) {
            return new Container(
              height: 225.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (var post in posts)
                    storyWidget(snapshot.data[post], context, reqType)
                ],
              ),
            );
          } else {
            return LinearProgressIndicator();
          }
        });
  }
}
