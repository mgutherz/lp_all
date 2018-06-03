import 'package:flutter/material.dart';
import 'package:layouttest/lp_player.dart';
import 'package:layouttest/main.dart';

class SetupScreen extends StatelessWidget {
  String playerName;
  int opponentAI;
  String opponentName;
  lpPlayer player;
  lpPlayer opponent;
  List aiList;
  FixedExtentScrollController _scrollController;

  SetupScreen(lpPlayer Player, lpPlayer Opponent) {
    player = Player;
    opponent = Opponent;
    playerName = Player.getName();
    opponentAI = Opponent.getAIIndex();
    aiList = new List();
    aiList.add('Self');
    aiList.add('AI1');
    aiList.add('AI2');
    aiList.add('AI3');
    aiList.add('AI4');
    myController.text = playerName;
    _scrollController = new FixedExtentScrollController(
      initialItem: opponentAI,
    );
  }

  final myController = new TextEditingController(
    text: '',
  );

  void saveConfig() {
    player.setName(myController.text);
    opponent.setAIIndex(opponentAI);
    opponent.setName(aiList[opponentAI]);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("lp setup"),
      ),
      body: new Column(
        children: [
          new Text('Name input'),
          new TextField(
            controller: myController,
          ),
          new Text('Pick opponenet'),
          new Container(
            height: 60.0,
            child: new ListWheelScrollView(
              controller: _scrollController,
              itemExtent: 40.0,
              onSelectedItemChanged: (int index) {
                opponentAI = index;
              },
              children: new List<Widget>.generate(aiList.length, (int index) {
                return new Center(
                  child: new Text(
                    aiList[index],
                    style: new TextStyle(fontSize: 20.0),
                  ),
                );
              }),
            ),
          ),
          new RaisedButton(
            onPressed: () {
              saveConfig();
              Navigator.pop(context);
            },
            child: new Text('Save'),
          ),
        ],
      ),
    );
  }
}
