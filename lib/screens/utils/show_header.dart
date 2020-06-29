import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:edonix/req.dart'; // String apiKey = '';

// import 'package:edonix/screens/getters/get_story.dart';

String apiBaseUrl = 'http://image.tmdb.org/t/p/w600/';

@override
Future<Map> fetchData(String dataId, String dataType) async {
  final response = await http.get('https://api.themoviedb.org/3/' +
      dataType +
      '/' +
      dataId +
      '?api_key=' +
      apiKey +
      '&language=en-US&page=1');

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load post');
  }
}

class ShowHeaderBox extends StatefulWidget {
  final int showId;
  final String dataType;
  ShowHeaderBox(this.showId, this.dataType);
  @override
  _ShowHeaderBoxState createState() => _ShowHeaderBoxState(showId, dataType);
}

class _ShowHeaderBoxState extends State<ShowHeaderBox> {
  final int showId;
  final String dataType;
  _ShowHeaderBoxState(this.showId, this.dataType);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
        future: fetchData(showId.toString(), dataType),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new Stack(overflow: Overflow.values[0], children: [
              Container(
                  decoration:
                      BoxDecoration(color: Color(0XFF242131), boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, -10), // changes position of shadow
                    ),
                  ]),
                  padding: EdgeInsets.only(top: 30, left: 20, bottom: 25),
                  // color: Color(0XFF242131),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Text(
                              snapshot.data['name'] ?? snapshot.data['title'],
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                      Container(
                        margin: EdgeInsets.only(top: 15, bottom: 15),
                        child: Row(
                          children: [
                            for (var genre in snapshot.data['genres'])
                              Text(
                                genre['name'] + '  ',
                                style: TextStyle(color: Color(0X94C7ABEF)),
                              )
                          ],
                        ),
                      ),
                      Container(
                          child: Text(snapshot.data['overview'],
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey))),
                    ],
                  )),
              Positioned(
                top: -25,
                right: 25,
                child: MaterialButton(
                  onPressed: () {},
                  color: Color(0XFFFF8DD9),
                  textColor: Colors.white,
                  child: Icon(
                    Icons.play_arrow,
                    size: 50,
                  ),
                  padding: EdgeInsets.all(8.5),
                  shape: CircleBorder(),
                ),
              ),
            ]);
          } else {
            return LinearProgressIndicator();
          }
        });
  }
}
