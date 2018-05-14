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
                new lpPlayer(),
                new lpPlayer(),
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
            ], // control area children
          ),
        ],
      ),
    ); // Scaffold
  } // build
} // GameScreenState
