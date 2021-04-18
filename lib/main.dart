import 'package:flutter/material.dart';
import 'package:onlinemusicplayer/ui/empty_page.dart';
import 'package:onlinemusicplayer/ui/home_page.dart';
import 'package:onlinemusicplayer/ui/main_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;

  List tabs = [
    HomePage(),
    EmptyPage()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Online Music Player",
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: Scaffold(
        body: tabs[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              // ignore: deprecated_member_use
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_upload),
              // ignore: deprecated_member_use
              title: Text("Empty"),
            ),
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

