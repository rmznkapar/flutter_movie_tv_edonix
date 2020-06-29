import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:edonix/screens/show.dart';
import 'package:edonix/req.dart'; // String apiKey = '';

// import 'package:edonix/screens/getters/get_story.dart';

int maxPosts = 5;
String apiBaseUrl = 'http://image.tmdb.org/t/p/w185/';

@override
Future<List> fetchPost() async {
  final response = await http.get(
      'https://api.themoviedb.org/3/list/3700344?api_key=' +
          apiKey +
          '&language=en-US');

  if (response.statusCode == 200) {
    return json.decode(response.body)['items'];
  } else {
    throw Exception('Failed to load post');
  }
}

class ContinueBox extends StatefulWidget {
  @override
  _ContinueBoxState createState() => _ContinueBoxState();
}

class _ContinueBoxState extends State<ContinueBox> {
  List posts = new List<int>.generate(maxPosts, (i) => i);

  var continueWidget =
      (Map post, BuildContext context, int reqType) => GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return Show(post['id'], post['poster_path']);
                // if (reqType == 0) {
                //   return Show(post['id'], post['poster_path']);
                // }
                // else {
                //   // return Movie(post['id'], post['poster_path']);
                // }
              }));
            },
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  width: 200.0,
                  margin: const EdgeInsets.only(left: 15.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(apiBaseUrl + post['poster_path']),
                        fit: (BoxFit.cover)),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: new Container(
                    width: 50.0,
                    height: 100.0,
                    margin: const EdgeInsets.only(left: 20.0, top: 100.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 0),
                        ),
                      ],
                      color: Color(0XFFA065F3),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListView(children: [
                      Text(post['original_name'],
                          style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                      Container(
                        width: 10.0,
                        height: 7.5,
                        margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                        decoration: BoxDecoration(
                          color: Color(0XFF935FDF),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                            height: 7.5,
                            margin: const EdgeInsets.only(right: 75.0),
                            decoration: BoxDecoration(
                              color: Color(0XFFFF8DD9),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 7.0),
                        child: Text("S01 E07",
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0XFFC7ABEF))),
                      ),
                    ]),
                  ),
                ),
                Positioned(
                  bottom: 7.5,
                  right: -5.0,
                  child: MaterialButton(
                    onPressed: () {},
                    color: Color(0XFFFF8DD9),
                    textColor: Colors.white,
                    child: Icon(
                      Icons.play_arrow,
                      size: 40,
                    ),
                    padding: EdgeInsets.all(7.5),
                    shape: CircleBorder(),
                  ),
                )
              ],
            ),
          );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: fetchPost(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new Container(
              height: 225.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (var post in posts)
                    continueWidget(snapshot.data[post], context, 1)
                ],
              ),
            );
          } else {
            return LinearProgressIndicator();
          }
        });
  }
}
