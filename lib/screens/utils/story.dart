import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:edonix/screens/show.dart';
// import 'package:edonix/screens/getters/get_story.dart';

int maxStories = 10;
String apiBaseUrl = 'http://image.tmdb.org/t/p/w185/';

@override
Future<List> fetchPost() async {
  final response = await http.get(
      'https://api.themoviedb.org/3/tv/airing_today?api_key=2c8e3d8e85846891e2bb265dbae3e0d0&language=en-US&page=1');

  if (response.statusCode == 200) {
    return json.decode(response.body)['results'];
  } else {
    throw Exception('Failed to load post');
  }
}

class StoryBox extends StatefulWidget {
  @override
  _StoryBoxState createState() => _StoryBoxState();
}

class _StoryBoxState extends State<StoryBox> {
  List stories = new List<int>.generate(maxStories, (i) => i);

  var storyWidget = (Map story, context) => GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return Show(story['id'], story['poster_path']);
            // if (reqType == 0) {
            //   return Show(post['id'], post['poster_path']);
            // }
            // else {
            //   // return Movie(post['id'], post['poster_path']);
            // }
          }));
        },
        child: Container(
            width: 65.0,
            height: 65.0,
            margin: const EdgeInsets.only(left: 15.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 0),
                ),
              ],
              image: DecorationImage(
                  image: NetworkImage(apiBaseUrl + story['poster_path']),
                  fit: (BoxFit.cover)),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
            )),
      );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: fetchPost(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new Container(
              height: 65.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (var story in stories)
                    storyWidget(snapshot.data[story], context)
                ],
              ),
            );
          } else {
            return LinearProgressIndicator();
          }
        });
  }
}
