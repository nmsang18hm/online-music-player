import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:onlinemusicplayer/entities/playlist.dart';
import 'package:onlinemusicplayer/ui/home_page.dart';
import 'package:onlinemusicplayer/ui/playlist_page.dart';

class HotPlaylistCard extends StatefulWidget {
  final PlaylistEntity playlistEntity;
  AssetsAudioPlayer assetsAudioPlayer;
  HotPlaylistCard({this.playlistEntity, this.assetsAudioPlayer});

  @override
  _HotPlaylistCardState createState() => _HotPlaylistCardState(assetsAudioPlayer);
}

class _HotPlaylistCardState extends State<HotPlaylistCard> {
  AssetsAudioPlayer assetsAudioPlayer;
  String imageURL = 'assets/images/playlist.png';

  _HotPlaylistCardState(AssetsAudioPlayer assetsAudioPlayer) {
    this.assetsAudioPlayer = assetsAudioPlayer;

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.playlistEntity.listSong.length > 0) {
      setState(() {
        imageURL = widget.playlistEntity.listSong[0].audio.metas.image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlaylistPage(widget.playlistEntity, assetsAudioPlayer),
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
                    imageURL,
                    height: 185,
                    width: 185,
                    fit: BoxFit.cover,
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  widget.playlistEntity.name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.favorite,
                    size: 15,
                  ),
                  Text("100"),
                  Spacer(),
                  Icon(
                    Icons.track_changes,
                    size: 15,
                  ),
                  Text(widget.playlistEntity.listSong.length.toString() + " Tracks")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}