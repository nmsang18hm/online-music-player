import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:onlinemusicplayer/ui/main_player.dart';
import 'playlist_page.dart';
import 'package:onlinemusicplayer/entities/song.dart';

class RecommentCard extends StatelessWidget {
  final Song song;
  AssetsAudioPlayer assetsAudioPlayer;
  RecommentCard({this.song, this.assetsAudioPlayer});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                song.audio.metas.image.path,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              song.audio.metas.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(song.audio.metas.artist)
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainPlayer(listAudio: [song.audio], assetsAudioPlayer: assetsAudioPlayer,),
            ));
      },
    );
  }
}