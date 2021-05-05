import 'package:flutter/material.dart';
import 'song_on_list.dart';
import 'main_player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        songOnList(
          title: "Tan cung noi nho",
          singer: "Will",
          cover: "https://drive.google.com/u/0/uc?id=1dHMaksfRwk2MSPjMRLlQINaQMf9mysyU&export=download",
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPlayer()),
            );
          }
        ),
        songOnList(
            title: "Tan cung noi nho",
            singer: "Will",
            cover: "https://drive.google.com/u/0/uc?id=1dHMaksfRwk2MSPjMRLlQINaQMf9mysyU&export=download",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPlayer()),
              );
            }
        )
      ],
    );
  }
}
