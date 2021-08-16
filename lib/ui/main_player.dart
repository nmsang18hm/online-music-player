import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlinemusicplayer/database/db_services.dart';

class MainPlayer extends StatefulWidget {
  List<Audio> listAudio;
  AssetsAudioPlayer assetsAudioPlayer;
  MainPlayer({Key key, this.listAudio, this.assetsAudioPlayer}) : super(key: key);
  @override
  _MainPlayerState createState() => _MainPlayerState(listAudio, assetsAudioPlayer);
}

class _MainPlayerState extends State<MainPlayer> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  AssetsAudioPlayer assetsAudioPlayer;
  List<Audio> listAudio;
  Duration duration = Duration(minutes: 0);
  Duration position = Duration(minutes: 0);
  double valuePosition = 0.0;
  bool isSliderChanging = false;
  bool isUsed = true;

  StreamSubscription subscriptionCurrPos;
  StreamSubscription subscription;

  IconData iconPlayPause = Icons.pause_circle_outline;
  Color colorShuffle = Colors.white;
  Color colorLoopMode = Colors.white;

  List<String> playlists = [];

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 15))..repeat();
    getPlaylists();
  }

  void getPlaylists() async {
    List<Map<String, dynamic>> rows = await DatabaseHelper.instance.getAllPlaylist();
    rows.forEach((element) {
      playlists.add(element['playlist_name']);
    });
  }

  _MainPlayerState(List<dynamic> listAudio, AssetsAudioPlayer assetsAudioPlayer){
    this.assetsAudioPlayer = assetsAudioPlayer;
    if(listAudio != null) {
      this.listAudio = listAudio;
      assetsAudioPlayer.stop();
      assetsAudioPlayer.open(Playlist(audios: listAudio), loopMode: LoopMode.playlist, showNotification: true);
    }
    // Notice
    assetsAudioPlayer.current.listen((event) {
        setState(() {
          duration = event.audio.duration;
        });
    });

    subscription = assetsAudioPlayer.isPlaying.listen((event) {
      if(event) {
        setState(() {
          iconPlayPause = Icons.pause_circle_outline;
        });
      }
      else {
        setState(() {
          iconPlayPause = Icons.play_circle_outline;
        });
      }
    });
    
    // Notice
    subscriptionCurrPos = assetsAudioPlayer.currentPosition.listen((currentPosition) {
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
    if(assetsAudioPlayer.getCurrentAudioImage != null) {
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
                    onTap: () {
                      Navigator.pop(context);
                      subscriptionCurrPos.cancel();
                      subscription.cancel();
                    },
                  ),
                  Text(
                    "PLAYING NOW",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  PopupMenuButton(
                    itemBuilder: (BuildContext bc) {
                      return playlists.map((e) => PopupMenuItem(child: Text(e), value: e,)).toList();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      child: Icon(Icons.add_circle_outline, color: Colors.white, size: 30,),
                    ),
                    onSelected: (value) {
                      DatabaseHelper.instance.insertSong({
                        'song_name' : assetsAudioPlayer.getCurrentAudioTitle,
                        'playlist_name' : value,
                        'artist' : assetsAudioPlayer.getCurrentAudioArtist,
                        'album' : assetsAudioPlayer.getCurrentAudioAlbum,
                        'url' : assetsAudioPlayer.current.value.audio.audio.path,
                        'image' : assetsAudioPlayer.current.value.audio.audio.metas.image.path
                      });
                    },
                  )
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
                child: AnimatedBuilder(
                  animation: animationController,
                  builder: (_, child) {
                    return Transform.rotate(
                      angle: animationController.value * 2 * 3.1415,
                      child: child,
                    );
                  },
                  child: CircleAvatar(
                    backgroundImage: Image.asset(assetsAudioPlayer.getCurrentAudioImage.path).image,
                    maxRadius: 160,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Text(assetsAudioPlayer.getCurrentAudioTitle, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
            SizedBox(height: 8,),
            Text(assetsAudioPlayer.getCurrentAudioArtist, style: TextStyle(fontSize: 16, color: Colors.grey.shade500, fontWeight: FontWeight.w500),),
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
              InkWell(
              child: Container(
              height: 60,
                width: 60,
                child: Icon(Icons.shuffle, size: 30, color: colorShuffle,),
              ),
              onTap: () {
                if(colorShuffle == Colors.white) {
                  assetsAudioPlayer.toggleShuffle();
                  setState(() {
                    colorShuffle = Colors.black;
                  });
                }
                else {
                  assetsAudioPlayer.toggleShuffle();
                  setState(() {
                    colorShuffle = Colors.white;
                  });
                }
              },
            ),
                  SizedBox(width: 16,),
                  InkWell(
                    child: Container(
                      height: 60,
                      width: 60,
                      child: Icon(Icons.skip_previous, size: 30, color: Colors.white,),
                    ),
                    onTap: () {
                      assetsAudioPlayer.previous();
                    },
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
                  InkWell(
                    child: Container(
                      height: 60,
                      width: 60,
                      child: Icon(Icons.skip_next, size: 30, color: Colors.white,),
                    ),
                    onTap: () {
                      assetsAudioPlayer.next();
                    },
                  ),
                  SizedBox(width: 16,),
                  InkWell(
                    child: Container(
                      height: 60,
                      width: 60,
                      child: Icon(Icons.repeat, size: 30, color: colorLoopMode,),
                    ),
                    onTap: () {
                      if (colorLoopMode == Colors.white) {
                        assetsAudioPlayer.toggleLoop();
                        setState(() {
                          colorLoopMode = Colors.black;
                        });
                      }
                      else {
                        assetsAudioPlayer.toggleLoop();
                        setState(() {
                          colorLoopMode = Colors.white;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    else {
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
                    onTap: () {
                      Navigator.pop(context);
                      subscriptionCurrPos.cancel();
                    },
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
            Center(child: SizedBox(
              height: 240,
              width: 240,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),),
            ),),
            SizedBox(height: 30,),
            Text("Loading...", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
            SizedBox(height: 8,),
            Text("Loading...", style: TextStyle(fontSize: 16, color: Colors.grey.shade500, fontWeight: FontWeight.w500),),
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
}
