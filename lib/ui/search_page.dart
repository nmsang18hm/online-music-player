import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:onlinemusicplayer/entities/playlist.dart';
import 'package:onlinemusicplayer/entities/song.dart';
import 'package:onlinemusicplayer/services/PlaylistServices.dart';
import 'package:onlinemusicplayer/services/SongService.dart';
import 'package:onlinemusicplayer/ui/search_playlist_card.dart';

import 'search_song_card.dart';

class SearchPage extends StatefulWidget {
  AssetsAudioPlayer assetsAudioPlayer;

  SearchPage(AssetsAudioPlayer assetsAudioPlayer) {
    this.assetsAudioPlayer = assetsAudioPlayer;
  }
  @override
  _SearchPageState createState() => _SearchPageState(assetsAudioPlayer);
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin{
  var tabbarController;
  AssetsAudioPlayer assetsAudioPlayer;
  Future searchS;
  Future searchP;

  List<SearchSongCard> resultSongs = [];
  List<SearchPlaylistCard> resultPlaylists = [];

  _SearchPageState(AssetsAudioPlayer assetsAudioPlayer) {
    this.assetsAudioPlayer = assetsAudioPlayer;
  }

  @override
  void initState() {
    super.initState();
    tabbarController = TabController(vsync: this, initialIndex: 0, length: 2);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 15),
          child: Container(
            height: 40,
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white.withOpacity(0.2)),
            child: TextField(
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 20,
                  ),
                  hintText: "Search album,song...",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  )),
              autofocus: true,
              onChanged: (text) {
                setState(() {
                  resultSongs.clear();
                  resultPlaylists.clear();
                  if (text != "") {
                    searchS = searchSongs(text);
                    searchS.then((value) => value.forEach((element) {
                      resultSongs.add(SearchSongCard(song: element, assetsAudioPlayer: assetsAudioPlayer,));
                    }));
                    searchP = searchPlaylists(text);
                    searchP.then((value) => resultPlaylists.add(SearchPlaylistCard(playlistEntity: value, assetsAudioPlayer: assetsAudioPlayer,)));
                  }
                });
              },

            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              child: Image.asset(
                "assets/images/avatar.png",
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 0.0),
            child: ListView(
              children: [
                TabBar(
                  controller: tabbarController,
                  indicatorColor: Colors.pink,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 5,
                  tabs: [
                    Tab(
                      child: Text("Songs", style: TextStyle(fontSize: 16),),
                    ),
                    Tab(
                      child: Text("Playlists", style: TextStyle(fontSize: 16),),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: LimitedBox(
                    maxHeight: 490,
                    child: TabBarView(
                      controller: tabbarController,
                      children: [
                        FutureBuilder<List<Song>>(future: searchS, builder: (context, snapshot) {
                          if(snapshot.hasError) print(snapshot.error);
                          if(snapshot.connectionState == ConnectionState.done) {
                            if(resultSongs.length == 0) {
                              return Center(child: Text("Khong co ket qua phu hop.", style: TextStyle(fontSize: 16),),);
                            }
                            else {
                              return ListView(
                                children: resultSongs,
                                shrinkWrap: true,
                              );
                            }
                          }
                          else if(snapshot.connectionState == ConnectionState.none) {
                            return Center(child: Text("Khong co ket qua phu hop.", style: TextStyle(fontSize: 16),),);
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
                        FutureBuilder<PlaylistEntity>(future: searchP, builder: (context, snapshot) {
                          if(snapshot.hasError) print(snapshot.error);
                          if(snapshot.connectionState == ConnectionState.done) {
                            if(resultPlaylists.length == 0) {
                              return Center(child: Text("Khong co ket qua phu hop.", style: TextStyle(fontSize: 16),),);
                            }
                            else {
                              return ListView(
                                children: resultPlaylists,
                                shrinkWrap: true,
                              );
                            }
                          }
                          else if(snapshot.connectionState == ConnectionState.none) {
                            return Center(child: Text("Khong co ket qua phu hop.", style: TextStyle(fontSize: 16),),);
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
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
