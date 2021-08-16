import 'dart:convert';

import 'package:onlinemusicplayer/entities/song.dart';

class PlaylistEntity {
  String name;
  List<Song> listSong;
  String type;
  PlaylistEntity(String name, List<Song> list, String type) {
    this.name = name;
    listSong = list;
    this.type = type;
  }

  factory PlaylistEntity.fromJson(Map<String, dynamic> data) {
    final parsed =  data['songs'].cast<Map<String, dynamic>>();
    List<Song> list = parsed.map<Song>((json) =>Song.fromJson(json)).toList();
    return PlaylistEntity(data['playlistName'], list, 'shared');
  }
}