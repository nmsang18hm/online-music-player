import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:onlinemusicplayer/database/db_services.dart';
import 'package:onlinemusicplayer/entities/playlist.dart';
import 'package:onlinemusicplayer/entities/song.dart';
import 'package:onlinemusicplayer/services/SongService.dart';
import 'package:onlinemusicplayer/ui/hot_playlist_card.dart';

import 'search_song_card.dart';

class PlaylistManage extends StatefulWidget {
  AssetsAudioPlayer assetsAudioPlayer;

  PlaylistManage(AssetsAudioPlayer assetsAudioPlayer) {
    this.assetsAudioPlayer = assetsAudioPlayer;
  }
  @override
  _PlaylistManageState createState() => _PlaylistManageState(assetsAudioPlayer);
}

class _PlaylistManageState extends State<PlaylistManage> with SingleTickerProviderStateMixin{
  var tabbarController;
  AssetsAudioPlayer assetsAudioPlayer;
  String nameCreatedPlaylist = "";

  List<HotPlaylistCard> playlistCards = [];

  _PlaylistManageState(AssetsAudioPlayer assetsAudioPlayer) {
    this.assetsAudioPlayer = assetsAudioPlayer;
  }

  @override
  void initState() {
    super.initState();
    tabbarController = TabController(vsync: this, initialIndex: 0, length: 2);
  }

  Future<List<String>> getPlaylistNames() async {
    List<String> playlistNames = [];
    List<Map<String, dynamic>> rows = await DatabaseHelper.instance.getAllPlaylist();
    rows.forEach((element) {
      playlistNames.add(element['playlist_name']);
    });
    return playlistNames;
  }

  List<PlaylistEntity> getPlaylists(List<String> playlistNames) {
    List<PlaylistEntity> playlists = [];
    playlistNames.forEach((element) {
      playlists.add(PlaylistEntity(element, [], 'local'));
    });
    return playlists;
  }

  Future<List<PlaylistEntity>> getPlaylists2() async {

    List<String> playlistNames = await getPlaylistNames();
    List<PlaylistEntity> playlists = getPlaylists(playlistNames);
    playlists.forEach((element) async {
      List<Map<String, dynamic>> rows = await DatabaseHelper.instance.findSongs(element.name);
      for(Map<String, dynamic> row in rows) {
        element.listSong.add(Song(row['song_name'], row['artist'], row['album'], row['url'], row['image']));
      }
    });
    return playlists;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Create Playlist",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20,),
                        child: Container(
                          height: 40,
                          width: 300,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white.withOpacity(0.2)),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Enter name of playlist",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                )
                            ),
                            onSubmitted: (value) {
                              nameCreatedPlaylist = value;
                            },
                          ),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          height: 70,
                          width: 70,
                          child: Icon(Icons.add_circle_outline, color: Colors.white, size: 50,),
                        ),
                        onTap: () async {
                          setState(() {
                            DatabaseHelper.instance.insertPlaylist({
                              'playlist_name' : nameCreatedPlaylist
                            });
                          });
                        },
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      "My Playlists",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10,),
                  FutureBuilder<List<PlaylistEntity>>(future: getPlaylists2(), builder: (context, snapshot) {
                    if(snapshot.hasError) print(snapshot.error);
                    if(snapshot.connectionState == ConnectionState.done) {
                      playlistCards.clear();
                      snapshot.data.forEach((element) {
                        playlistCards.add(HotPlaylistCard(playlistEntity: element, assetsAudioPlayer: assetsAudioPlayer,));
                      });
                      return GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          childAspectRatio: 0.72,
                          physics: NeverScrollableScrollPhysics(),
                          children: playlistCards
                      );
                    }
                    else {
                      return Center(child: SizedBox(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),),
                      ),);
                    }
                  },),
                ],
              ),
            ),
          ],
        ),
    );
  }
}