import 'dart:math';
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:onlinemusicplayer/model/song.dart';
import 'package:onlinemusicplayer/ui/main_player.dart';
import 'package:onlinemusicplayer/ui/playlist.dart';
import 'package:onlinemusicplayer/ui/search_page.dart';
import 'playlist.dart';
import 'recommend_card.dart';
import 'hot_playlist_card.dart';
import 'choices_card.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {

  int currentIndex = 0;
  final List<Widget> screens = [
    HomePage(),
    SearchPage(),
    Episode6PlaylistView()
  ];

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
              BottomNavigationBarItem(
                  icon: Icon(Icons.local_fire_department_rounded), label: 'Hotlist')
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
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  var tabbarController;

  List<Song> recommendedSongList = [
    Song(audio:  Audio("assets/audios/Tan-Cung-Noi-Nho-Will.mp3",
      metas: Metas(
        title:  "Tan cung noi nho",
        artist: "Will",
        album: "CountryAlbum",
        image: MetasImage.asset("assets/images/artworks-000394925472-n3c8pm-t500x500.jpg"), //can be MetasImage.network
      ),
    ),),
    Song(audio:  Audio("assets/audios/Tan-Cung-Noi-Nho-Will.mp3",
      metas: Metas(
        title:  "Tan cung noi nho",
        artist: "Will",
        album: "CountryAlbum",
        image: MetasImage.asset("assets/images/artworks-000394925472-n3c8pm-t500x500.jpg"), //can be MetasImage.network
      ),
    ),),
    Song(audio:  Audio("assets/audios/Tan-Cung-Noi-Nho-Will.mp3",
      metas: Metas(
        title:  "Tan cung noi nho",
        artist: "Will",
        album: "CountryAlbum",
        image: MetasImage.asset("assets/images/artworks-000394925472-n3c8pm-t500x500.jpg"), //can be MetasImage.network
      ),
    ),),
  ];

  List<RecommentCard> recommendedCardList = [];

  @override
  void initState() {
    super.initState();
    tabbarController = TabController(vsync: this, initialIndex: 0, length: 2);
    recommendedSongList.forEach((element) {
      recommendedCardList.add(RecommentCard(song: element,));
    });
  }

  @override
  Widget build(BuildContext context) {
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
              onEditingComplete: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(),
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
                  height: 250,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: recommendedCardList,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Hot Playlists",
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
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    HotPlayListCard(
                        image: Random().nextInt(7) + 1,tag: "album"
                    ),
                    HotPlayListCard(
                        image: Random().nextInt(7) + 1,tag: "a"
                    ),
                    HotPlayListCard(
                        image: Random().nextInt(7) + 1,tag: "b"
                    ),
                    HotPlayListCard(
                        image: Random().nextInt(7) + 1,tag: "c"
                    ),
                    HotPlayListCard(
                        image: Random().nextInt(7) + 1,tag: "d"
                    ),
                    HotPlayListCard(
                        image: Random().nextInt(7) + 1,tag: "e"
                    ),
                    HotPlayListCard(
                        image: Random().nextInt(7) + 1,tag: "f"
                    ),
                    HotPlayListCard(
                        image: Random().nextInt(7) + 1,tag: "g"
                    )
                  ],
                ),
                Text(
                  "Our Choises for you",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TabBar(
                  controller: tabbarController,
                  indicatorColor: Colors.pink,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 5,
                  tabs: [
                    Tab(
                      child: Text("Songs"),
                    ),
                    Tab(
                      child: Text("Playlists"),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: LimitedBox(
                    maxHeight: 400,
                    child: TabBarView(
                      controller: tabbarController,
                      children: [
                        ListView(
                          shrinkWrap: true,
                          children: [
                            ChoisesCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            ChoisesCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            ChoisesCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            ChoisesCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            ChoisesCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            ChoisesCard(
                              image: Random().nextInt(7) + 1,
                            )
                          ],
                        ),
                        ListView(
                          children: [
                            ChoisesCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            ChoisesCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            ChoisesCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            ChoisesCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            ChoisesCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            ChoisesCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            ChoisesCard(
                              image: Random().nextInt(7) + 1,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: [
                      Text(
                        "Hot Singers",
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
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    HotPlayListCard(
                      image: Random().nextInt(7) + 1,tag: "2",
                    ),
                    HotPlayListCard(
                      image: Random().nextInt(7) + 1,tag: "3",
                    ),
                    HotPlayListCard(
                      image: Random().nextInt(7) + 1,tag: "4",
                    ),
                    HotPlayListCard(
                      image: Random().nextInt(7) + 1,tag: "5",
                    ),
                    HotPlayListCard(
                      image: Random().nextInt(7) + 1,tag: "6",
                    ),
                    HotPlayListCard(
                      image: Random().nextInt(7) + 1,tag: "7",
                    ),
                    HotPlayListCard(
                      image: Random().nextInt(7) + 1,tag: "8",
                    ),
                    HotPlayListCard(
                      image: Random().nextInt(7) + 1,tag: "9",
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
