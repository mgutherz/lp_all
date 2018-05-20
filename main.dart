import 'dart:math';

import 'package:flutter/cupertino.dart';
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

  lpPlayer player;
  lpPlayer opponent;
  lpPlayer activePlayer;

  int iCard;
  int iCount;

  List<String> gameMessages = new List();
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: false,
    );
  }

  void _toEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void logMessage(String msg) {
    setState(() {
      gameMessages.add(msg);

      build(context);
      _toEnd();
    });
  }

  void _doDealPlayer() {
    setState(() {
      player.deal(handSize, maxCard);
      logMessage('Player');
    });
  }

  void _doDealOpponent() {
    setState(() {
      opponent.deal(handSize, maxCard);
      logMessage('Opponent');
    });
  }

  void _doQuit() {
    winner(activePlayer.getNext());
  }

  void _handleCall() {
    logMessage(activePlayer.getName() + ' Calling');
    handleCall(activePlayer);
  }

  void handleCall(lpPlayer activePlayer) {
    String msg = '\n' +
        highCount.toString() +
        '/' +
        highCard.toString() +
        '\'s was called by ' +
        activePlayer.getName() +
        '\n';
    //logMessage("\n%d %d\'s have been called by %s\n", highCount, highCard, activePlayer.getName());
    logMessage(msg);
    int actCount = activePlayer.howMany(highCard) +
        (activePlayer.getNext()).howMany(highCard);

    if (actCount < highCount) {
      winner(activePlayer);
    } else {
      winner(activePlayer.getNext());
    }
  }

  bool checkBid() {
    bool result = true;
    if (iCount > handSize * 2) {
      result = false;
    }
    if (iCard > maxCard) {
      result = false;
    }
    if (iCount < highCount) {
      result = false;
    } else if (iCount == highCount) {
      if (iCard <= highCard) {
        result = false;
      }
    }
    return (result);
  }

  void _handleBid() {
    String msg;

    // is input valid?
    if (checkBid()) {
      //System.out.println("Good Bid");
      setState(() {
        highCount = iCount;
        highCard = iCard;
        msg = activePlayer.getName() +
            ' bids ' +
            iCount.toString() +
            '/' +
            iCard.toString();
        logMessage(msg);
        activePlayer = activePlayer.getNext();
      });
    } else {
      msg = 'Valid bids are:\n';
      if (highCard < maxCard) {
        msg = msg +
            '\t' +
            highCount.toString() +
            ' of ' +
            highCard.toString() +
            ' or better\n';
      }
      if (highCount < handSize) {
        msg = msg + '\t' + (highCount + 1).toString() + ' of any card\n';
      }
      logMessage(msg);
    }
  }

  void _doReset() {
    setState(() {
      opponent.hide();
      player.deal(handSize, maxCard);
      opponent.deal(handSize, maxCard);
      highCard = maxCard;
      highCount = 0;
      iCard = highCard;
      iCount = highCount;
      gameMessages.clear();
    });
  }

  GameScreenState() {
    handSize = 8;
    maxCard = 9;
    //lpPlayer player = new lpPlayer(handSize, maxCard);
    player = new lpPlayer(this.handSize, this.maxCard);
    //lpPlayer opponent = new lpPlayer(handSize, maxCard);
    opponent = new lpPlayer(this.handSize, this.maxCard);

    int opponentIndex = 1;
    int playerIndex = 0;
    opponent.setAIIndex(opponentIndex);
    player.setAIIndex(playerIndex);

    player.setNext(opponent);
    opponent.setNext(player);

    player.setName('Matt');
    opponent.setName('-AI-');

    player.deal(this.handSize, this.maxCard);
    opponent.deal(this.handSize, this.maxCard);

    //player.setName("player1");
    //opponent.setName("player2");

    highCard = maxCard;
    highCount = 0;
    activePlayer = player;

    iCard = highCard;
    iCount = highCount;
  }

  void winner(lpPlayer winner) {
    opponent.reveal();
    logMessage('Winner:' + winner.getName());
    winner.addWin();
  }

  Widget playerTitle(lpPlayer player) {
    String msg = '';
    if (player == activePlayer) {
      msg = ' Active > ';
    }
    //msg = msg + player.getName();
    return new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
       new Container(
         height: 70.0,
         child: new GridView.count(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          crossAxisCount: 3,
          children: <Widget>[
            /*new Container(
              height: 70.0,
              child: new Text(
                msg,
                //textScaleFactor: 1.0,
                style: new TextStyle(
                                    fontSize: 24.0,
                  //height: 2.0,
                ),
              ),
            ),*/
            new Container(
              height: 10.0,
              child: new Text(
                player.getName(),
                maxLines: 1,
                textScaleFactor: 1.0,
                /*style: new TextStyle(
                  letterSpacing: 0.5,
                  fontSize: 24.0,
                  //height: 2.0,
                ),*/
              ),
            ),
            /*
                new Text(
                  '1',
                  textScaleFactor: 1.0,
                  style: new TextStyle(
                    letterSpacing: 0.5,
                    fontSize: 24.0,
                    //height: 2.0,
                  ),
                ),
                new Text(
                  '2',
                  textScaleFactor: 1.0,
                  style: new TextStyle(
                    letterSpacing: 0.5,
                    fontSize: 24.0,
                    //height: 2.0,
                  ),
                ),
                new Text(
                  '3',
                  textScaleFactor: 1.0,
                  style: new TextStyle(
                    letterSpacing: 0.5,
                    fontSize: 24.0,
                    //height: 2.0,
                  ),
                ),
                new Text(
                  '4',
                  textScaleFactor: 1.0,
                  style: new TextStyle(
                    letterSpacing: 0.5,
                    fontSize: 24.0,
                    //height: 2.0,
                  ),
                ),
                new Text(
                  '5',
                  textScaleFactor: 1.0,
                  style: new TextStyle(
                    letterSpacing: 0.5,
                    fontSize: 24.0,
                    //height: 2.0,
                  ),
                ),
                */
          ],
      ),
       ),
    ],
    );

    /*return new SizedBox(
      //width: 100.0,
      height: 24.0,
      child: new Text(
        msg,
        textScaleFactor: 1.0,
        style: new TextStyle(
          letterSpacing: 0.5,
          fontSize: 24.0,
          //height: 2.0,
        ),
      ),
    );
    */
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Text("Liars Poker"),
        ),
      ),
      body: new Container(
        //color: Colors.teal ,
        child: new Column(
          // Home Page
          children: <Widget>[
            new Column(
              // play area
              children: <Widget>[
                playerTitle(opponent),
                new Center(child: opponent.build(context)),
                playerTitle(player),
                new Center(child: player.build(context)),
                new Center(
                  heightFactor: 1.2,
                  widthFactor: 1.2,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // current state
                    children: <Widget>[
                      new Text(
                        'Current Bid: ',
                        style: new TextStyle(fontSize: 20.0),
                      ),
                      new RaisedButton(
                        child: new Text(
                          highCount.toString(),
                          style: new TextStyle(
                              color: Colors.white, fontSize: 16.0),
                        ),
                        padding: const EdgeInsets.all(1.0),
                      ),
                      new RaisedButton(
                        child: new Text(
                          highCard.toString(),
                          style: new TextStyle(
                              color: Colors.white, fontSize: 16.0),
                        ),
                        padding: const EdgeInsets.all(1.0),
                      ),
                    ],
                  ),
                ),
                new Column(
                  children: <Widget>[
                    new Text(
                      'Game Messages:',
                      style: new TextStyle(fontSize: 20.0),
                    ),
                    new SizedBox(
                      height: 175.0,
                      child: new ListView.builder(
                        itemCount: gameMessages.length,
                        controller: _scrollController,
                        shrinkWrap: false,
                        itemBuilder: (context, i) => new SizedBox(
                              //width: 100.0,
                              //height: 100.0,
                              child: new Text(
                                gameMessages[i].toString(),
                                textScaleFactor: 1.0,
                                style: new TextStyle(
                                  letterSpacing: 1.5,
                                  fontSize: 12.0,
                                  //height: 2.0,
                                ),
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ), //Play Area

            new Column(
              // Control Area
              children: <Widget>[
                new Row(
                  // inputs
                  children: <Widget>[
                    new Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Text(
                              'Count: ${iCount.toString()}',
                              style: new TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            new CupertinoSlider(
                                value: iCount.toDouble(),
                                min: highCount.toDouble(),
                                max: highCount.toDouble() + 4.0,
                                divisions: 4,
                                onChanged: (double countValue) {
                                  setState(() {
                                    iCount = countValue.toInt();
                                  });
                                }),
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            new Text(
                              ' Card: ${iCard.toString()}',
                              style: new TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            new CupertinoSlider(
                                value: iCard.toDouble(),
                                min: 0.0,
                                max: maxCard.toDouble(),
                                divisions: maxCard,
                                onChanged: (double cardValue) {
                                  setState(() {
                                    iCard = cardValue.toInt();
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                    new Column(
                      // totals
                      children: <Widget>[
                        new Text(
                          "Wins",
                          style: new TextStyle(
                              color: Colors.white, fontSize: 20.0),
                        ),
                        new Text(
                          '${player.getName()} : ${(player.getWins())
                              .toString()}',
                          style: new TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        new Text(
                          '${opponent.getName()} : ${(opponent.getWins())
                              .toString()}',
                          style: new TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                new Row(
                  // actions
                  children: <Widget>[
                    new RaisedButton(
                      child: new Text(
                        "Call",
                        style:
                            new TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      color: Colors.red,
                      padding: const EdgeInsets.all(20.0),
                      onPressed: _handleCall,
                    ),
                    new RaisedButton(
                      child: new Text(
                        "Quit",
                        style:
                            new TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      color: Colors.brown,
                      padding: const EdgeInsets.all(20.0),
                      onPressed: _doQuit,
                    ),
                    new RaisedButton(
                      child: new Text(
                        "Bid",
                        style:
                            new TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      color: Colors.blue,
                      padding: const EdgeInsets.all(20.0),
                      onPressed: _handleBid,
                    ),
                    new RaisedButton(
                      child: new Text(
                        "Redeal",
                        style:
                            new TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      color: Colors.purple,
                      padding: const EdgeInsets.all(20.0),
                      onPressed: _doReset,
                    ),
                  ],
                ),
              ], // control area children
            ),
          ],
        ),
      ),
    );
  } // build
}
