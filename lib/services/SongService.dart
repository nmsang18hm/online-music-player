import 'dart:convert';

import 'package:onlinemusicplayer/entities/song.dart';
import 'package:http/http.dart' as http;

List<Song> parseSongs(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Song>((json) =>Song.fromJson(json)).toList();
}

Future<List<Song>> fetchSongs() async {
  final response = await http.get(Uri.parse('http://18.116.34.168:8080/get-top-ten-music'));
  if (response.statusCode == 200) {
    return parseSongs(response.body);
  } else {
    throw Exception('Unable to fetch songs from the REST API');
  }
}

Future<List<Song>> searchSongs(String data) async {
  final response = await http.post(
      Uri.parse('http://18.116.34.168:8080/search-music/'),
      headers: <String, String>{'Content-Type': 'application/json',},
      body: jsonEncode(<String, String>{
        'type': 'song',
        'data': data,
      }),
  );

  if (response.statusCode == 200) {
    return parseSongs(response.body);
  } else {
    throw Exception('Unable to fetch songs from the REST API');
  }
}