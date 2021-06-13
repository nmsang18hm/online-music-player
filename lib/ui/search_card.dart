import 'package:flutter/material.dart';

class SearchCard extends StatelessWidget {
  final image;
  SearchCard({this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/images/p$image.jpg",
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Counting Stars",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  "OneRepublic Native",
                  style: TextStyle(color: Colors.white.withOpacity(0.8)),
                )
              ],
            ),
          ),
          Spacer(),
          Column(
            children: [Icon(Icons.favorite), Text("200")],
          )
        ],
      ),
    );
  }
}