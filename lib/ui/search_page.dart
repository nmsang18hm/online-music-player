import 'dart:math';

import 'package:flutter/material.dart';

import 'search_card.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin{
  var tabbarController;

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
                      child: Text("Songs"),
                    ),
                    Tab(
                      child: Text("Playlists"),
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
                        ListView(
                          shrinkWrap: true,
                          children: [
                            SearchCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            SearchCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            SearchCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            SearchCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            SearchCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            SearchCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            SearchCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            SearchCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            SearchCard(
                              image: Random().nextInt(7) + 1,
                            )
                          ],
                        ),
                        ListView(
                          children: [
                            SearchCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            SearchCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            SearchCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            SearchCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            SearchCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            SearchCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            SearchCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            SearchCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            SearchCard(
                              image: Random().nextInt(7) + 1,
                            ),
                            SearchCard(
                              image: Random().nextInt(7) + 1,
                            )
                          ],
                        )
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
