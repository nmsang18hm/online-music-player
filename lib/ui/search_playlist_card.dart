import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:onlinemusicplayer/entities/playlist.dart';
import 'package:onlinemusicplayer/ui/playlist_page.dart';

class SearchPlaylistCard extends StatelessWidget {
  final PlaylistEntity playlistEntity;
  AssetsAudioPlayer assetsAudioPlayer;
  SearchPlaylistCard({this.playlistEntity, this.assetsAudioPlayer});
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
                  playlistEntity.listSong[0].audio.metas.image.path,
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
                    playlistEntity.name,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    playlistEntity.listSong.length.toString() + " Tracks",
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
              builder: (context) => PlaylistPage(playlistEntity, assetsAudioPlayer),
            ));
      },
    );
  }
}