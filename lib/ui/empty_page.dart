import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatefulWidget {
  @override
  _EmptyPageState createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  bool _play = false;

  @override
  Widget build(BuildContext context) {
    return AudioWidget.assets(
      path: "assets/audios/Tan-Cung-Noi-Nho-Will.mp3",
      play: _play,
      // ignore: deprecated_member_use
      child: RaisedButton(
          child: Text(
            _play ? "pause" : "play",
          ),
          onPressed: () {
            setState(() {
              _play = !_play;
            });
          }
      ),
      onReadyToPlay: (duration) {
        //onReadyToPlay
      },
      onPositionChanged: (current, duration) {
        //onPositionChanged
      },
    );
  }
}
