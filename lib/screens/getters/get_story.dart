import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:edonix/req.dart'; // String apiKey = '';

class Datas {
  List<String> links;

  Datas(List<String> links) {
    this.links = links;
  }
}

@override
Future<List> fetchPost() async {
  final response = await http.get(
      'https://api.themoviedb.org/3/tv/airing_today?api_key=' +
          apiKey +
          '&language=en-US&page=1');

  if (response.statusCode == 200) {
    var results = json.decode(response.body)['results'];
    // List<String> tags = results != null ? List.from(results) : null;
    // developer.log(results[0]['original_name']);
    return results;
  } else {
    throw Exception('Failed to load post');
  }
}
