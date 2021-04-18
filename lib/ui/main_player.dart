import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPlayer extends StatefulWidget {
  @override
  _MainPlayerState createState() => _MainPlayerState();
}

class _MainPlayerState extends State<MainPlayer> {
  @override
  Widget build(BuildContext context) {
    final assetsAudioPlayer = AssetsAudioPlayer();
    final audio = Audio("assets/audios/Tan-Cung-Noi-Nho-Will.mp3",
      metas: Metas(
        title:  "Tan cung noi nho",
        artist: "Will",
        album: "CountryAlbum",
        image: MetasImage.asset("assets/images/artworks-000394925472-n3c8pm-t500x500.jpg"), //can be MetasImage.network
      ),
    );
    assetsAudioPlayer.open(audio, showNotification: true);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50,),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(Icons.arrow_back, color: Colors.grey.shade700, size: 20,),
                ),
                Text(
                  "PLAYING NOW",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(Icons.menu, color: Colors.grey.shade700, size: 20,),
                ),
              ],
            ),
          ),
          SizedBox(height: 40,),
          Center(
            child: Container(
              height: 240,
              width: 240,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(140),
              ),
              padding: EdgeInsets.all(3),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/artworks-000394925472-n3c8pm-t500x500.jpg"), // HARDCODE
                maxRadius: 160,
              ),
            ),
          ),
          SizedBox(height: 30,),
          Text("Tan cung noi nho", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),), // HARDCODE
          SizedBox(height: 8,),
          Text("Will", style: TextStyle(fontSize: 16, color: Colors.grey.shade500, fontWeight: FontWeight.w500),), // HARDCODE
          SizedBox(height: 30,),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("2.25", style: TextStyle(fontSize: 13, color: Colors.grey.shade500, fontWeight: FontWeight.w500),), //HARDCODE
                Text("4.40", style: TextStyle(fontSize: 13, color: Colors.grey.shade500, fontWeight: FontWeight.w500),), //HARDCODE
              ],
            ),
          ),
          Slider(
            min: 0,
            max: 2,
            value: 1,
          ),
          SizedBox(height: 30,),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(Icons.shuffle, size: 20, color: Colors.black,),
                ),
                SizedBox(width: 16,),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(Icons.skip_previous, size: 20, color: Colors.black,),
                ),
                SizedBox(width: 16,),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(Icons.pause, size: 20, color: Colors.white,),
                ),
                SizedBox(width: 16,),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(Icons.skip_next, size: 20, color: Colors.black,),
                ),
                SizedBox(width: 16,),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(Icons.repeat, size: 20, color: Colors.black,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
