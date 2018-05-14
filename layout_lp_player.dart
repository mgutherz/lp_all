import 'dart:math';

import 'package:flutter/material.dart';

class lpPlayer extends StatefulWidget {
  @override
  lpPlayerState createState() => new lpPlayerState();
}

class lpPlayerState extends State {
  int handSize = 8;
  int maxCard = 9;

  var Hand = new List();

  void deal(int count, int maxcard) {
    Hand.clear();
    var r = new Random();

    for (int i = 0; i < count; i++) {
      Hand.add(r.nextInt(maxcard + 1));
    }
    Hand.sort();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 100.0,
      child: new ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) =>
            new Text(Hand[index].toString(),
                textScaleFactor: 1.0,
                style: new TextStyle(
                  letterSpacing: 0.5,
                  fontSize: 24.0,
                  height: 2.0,
                )),
        itemCount: Hand.length,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deal(handSize, maxCard);
  }
}
