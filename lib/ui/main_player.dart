import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPlayer extends StatefulWidget {
  @override
  _MainPlayerState createState() => _MainPlayerState();
}

class _MainPlayerState extends State<MainPlayer> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  Audio audio;
  Duration duration = Duration(minutes: 0);
  Duration position = Duration(minutes: 0);

  IconData iconPlayPause;

  _MainPlayerState(){
    audio = Audio("assets/audios/Tan-Cung-Noi-Nho-Will.mp3",
      metas: Metas(
        title:  "Tan cung noi nho",
        artist: "Will",
        album: "CountryAlbum",
        image: MetasImage.asset("assets/images/artworks-000394925472-n3c8pm-t500x500.jpg"), //can be MetasImage.network
      ),
    );
    iconPlayPause = Icons.pause;
    assetsAudioPlayer.open(audio, showNotification: true);
    // Notice
    assetsAudioPlayer.current.listen((playingAudio) {
      setState(() {
        duration = playingAudio.audio.duration;
      });
    });
    // Notice
    assetsAudioPlayer.currentPosition.listen((currentPosition) {
      setState(() {
        position = currentPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(position.toString().split('.').first.replaceFirst("0:", ""), style: TextStyle(fontSize: 16, color: Colors.grey.shade500, fontWeight: FontWeight.w500),), //HARDCODE
                Text(duration.toString().split('.').first.replaceFirst("0:", ""), style: TextStyle(fontSize: 16, color: Colors.grey.shade500, fontWeight: FontWeight.w500),), //HARDCODE
              ],
            ),
          ),
          Slider(
            min: 0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds.toDouble(),
          ),
          SizedBox(height: 30,),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(Icons.shuffle, size: 20, color: Colors.black,),
                ),
                SizedBox(width: 16,),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(Icons.skip_previous, size: 20, color: Colors.black,),
                ),
                SizedBox(width: 16,),
                InkWell(
                  onTap: (){
                    /*assetsAudioPlayer.pause();
                    setState(() {
                      iconPlayPause = Icons.play_arrow;
                    });*/
                    if (iconPlayPause == Icons.pause) {
                      assetsAudioPlayer.pause();
                      setState(() {
                        iconPlayPause = Icons.play_arrow;
                      });
                    }
                    else {
                      assetsAudioPlayer.play();
                      setState(() {
                        iconPlayPause = Icons.pause;
                      });
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(iconPlayPause, size: 20, color: Colors.white,),
                  ),
                ),
                SizedBox(width: 16,),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(Icons.skip_next, size: 20, color: Colors.black,),
                ),
                SizedBox(width: 16,),
                Container(
                  height: 60,
                  width: 60,
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
