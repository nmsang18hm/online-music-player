import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'main_player.dart';

class HotCard extends StatefulWidget {
  final image;
  final tag;
  HotCard({this.image,this.tag});
  @override
  _HotCardState createState() => _HotCardState();
}

class _HotCardState extends State<HotCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainPlayer(
                audio: Audio("assets/audios/Tan-Cung-Noi-Nho-Will.mp3",
                  metas: Metas(
                    title:  "Tan cung noi nho",
                    artist: "Will",
                    album: "CountryAlbum",
                    image: MetasImage.asset("assets/images/artworks-000394925472-n3c8pm-t500x500.jpg"), //can be MetasImage.network
                  ),
                ),
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(tag: widget.tag,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/p${widget.image}.jpg",
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "My Classic List",
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
                  Text("10 Tracks")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}