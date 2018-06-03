import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:layouttest/lp_player.dart';
import 'package:layouttest/setup_screen.dart';

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
  lpPlayer whosFirst;
  lpPlayer winner;

  int iCard;
  int iCount;

  List<String> gameMessages = new List();
  ScrollController _scrollController;
  SetupScreen setupScreen;

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
      setWinner(activePlayer);
    } else {
      setWinner(activePlayer.getNext());
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

  void bidAgent3() {
    //int bidcount = 0;
    int bidcard = -1;
    bool willLie = false;

    var r = new Random();

    if ((activePlayer.get_lcard() > highCard && highCount <= 2) ||
        (highCount <= 1)) {
      if (r.nextInt(3) > 2) {
        willLie = true;
        bidcard = activePlayer.get_lcard();
      }
    }
    if (!willLie) {
      // try Second best
      if (activePlayer.get_scount() >= highCount) {
        // RND split with BEST

        bidcard = activePlayer.get_scard();
      } else {
        bidcard = activePlayer.get_bcard();
      }
    }

    iCard = bidcard;
    if (bidcard > highCard) {
      iCount = highCount;
    } else {
      iCount = highCount + 1;
    }

    _handleBid();
  }

  void turnAgent4() {
    int opinCount;
    double opinionTreshold = 0.4;
    double opinion;

    // update opinions
    activePlayer.updateOpinions(highCount, highCard);

    // call or bid
    opinion = activePlayer.getOpinion(highCard);

    if (opinion > opinionTreshold) {
      opinCount = activePlayer.howMany(highCard) + 2;
    } else {
      opinCount = activePlayer.howMany(highCard) + 2;
    }
    if (highCount > opinCount) {
      _handleCall();
    } else {
      //bid based on B S or L card
      bidAgent3();
    }
  }

  void aiTurn() {
    if (activePlayer.getAIIndex() == 1) {
      // Call
      if (highCount > activePlayer.howMany(highCard) + 1) {
        _handleCall();
      } else {
        //bid
        iCount = highCount + 1;
        _handleBid();
      }
    } else if (activePlayer.getAIIndex() == 2) {
      // Call
      if (highCount > activePlayer.howMany(highCard) + 1) {
        _handleCall();
      } else {
        //bid based on highest run
        iCard = activePlayer.bestCard();
        if (iCard > highCard) {
          iCount = highCount;
        } else {
          iCount = highCount + 1;
        }
        _handleBid();
      }
    } else if (activePlayer.getAIIndex() == 3) {
      // Call
      if ((highCount > 2) && (highCount > activePlayer.howMany(highCard) + 1)) {
        _handleCall();
      } else {
        //bid based on B S or L card
        bidAgent3();
      }
    } else if (activePlayer.getAIIndex() == 4) {
      turnAgent4();
    } else {
      // Same as 1

      // Call
      if (highCount > activePlayer.howMany(highCard) + 1) {
        _handleCall();
      } else {
        //bid
        iCount = highCount + 1;
        _handleBid();
      }
    }
  }

  void _handleBid() {
    String msg;

    // is input valid?
    if (checkBid()) {
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
      if (activePlayer.getAIIndex() > 0) {
        aiTurn();
      }
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
      activePlayer = whosFirst.getNext();
      whosFirst = activePlayer;
      winner = null;

      //debug

      /*logMessage('ai ' +
          opponent.get_bcard().toString() +
          opponent.get_scard().toString() +
          opponent.get_lcard().toString() +
          opponent.howMany(0).toString() +
          opponent.howMany(1).toString() +
          opponent.howMany(2).toString() +
          opponent.howMany(3).toString() +
          opponent.howMany(4).toString() +
          opponent.howMany(5).toString() +
          opponent.howMany(6).toString() +
          opponent.howMany(7).toString() +
          opponent.howMany(8).toString() +
          opponent.howMany(9).toString()
      );*/
    });
    if (activePlayer.getAIIndex() > 0) {
      aiTurn();
    }
  }

  GameScreenState() {
    handSize = 8;
    maxCard = 9;

    player = new lpPlayer(this.handSize, this.maxCard);

    opponent = new lpPlayer(this.handSize, this.maxCard);

    int opponentIndex = 4;
    int playerIndex = 0;
    opponent.setAIIndex(opponentIndex);
    player.setAIIndex(playerIndex);

    player.setNext(opponent);
    opponent.setNext(player);

    player.setName('Matt');

    player.deal(this.handSize, this.maxCard);
    opponent.deal(this.handSize, this.maxCard);

    activePlayer = opponent;

    highCard = maxCard;
    highCount = 0;
    whosFirst = player;
    activePlayer = player;

    iCard = highCard;
    iCount = highCount;

    //setupScreen = new SetupScreen(player, opponent);
  }

  void setWinner(lpPlayer player) {
    setState(() {
      opponent.reveal();
      //logMessage('Winner:' + player.getName());
      player.addWin();
      winner = player;
      build(context);
    });
  }

  Widget playerTitle(lpPlayer player) {
    Color iconColor = Colors.transparent;
    IconData tileIcon = Icons.play_arrow;

    if (player == activePlayer) {
      iconColor = Colors.yellowAccent;
    }

    if (player == winner) {
      iconColor = Colors.yellowAccent;
      tileIcon = Icons.star_border;
    }

    if (player.getNext() == winner) {
      iconColor = Colors.transparent;
    }
    return new Container(
      height: 38.0,
      child: new ListTile(
        leading: new Icon(
          tileIcon,
          color: iconColor,
        ),
        title: new Text(
          player.getName(),
          style: new TextStyle(
            fontSize: 20.0,
          ),
        ),
        trailing: new Text(
          'Wins: ' + (player.getWins()).toString(),
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  Widget _buildRedealButton() {
    return new RaisedButton(
      child: new Text(
        "Redeal",
        style: new TextStyle(color: Colors.white, fontSize: 20.0),
      ),
      color: Colors.purple,
      padding: const EdgeInsets.all(20.0),
      onPressed: (winner == null) ? null : _doReset,
    );
  }

  Widget _buildBidButton() {
    return new RaisedButton(
      child: new Text(
        "Bid",
        style: new TextStyle(color: Colors.white, fontSize: 20.0),
      ),
      color: Colors.blue,
      padding: const EdgeInsets.all(20.0),
      onPressed: (winner == null) ? _handleBid : null,
    );
  }

  Widget _buildCalllButton() {
    return new RaisedButton(
      child: new Text(
        "Call",
        style: new TextStyle(color: Colors.white, fontSize: 20.0),
      ),
      color: Colors.red,
      padding: const EdgeInsets.all(20.0),
      onPressed: (winner == null) ? _handleCall : null,
    );
  }

  Widget _buildControlArea() {
    return new Column(
      // Control Area
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
        new Row(
          // button row
          // actions
          children: <Widget>[
            _buildCalllButton(),
            new RaisedButton(
              child: new Text(
                "",
                style: new TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              color: Colors.transparent,
              padding: const EdgeInsets.all(20.0),
              onPressed: () {},
            ),
            _buildBidButton(),
            _buildRedealButton(),
          ],
        ),
      ], // control area children
    );
  }

  Widget _buildControlAreaLS() {
    return new Container(
      height: 380.0,
      width: 367.0,
      child: new Column(
        children: <Widget>[
          new Text(
            'Game Messages:',
            style: new TextStyle(fontSize: 20.0),
          ),
          /*new SizedBox(
            height: 175.0,
            width: 175.0,
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
          ),*/
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
          new Transform(
            transform: new Matrix4.identity()..scale(1.0,1.0),
            child: new Row(
              // actions
              children: <Widget>[
                _buildCalllButton(),
                new SizedBox(
                  height: 50.0,
                  width: 50.0,
                ),
                /*new RaisedButton(
                  child: new Text(
                    "",
                    style: new TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(2.0),
                  onPressed: () {},
                ),*/
                _buildBidButton(),
                _buildRedealButton(),
              ],
            ),
          ),
          // Control Area
        ],
      ),
    );
  }

  Widget _buildPlayArea() {
    return new Column(
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
                  style: new TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                padding: const EdgeInsets.all(1.0),
              ),
              new RaisedButton(
                child: new Text(
                  highCard.toString(),
                  style: new TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                padding: const EdgeInsets.all(1.0),
              ),
            ],
          ),
        ),
        /*new Column(
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
        ),*/
      ],
    );
  }

  Widget _buildPlayAreaLS() {
    return new Container(
      height: 300.0,
      width: 300.0,
      child: new Column(
        children: <Widget>[
          //new Text('Play Area'),
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
                    style: new TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  padding: const EdgeInsets.all(1.0),
                ),
                new RaisedButton(
                  child: new Text(
                    highCard.toString(),
                    style: new TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  padding: const EdgeInsets.all(1.0),
                ),
              ],
            ),
          ),
          // Control Area
        ],
      ),
    );
  }

  Widget _buildBody() {
    Orientation orientation = MediaQuery.of(context).orientation;
    bool isLandscape = orientation == Orientation.landscape;

    if (isLandscape) {
      return new Container(
        //color: Colors.teal ,
        child: new Row(
          // Home Page
          children: <Widget>[
            new Transform(
              child: _buildPlayAreaLS(),
              transform: new Matrix4.identity()..scale(1.0,1.0),// not ok,
            ), // not ok
            new Transform(
              child: _buildControlAreaLS(),
              transform: new Matrix4.identity()..scale(1.0,1.0),// not ok,
            ),
          ],
        ),
      );
    } else {
      return new Container(
        //color: Colors.teal ,
        child: new Column(
          // Home Page
          children: <Widget>[
            _buildPlayArea(),
            _buildControlArea(),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Text("Liars Poker"),
        ),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.settings),
            onPressed: () {
              setupScreen = new SetupScreen(player, opponent);
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => setupScreen,
                ),
              );
            },
          ),
        ],
      ),
      body: _buildBody(),
    );
  } // build
}
