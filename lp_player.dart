import 'dart:math';

import 'package:flutter/material.dart';

class lpPlayer extends StatelessWidget {

  lpPlayer(count, maxcard){
    counts = new int[count];
    bcount=0;
     bcard=0;
     scard=0;
     scount=0;
     lcard=0;
    this.deal(count, maxcard);
  }

  var Hand = new List();
  lpPlayer nextPlayer;
  int aiIndex;
  int totalWins;
  String playerName;
  
  // AI items
  
          int[] counts ;
         int bcount;
         int bcard;
         int scard;
         int scount;
         int lcard;

  void deal(int count, int maxcard) {
    Hand.clear();
    var r = new Random();

    for (int i = 0; i < count; i++) {
      Hand.add(r.nextInt(maxcard + 1));
    }
    Hand.sort();
    
    // 
    if(aiIndex > 0){
                        // find best, second best and liar card
                        //System.out.println("init AI");
                        bcount=0;
                        scount=0;
                        for (int i = 0; i<=maxcard; i++){
                                opinions[i] = 0; // init opinions
                                counts[i] = howMany(i);
                                if(counts[i] >= bcount){
                                        scard = bcard;
                                        scount = bcount;
                                        scard = bcard;
                                        scount = bcount;
                                        bcount = counts[i];
                                        bcard = i;
                                }else if(counts[i] >= scount){
                                        scount = counts[i];
                                        scard = i;
                                }
                                if((counts[i] == 0) && (Math.random()*2 > 1)) { // smooth distribution of selected lie
                                        //System.out.printf("L changed to %d\n", i);
                                        lcard=i;
                                }
                        }
                }
    
  }
  
  void setAIIndex(int index){
                aiIndex = index;
        }

  int getAIIndex(){
                return(aiIndex);
        }

  void setName(String name){
                playerName = name;
        }

  String getName(){
                return(playerName);
        }

  void setNext(lpPlayer nextplayer){
                nextPlayer = nextplayer;
        }

  lpPlayer getNext(){
                return(nextPlayer);
        }
         void addWin(int win){
                totalWins += win;
        }

         int getWins(){
                return(totalWins);
        }
  
  int howMany(int input){
                int count =0;
                for (int card : Hand){
                        if(card == input){
                                count++;
                        }
                }
                return(count);
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
