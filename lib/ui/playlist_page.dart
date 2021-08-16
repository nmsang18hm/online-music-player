import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:onlinemusicplayer/database/db_services.dart';
import 'package:onlinemusicplayer/entities/playlist.dart';
import 'package:onlinemusicplayer/ui/main_player.dart';

class PlaylistPage extends StatefulWidget {
  AssetsAudioPlayer assetsAudioPlayer;
  PlaylistEntity playlistEntity;

  PlaylistPage(PlaylistEntity playlistEntity,AssetsAudioPlayer assetsAudioPlayer) {
    this.assetsAudioPlayer = assetsAudioPlayer;
    this.playlistEntity = playlistEntity;
  }
  @override
  _PlaylistPageState createState() =>
      _PlaylistPageState(assetsAudioPlayer);
}

class _PlaylistPageState extends State<PlaylistPage> {
  AssetsAudioPlayer assetsAudioPlayer;
  double screenHeight = 0;
  double screenWidth = 0;
  final Color mainColor = Color(0xff181c27);
  final Color inactiveColor = Color(0xff5d6169);
  String imageURL = 'assets/images/playlist.png';

  _PlaylistPageState(AssetsAudioPlayer assetsAudioPlayer) {
    this.assetsAudioPlayer = assetsAudioPlayer;
  }

  List<Audio> audioList = [];

  @override
  void initState() {
    super.initState();
    widget.playlistEntity.listSong.forEach((element) {
      audioList.add(element.audio);
    });
    if(widget.playlistEntity.listSong.length > 0) {
      setState(() {
        imageURL = widget.playlistEntity.listSong[0].audio.metas.image.path;
      });
    }
    //setupPlaylist();
  }

  /*void setupPlaylist() async {
    assetsAudioPlayer.open(Playlist(audios: audioList),
        autoStart: false, loopMode: LoopMode.playlist);
  }*/

  Widget playlistImage() {
    return Container(
      height: screenHeight * 0.20,
      width: screenHeight * 0.20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.asset(
          imageURL,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget playlistTitle() {
    return Text(
      widget.playlistEntity.name,
      style: TextStyle(
          fontFamily: 'Barlow',
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold),
    );
  }

  Widget playButton() {
    return Container(
      width: screenWidth * 0.25,
      child: TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPlayer(listAudio: audioList, assetsAudioPlayer: assetsAudioPlayer,),
                ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.play_circle_outline_rounded,
                color: mainColor,
              ),
              SizedBox(width: 5),
              Text(
                'Play',
                style: TextStyle(color: mainColor),
              ),
            ],
          ),
          style: ButtonStyle(
              backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )))),
    );
  }

  Widget playlist() {
    return Container(
      height: screenHeight * 0.35,
      alignment: Alignment.topLeft,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: audioList.length,
          itemBuilder: (context, index) {
            return playlistItem(index);
          }),
    );
  }

  Widget playlistItem(int index) {
    return InkWell(
      //onTap: () => assetsAudioPlayer.playlistPlayAtIndex(index),
      splashColor: Colors.transparent,
      highlightColor: mainColor,
      child: Container(
        height: screenHeight * 0.07,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              Text(
                '0${index + 1}',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Barlow'),
              ),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      audioList[index].metas.title,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Barlow'),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                      audioList[index].metas.artist,
                      style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff5d6169),
                          fontFamily: 'Barlow'),
                    ),
                  ],
                ),
              ),
              InkWell(
                child: Icon(
                  Icons.delete,
                  color: inactiveColor,
                ),
                onTap: () {
                  if(widget.playlistEntity.type == 'local') {
                    setState(() {
                      DatabaseHelper.instance.deleteSong(audioList[index].metas.title, widget.playlistEntity.name);
                      audioList.removeAt(index);
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
  /*
  Widget bottomPlayContainer(RealtimePlayingInfos realtimePlayingInfos) {
    return Container(
      height: screenHeight * 0.1,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: [
            Container(
              height: screenHeight * 0.08,
              width: screenHeight * 0.08,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  realtimePlayingInfos.current.audio.audio.metas.image.path,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    realtimePlayingInfos.current.audio.audio.metas.title,
                    style: TextStyle(
                        fontSize: 15,
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Barlow'),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    realtimePlayingInfos.current.audio.audio.metas.artist,
                    style: TextStyle(
                        fontSize: 13, color: mainColor, fontFamily: 'Barlow'),
                  )
                ],
              ),
            ),
            Icon(
              Icons.favorite_outline_rounded,
              color: mainColor,
            ),
            SizedBox(
              width: screenWidth * 0.03,
            ),
            IconButton(
                icon: Icon(realtimePlayingInfos.isPlaying
                    ? Icons.pause_circle_filled_rounded
                    : Icons.play_circle_fill_rounded),
                iconSize: screenHeight * 0.07,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                color: mainColor,
                onPressed: () => assetsAudioPlayer.playOrPause())
          ],
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: mainColor,
        body: //assetsAudioPlayer.builderRealtimePlayingInfos(
            //builder: (context, realtimePlayingInfos) {
              //if (realtimePlayingInfos != null) {
                Column(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: InkWell(
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Icon(Icons.arrow_back, color: Colors.white, size: 30,),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: InkWell(
                              child: Container(
                                height: 50,
                                width: 50,
                                child: Icon(Icons.delete, color: Colors.white, size: 30,),
                              ),
                              onTap: () {
                                if(widget.playlistEntity.type == 'local') {
                                  DatabaseHelper.instance.deletePlaylist(widget.playlistEntity.name);
                                  DatabaseHelper.instance.deleteAllSongs(widget.playlistEntity.name);
                                  Navigator.pop(context);
                                }
                              },
                            )
                        ),
                      ],
                    ),
                    playlistImage(),
                    SizedBox(height: screenHeight * 0.02),
                    playlistTitle(),
                    SizedBox(height: screenHeight * 0.02),
                    playButton(),
                    SizedBox(height: screenHeight * 0.02),
                    playlist(),
                    //bottomPlayContainer(realtimePlayingInfos)
                  ],
                //);
              //} else {
                //return Column();
              //}
            //}
            ));
  }
}