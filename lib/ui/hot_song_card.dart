import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:onlinemusicplayer/entities/song.dart';
import 'main_player.dart';

class HotSongCard extends StatefulWidget {
  final Song song;
  AssetsAudioPlayer assetsAudioPlayer;
  HotSongCard({this.song, this.assetsAudioPlayer});
  @override
  _HotSongCardState createState() => _HotSongCardState(assetsAudioPlayer);
}

class _HotSongCardState extends State<HotSongCard> {
  AssetsAudioPlayer assetsAudioPlayer;
  _HotSongCardState(AssetsAudioPlayer assetsAudioPlayer) {
    this.assetsAudioPlayer = assetsAudioPlayer;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainPlayer(listAudio: [widget.song.audio], assetsAudioPlayer: assetsAudioPlayer,),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    widget.song.audio.metas.image.path,
                    height: 185,
                    width: 185,
                    fit: BoxFit.cover,
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  widget.song.audio.metas.title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Text(widget.song.audio.metas.artist),
                  Spacer(),
                  Icon(
                    Icons.favorite,
                    size: 15,
                  ),
                  Text("100"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}