import 'dart:math';

import 'package:flutter/material.dart';

class lpPlayer extends StatelessWidget {

  lpPlayer(count, maxcard){
    this.deal(count, maxcard);
  }

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
      /*child: new ListView.builder(
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
      ),*/
        child: new Center(
          child: new GridView.builder(
            padding: const EdgeInsets.all(10.0),
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 9,
                childAspectRatio: 1.0,
                crossAxisSpacing: 9.0,
                mainAxisSpacing: 9.0
            ),
            itemCount: Hand.length,
            itemBuilder: (context, i) =>
            new SizedBox(
              //width: 100.0,
              //height: 100.0,
              child: new Text(Hand[i].toString(),
                textScaleFactor: 1.0,
                style: new TextStyle(
                  letterSpacing: 0.5,
                  fontSize: 24.0,
                  //height: 2.0,
                ),
              ),
            ),
          ),
        ),
    );
  }

}
