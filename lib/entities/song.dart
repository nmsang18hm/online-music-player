import 'package:assets_audio_player/assets_audio_player.dart';

class Song {
  Audio audio;

  Song(String songTitle, String artistName, String albumTitle, String songUrl, String songImageUrl) {
    audio = new Audio(songUrl, metas: Metas(
      title:  songTitle,
      artist: artistName,
      album: albumTitle,
      image: MetasImage.asset(songImageUrl), //can be MetasImage.network
    ));
  }

  factory Song.fromJson(Map<String, dynamic> data) {
    return Song(
      data['songTitle'],
      data['artistName'],
      data['albumTitle'],
      data['songUrl'],
      data['songImageUrl']
    );
  }
}