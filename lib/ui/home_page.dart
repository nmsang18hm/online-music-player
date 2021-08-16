import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:onlinemusicplayer/entities/playlist.dart';
import 'package:onlinemusicplayer/entities/song.dart';
import 'package:onlinemusicplayer/services/PlaylistServices.dart';
import 'package:onlinemusicplayer/services/SongService.dart';
import 'package:onlinemusicplayer/ui/hot_playlist_card.dart';
import 'package:onlinemusicplayer/ui/hot_song_card.dart';
import 'package:onlinemusicplayer/ui/playlist_manage.dart';
import 'package:onlinemusicplayer/ui/playlist_page.dart';
import 'package:onlinemusicplayer/ui/search_page.dart';
import 'bottom_play_container.dart';
import 'playlist_page.dart';
import 'recommend_card.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.currentIndex, this.assetsAudioPlayer}) : super(key: key);

  final currentIndex;
  AssetsAudioPlayer assetsAudioPlayer;

  @override
  _MyHomePageState createState() => _MyHomePageState(assetsAudioPlayer);
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AssetsAudioPlayer assetsAudioPlayer;

  int currentIndex = 0;
  List<Widget> screens;

  _MyHomePageState(AssetsAudioPlayer assetsAudioPlayer) {
    this.assetsAudioPlayer = assetsAudioPlayer;
  }

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
    screens = [HomePage(assetsAudioPlayer), SearchPage(assetsAudioPlayer), PlaylistManage(assetsAudioPlayer)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        height: 60,
        color: null,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(0xff181c27),
            selectedItemColor: Colors.white,
            unselectedItemColor: Color(0xff5d6169),
            iconSize: 30,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_music_rounded), label: 'Library'),
              //BottomNavigationBarItem(
                  //icon: Icon(Icons.local_fire_department_rounded), label: 'Hotlist')
            ],
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          )
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  AssetsAudioPlayer assetsAudioPlayer;
  HomePage(AssetsAudioPlayer assetsAudioPlayer) {
    this.assetsAudioPlayer = assetsAudioPlayer;
  }
  @override
  _HomePageState createState() => _HomePageState(assetsAudioPlayer);
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  var tabbarController;
  AssetsAudioPlayer assetsAudioPlayer;
  Future fetchS = fetchSongs();
  //Future fetchP = fetchSongs();
  Widget bottomPlayer = SizedBox(width: 1, height: 1,);

  List<RecommentCard> recommendedCardList = [];
  List<HotSongCard> hotSongCardList = [];
  List<HotPlaylistCard> hotPlaylistCardList = [];


  _HomePageState(AssetsAudioPlayer assetsAudioPlayer) {
    this.assetsAudioPlayer = assetsAudioPlayer;
  }

  @override
  void initState() {
    super.initState();
    tabbarController = TabController(vsync: this, initialIndex: 0, length: 2);
    fetchS.then((value) => value.forEach((element) {
      recommendedCardList.add(RecommentCard(song: element, assetsAudioPlayer: assetsAudioPlayer,));
      hotSongCardList.add(HotSongCard(song: element, assetsAudioPlayer: assetsAudioPlayer,));
    }));

  }
  
  Future<List<PlaylistEntity>> getHotPlaylists() async {
    List<PlaylistEntity> list = [];
    PlaylistEntity playlistEntity1 = await searchPlaylists('Nhac Hay Thang 3');
    list.add(playlistEntity1);
    PlaylistEntity playlistEntity2 = await searchPlaylists('Nhac Hay Thang 4');
    list.add(playlistEntity2);
    PlaylistEntity playlistEntity3 = await searchPlaylists('Nhac Tam Trang');
    list.add(playlistEntity3);
    PlaylistEntity playlistEntity4 = await searchPlaylists('Nhac Buon');
    list.add(playlistEntity4);
    //PlaylistEntity playlistEntity5 = await searchPlaylists('Dance');
    //list.add(playlistEntity5);
    //PlaylistEntity playlistEntity6 = await searchPlaylists('Pop');
    //list.add(playlistEntity6);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    if(this.assetsAudioPlayer.current.hasValue) {
      bottomPlayer = Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          bottomPlayContainer(assetsAudioPlayer, context),
        ],
      );
    }
    else {
      bottomPlayer = SizedBox(width: 1, height: 1,);
    }

    return Scaffold(
      backgroundColor: Color(0xff181c27),
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
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(currentIndex: 1, assetsAudioPlayer: assetsAudioPlayer,),
                    ));
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
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: ListView(
              children: [
                Text(
                  "Hot Recommended",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 270,
                  child: FutureBuilder<List<Song>>(future: fetchS, builder: (context, snapshot) {
                    if(snapshot.hasError) print(snapshot.error);
                    if(snapshot.connectionState == ConnectionState.done) {
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children: recommendedCardList,
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
                  },)
                ),
                Row(
                  children: [
                    Text(
                      "Hot Songs",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    SizedBox(
                      height: 25,
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.white,
                        onPressed: () {},
                        child: Text(
                          "View All",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
                FutureBuilder<List<Song>>(future: fetchS, builder: (context, snapshot) {
                  if(snapshot.hasError) print(snapshot.error);
                  if(snapshot.connectionState == ConnectionState.done) {
                    return GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        childAspectRatio: 0.72,
                        physics: NeverScrollableScrollPhysics(),
                        children: hotSongCardList
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
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: [
                      Text(
                        "Hot Playlists",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      SizedBox(
                        height: 25,
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: Colors.white,
                          onPressed: () {},
                          child: Text(
                            "View All",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                FutureBuilder<List<PlaylistEntity>>(future: getHotPlaylists(), builder: (context, snapshot) {
                  if(snapshot.hasError) print(snapshot.error);
                  if(snapshot.connectionState == ConnectionState.done) {
                    hotPlaylistCardList.clear();
                    snapshot.data.forEach((element) {
                      hotPlaylistCardList.add(HotPlaylistCard(playlistEntity: element, assetsAudioPlayer: assetsAudioPlayer,));
                    });
                    return GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        childAspectRatio: 0.72,
                        physics: NeverScrollableScrollPhysics(),
                        children: hotPlaylistCardList
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
          bottomPlayer,
        ],
      ),
    );
  }
}
