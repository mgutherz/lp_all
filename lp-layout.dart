
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
