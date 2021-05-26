import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPlayer extends StatefulWidget {
  Audio audio;
  MainPlayer({Key key, this.audio}) : super(key: key);
  @override
  _MainPlayerState createState() => _MainPlayerState(audio);
}

class _MainPlayerState extends State<MainPlayer> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  Duration duration = Duration(minutes: 0);
  Duration position = Duration(minutes: 0);
  double valuePosition = 0.0;
  bool isSliderChanging = false;

  IconData iconPlayPause = Icons.pause_circle_outline;

  _MainPlayerState(Audio audio){
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
      if (!isSliderChanging) {
        setState(() {
          valuePosition = position.inSeconds.toDouble();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
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
                InkWell(
                  child: Container(
                    height: 50,
                    width: 50,
                    child: Icon(Icons.arrow_back, color: Colors.white, size: 30,),
                  ),
                ),
                Text(
                  "PLAYING NOW",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  child: Icon(Icons.menu, color: Colors.white, size: 23,),
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
            activeColor: Colors.grey,
            inactiveColor: Colors.white,
            min: 0,
            max: duration.inSeconds.toDouble(),
            value: valuePosition,
            onChanged: (value) {
              setState(() {
                valuePosition = value;
              });
            },
            onChangeStart: (value) {
              setState(() {
                isSliderChanging = true;
              });
            },
            onChangeEnd: (value) {
              setState(() {
                isSliderChanging = false;
              });
              assetsAudioPlayer.pause();
              assetsAudioPlayer.seek(Duration(seconds: value.toInt()));
              assetsAudioPlayer.play();
            },
          ),
          SizedBox(height: 30,),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  child: Icon(Icons.shuffle, size: 30, color: Colors.white,),
                ),
                SizedBox(width: 16,),
                Container(
                  height: 60,
                  width: 60,
                  child: Icon(Icons.skip_previous, size: 30, color: Colors.white,),
                ),
                SizedBox(width: 16,),
                InkWell(
                  onTap: (){
                    /*assetsAudioPlayer.pause();
                    setState(() {
                      iconPlayPause = Icons.play_arrow;
                    });*/
                    if (iconPlayPause == Icons.pause_circle_outline) {
                      assetsAudioPlayer.pause();
                      setState(() {
                        iconPlayPause = Icons.play_circle_outline;
                      });
                    }
                    else {
                      assetsAudioPlayer.play();
                      setState(() {
                        iconPlayPause = Icons.pause_circle_outline;
                      });
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    child: Icon(iconPlayPause, size: 60, color: Colors.white,),
                  ),
                ),
                SizedBox(width: 16,),
                Container(
                  height: 60,
                  width: 60,
                  child: Icon(Icons.skip_next, size: 30, color: Colors.white,),
                ),
                SizedBox(width: 16,),
                Container(
                  height: 60,
                  width: 60,
                  child: Icon(Icons.repeat, size: 30, color: Colors.white,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
