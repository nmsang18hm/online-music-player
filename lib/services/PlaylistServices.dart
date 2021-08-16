import 'dart:convert';

import 'package:onlinemusicplayer/entities/playlist.dart';
import 'package:http/http.dart' as http;

Future<PlaylistEntity> searchPlaylists(String data) async {
  final response = await http.post(
    Uri.parse('http://18.116.34.168:8080/search-music/'),
    headers: <String, String>{'Content-Type': 'application/json',},
    body: jsonEncode(<String, String>{
      'type': 'playlist',
      'data': data,
    }),
  );

  if (response.statusCode == 200) {
    return parsePlaylists(response.body);
  } else {
    throw Exception('Unable to fetch songs from the REST API');
  }
}

PlaylistEntity parsePlaylists(String responseBody) {
  Map<String, dynamic> parsed = json.decode(responseBody).cast<String, dynamic>();
  return PlaylistEntity.fromJson(parsed);
}