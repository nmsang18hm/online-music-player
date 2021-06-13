import 'package:flutter/material.dart';
import 'playlist.dart';
import 'package:onlinemusicplayer/model/song.dart';

class RecommentCard extends StatelessWidget {
  final Song song;
  RecommentCard({this.song});
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
                height: 150,
                width: 300,
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
              builder: (context) => Episode6PlaylistView(),
            ));
      },
    );
  }
}