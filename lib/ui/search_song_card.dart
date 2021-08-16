import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:onlinemusicplayer/entities/song.dart';

import 'main_player.dart';

class SearchSongCard extends StatelessWidget {
  final Song song;
  AssetsAudioPlayer assetsAudioPlayer;
  SearchSongCard({this.song, this.assetsAudioPlayer});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  song.audio.metas.image.path,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.audio.metas.title,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    song.audio.metas.artist,
                    style: TextStyle(color: Colors.white.withOpacity(0.8)),
                  )
                ],
              ),
            ),
            Spacer(),
            Column(
              children: [Icon(Icons.favorite), Text("200")],
            )
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