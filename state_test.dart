import 'dart:math';

import 'package:flutter/material.dart';

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
        // Player 
        lpPlayer player = new lpPlayer();
        // Opponent
        lpPlayer opponent = new lpPlayer();
        lpPlayer whosFirst;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player.setNext(opponent);
                opponent.setNext(player);

                //player.setName("player1");
                //opponent.setName("player2");

                opponent.setAIIndex(opponentIndex);
                player.setAIIndex(playerIndex);

                highCard = maxCard;
                highCount = 0;
                player.deal(handSize,maxCard);
                opponent.deal(handSize,maxCard);

                // Opponent goes first during first hand then alternate
                if(whosFirst == null){
                        whosFirst = opponent;
                }else{
                        whosFirst = whosFirst.getNext();
                }
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Center(child: new Text("Liars Poker"),),),
      body: new Column(
        // Home Page
        children: <Widget>[
          new Expanded(
            child: new Column(
              // play area
              children: <Widget>[
                opponent.build(),
                player.build(),
                //new lpPlayer(),
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
             ),
           ),
           new Column(
             // Control Area
              new RaisedButton(
            child: new Text(
              "Reset",
              style: new TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            color: Colors.red,
            padding: const EdgeInsets.all(20.0),
            onPressed: setState((){
              player.deal();
              }),
          )
           ),
         ], // widget
       ), // column
     ); // Scaffold
   } // build
          
} // class GameScreenState
