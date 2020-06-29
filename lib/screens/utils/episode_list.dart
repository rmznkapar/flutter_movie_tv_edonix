import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:edonix/screens/getters/get_story.dart';

String apiBaseUrl = 'https://image.tmdb.org/t/p/w227_and_h127_bestv2/';
String apiKey = '2c8e3d8e85846891e2bb265dbae3e0d0';

@override
Future<Map> fetchData(String dataId) async {
  final response = await http.get('https://api.themoviedb.org/3/tv/' +
      dataId +
      '/season/1?api_key=' +
      apiKey +
      '&language=en-US&page=1');

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load post');
  }
}

class EpisodeListBox extends StatefulWidget {
  final int showId;
  EpisodeListBox(this.showId);
  @override
  _EpisodeListBoxState createState() => _EpisodeListBoxState(showId);
}

class _EpisodeListBoxState extends State<EpisodeListBox> {
  final int showId;
  _EpisodeListBoxState(this.showId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
        future: fetchData(showId.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new Container(
                padding: EdgeInsets.only(top: 30, left: 20),
                color: Color(0XFF242131),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var episode in snapshot.data['episodes'])
                      Row(
                        children: [
                          Container(
                              width: 150,
                              height: 80,
                              margin:
                                  const EdgeInsets.only(left: 5.0, bottom: 15),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    spreadRadius: 2.5,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 0), // changes position of shadow
                                  ),
                                ],
                                image: DecorationImage(
                                    image: NetworkImage(
                                        apiBaseUrl + episode['still_path']),
                                    fit: (BoxFit.cover)),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                              )),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                        'S:0' +
                                            episode['season_number']
                                                .toString() +
                                            ' | E:0' +
                                            episode['episode_number']
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))),
                                Container(
                                    width: 200,
                                    margin: EdgeInsets.only(left: 10),
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(episode['name'],
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey[400])))
                              ],
                            ),
                          ),
                        ],
                      )
                  ],
                ));
          } else {
            return LinearProgressIndicator();
          }
        });
  }
}
// for (var genre in snapshot.data['genres'])
