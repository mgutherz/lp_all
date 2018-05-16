import 'dart:math';

import 'package:flutter/material.dart';
import 'package:layouttest/lp_player.dart';

void main() {
  runApp(new lpApp());
}

class lpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "lpApp",
      theme: new ThemeData.dark(),
      home: new GameScreen(),
    ); // MaterialApp
  } // build
} // lpApp

class GameScreen extends StatefulWidget {
  @override
  State createState() => new GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  int handSize = 8;
  int maxCard = 9;
          int highCard;
        int highCount;

  GameScreenState() { // setup 
    handSize = 8;
    maxCard = 9;
    player = new lpPlayer(this.handSize, this.maxCard);
   opponent = new lpPlayer(this.handSize, this.maxCard);
                    player.setNext(opponent);
                opponent.setNext(player);

                //player.setName("player1");
                //opponent.setName("player2");

                opponent.setAIIndex(opponentIndex);
                player.setAIIndex(playerIndex);

                highCard = maxCard;
                highCount = 0;
      whosFirst = opponent;
    while(goagain){
       //reset();
  }

  lpPlayer player;
  lpPlayer opponent;
  lpPlayer whosFirst;
  
  

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Text("Liars Poker"),
        ),
      ),
      body: new Column(
        // Home Page
        children: <Widget>[
          new Expanded(
            child: new Column(
              // play area
              children: <Widget>[
                opponent.build(context),
                player.build(context),

                new Row(
                  // current state
                  children: <Widget>[
                    new Text(
                      'current state row',
                    ),
                  ],
                ),
                new Column(
                  // game log list build from messages
                  children: <Widget>[
                    new Text(
                      'log row',
                    ),
                  ],
                ),
              ],
            ), //Play Area
          ),
          new Column(
            // Control Area
            children: <Widget>[
              new Row(
                // inputs
                children: <Widget>[
                  new Text(
                    'inputs row',
                  ),
                ],
              ),
              new Row(
                // actions
                children: <Widget>[
                  new Text(
                    'actions row',
                  ),
                ],
              ),
              new RaisedButton(
                child: new Text(
                  "Player",
                  style: new TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                color: Colors.red,
                padding: const EdgeInsets.all(20.0),
                onPressed: _doDealPlayer,
              ),
              new RaisedButton(
                child: new Text(
                  "Opponent",
                  style: new TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                color: Colors.blue,
                padding: const EdgeInsets.all(20.0),
                onPressed: _doDealOpponent,
              ),
            ], // control area children
          ),
        ],
      ),
    ); // Scaffold
  } // build

  void _doDealPlayer() {
    setState(() {
      player.deal(handSize, maxCard);
    });
  }
  void _doDealOpponent() {
    setState(() {
      opponent.deal(handSize, maxCard);
    });
  }
} // GameScreenState
