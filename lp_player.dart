import 'dart:math';

import 'package:flutter/material.dart';

class lpPlayer extends State {
  var Hand = new List();
  lpPlayer nextPlayer;
  int aiIndex;
  int totalWins;
  String playerName;
  bool hidden;
  int handSize;
  int maxCard;

  // AI items

  var counts = new List();
  var opinions = new List();
  int bcount;
  int bcard;
  int scard;
  int scount;
  int lcard;

  lpPlayer(count, maxcard) {
    handSize = count;
    maxCard = maxcard;
    bcount = 0;
    bcard = 0;
    scard = 0;
    scount = 0;
    lcard = 0;
    totalWins = 0;
    hidden = false;

  }

  void updateOpinions(int highCount, int highCard){
    double posStep = 1.0;
    double negStep = -0.4;
    double decayRate = 2.0;

    for(int i = 0; i < maxCard + 1; i++){
      if(i == highCard && highCount > 0){
        opinions[i] += posStep;

      } else if(opinions[i] > 0){  // decay

        //opinions[i] -= negStep;
        opinions[i] = opinions[i]/decayRate;
      }
    }
  }

  double getOpinion(int highCard){
    return (opinions[highCard]/(opinions[highCard]+1.0));
  }

  int get_lcard(){
    return (lcard);
  }

  int get_scount(){
    return (scount);
  }

  int get_scard(){
    return (scard);
  }

  int get_bcard(){
    return (bcard);
  }
  void deal(int count, int maxcard) {
    Hand.clear();
    opinions.clear();
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
        opinions.add(0.0); // init opinions
        counts.add(howMany(i));
        if (howMany(i) >= bcount) {
          scard = bcard;
          scount = bcount;
          scard = bcard;
          scount = bcount;
          bcount = howMany(i);
          bcard = i;
        } else if (howMany(i) >= scount) {
          scount = howMany(i);
          scard = i;
        }

        if ((howMany(i) == 0) && (r.nextInt(3) > 1)) {
          // smooth distribution of selected lie
          //System.out.printf("L changed to %d\n", i);
          lcard = i;
        }
      }
    }
  }

  int bestCard(){
    return (bcard);
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
    playerName = '[Ai ' + aiIndex.toString() + ']';
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
