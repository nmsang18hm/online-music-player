import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';


Widget bottomPlayContainer(AssetsAudioPlayer audioPlayer) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
    child: Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                audioPlayer.getCurrentAudioImage.path,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  audioPlayer.getCurrentAudioTitle,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Barlow'),
                ),
                SizedBox(height: 2.5),
                Text(
                  audioPlayer.getCurrentAudioArtist,
                  style: TextStyle(
                      fontSize: 13, color: Colors.black, fontFamily: 'Barlow'),
                )
              ],
            ),
          ),
          Icon(
            Icons.favorite_outline_rounded,
            color: Colors.black,
          ),
          SizedBox(
            width: 15,
          ),
          IconButton(
              icon: Icon(audioPlayer.isPlaying.valueWrapper.value
                  ? Icons.pause_circle_filled_rounded
                  : Icons.play_circle_fill_rounded),
              iconSize: 35,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              color: Colors.black,
              onPressed: () => audioPlayer.playOrPause())
        ],
      ),
    ),
  );
}