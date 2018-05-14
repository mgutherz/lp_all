
void main(){
  runApp(new lpApp());
}

class lpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: "lpApp",
      home: new GameScreen(),
    ); // MaterialApp
  } // build
} // lpApp

class GameScreen extends StatefulWidget {
  @override
  State createState() +> new GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context){
    return new Scaffold( 
      appBar: new AppBar(title: new Text("Friendlychat")),
      body: new Column( // home page
        children: <Widget>[
          new Column( // Play Area
            children: <Widget>[
              new Row ( // Player 2 list built from Hand
                children: <Widget>[
                  new text(
                    'Player2 row',
                  ),
                ],
              ),
              new Row( // Player 1 list build from Hand
                children: <Widget>[
                  new text(
                    'Player1 row',
                  ),
                ],
              ),
              new Row( // current state
                children: <Widget>[
                  new text(
                    'current state row',
                  ),
                ],
              ),
              new column( // game log list build from messages
                children: <Widget>[
                  new text(
                    'log row',
                  ),
                ],
              ),
            ], // Play Area children
          ),
          new Column( // Control Area
            children: <Widget>[ 
              new Row( // inputs
                children: <Widget>[
                  new text(
                    'inputs row',
                  ),
                ],
              ),
              new Row( // actions
                children: <Widget>[
                  new text(
                    'actions row',
                  ),
                ],
              ),
            ], // control area children
          ),
        ]
      ), // body
    ); // Scaffold
  } // build
} // GameScreenState
      
