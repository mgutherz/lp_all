import 'dart:math';

import 'package:flutter/material.dart';

class lpPlayer extends State {
  var Hand = new List();
  lpPlayer nextPlayer;
  int aiIndex;
  int totalWins;
  String playerName;
  bool hidden;

  // AI items

  var counts = new List();
  int bcount;
  int bcard;
  int scard;
  int scount;
  int lcard;

  lpPlayer(count, maxcard) {
    bcount = 0;
    bcard = 0;
    scard = 0;
    scount = 0;
    lcard = 0;
    totalWins = 0;
    hidden = false;
  }

  void deal(int count, int maxcard) {
    Hand.clear();
    var r = new Random();

    for (int i = 0; i < count; i++) {
      Hand.add(r.nextInt(maxcard + 1));
    }
    Hand.sort();
    if (this.aiIndex > 0) {
      // find best, second best and liar card
      //System.out.println("init AI");
      bcount = 0;
      scount = 0;
      for (int i = 0; i <= maxcard; i++) {
        counts.add(howMany(i));
        if (counts[i] >= bcount) {
          scard = bcard;
          scount = bcount;
          scard = bcard;
          scount = bcount;
          bcount = counts[i];
          bcard = i;
        } else if (counts[i] >= scount) {
          scount = counts[i];
          scard = i;
        }

        if ((counts[i] == 0) && (r.nextInt(2) > 1)) {
          // smooth distribution of selected lie
          //System.out.printf("L changed to %d\n", i);
          lcard = i;
        }
      }
    }
  }

  int howMany(int input) {
    int count = 0;

    for (int i = 0; i < Hand.length; i++) {
      if (Hand[i] == input) {
        count++;
      }
    }
    return (count);
  }

  void setAIIndex(int index) {
    aiIndex = index;
    if (aiIndex > 0) {
      hidden = true;
    }
  }

  int getAIIndex() {
    return (aiIndex);
  }

  void setName(String name) {
    playerName = name;
  }

  String getName() {
    return (playerName);
  }

  void setNext(lpPlayer nextp) {
    nextPlayer = nextp;
  }

  lpPlayer getNext() {
    return (nextPlayer);
  }

  void addWin() {
    totalWins = totalWins + 1;
  }

  int getWins() {
    return (totalWins);
  }

  void reveal() {
    hidden = false;
  }

  void hide() {
    hidden = true;
  }

  @override
  Widget build(BuildContext context) {
    if (hidden) {
      return new Column(
        children: <Widget>[

          new Container(
            height: 67.0,
          ),
        ],
      );
    } else {
      return new Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

        new Container(
          height: 67.0,
          child: new Center(
            child: new GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Hand.length,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 0.1),
              itemCount: Hand.length,
              itemBuilder: (context, i) => new SizedBox(
                    //width: 100.0,
                    //height: 100.0,
                    child: new RaisedButton(
                      child: new Text(
                        Hand[i].toString(),
                        textScaleFactor: 1.0,
                        style: new TextStyle(
                          letterSpacing: 1.0,
                          color: Colors.tealAccent,
                          fontSize: 22.0,
                          //height: 2.0,
                        ),
                      ),
                    ),
                  ),
            ),
          ),
        ),
      ]);
    }
  }
}
