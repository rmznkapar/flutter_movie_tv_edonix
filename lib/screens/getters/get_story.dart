import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Datas {
  List<String> links;

  Datas(List<String> links) {
    this.links = links;
  }
}

@override
Future<List> fetchPost() async {
  final response = await http.get(
      'https://api.themoviedb.org/3/tv/airing_today?api_key=2c8e3d8e85846891e2bb265dbae3e0d0&language=en-US&page=1');

  if (response.statusCode == 200) {
    var results = json.decode(response.body)['results'];
    // List<String> tags = results != null ? List.from(results) : null;
    // developer.log(results[0]['original_name']);
    return results;
  } else {
    throw Exception('Failed to load post');
  }
}
