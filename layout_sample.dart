
void main(){
  runApp(
    new MaterialApp(
      title: "App name",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("App name"),
        ), // AppBar
      ), // Scaffold
    ), // MaterialApp
  ); // runApp
} // main

void main(){
  runApp(new FriendylchatApp());
}

class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title; "Frientlychat",
      home: new ChatScreen(),
    ); // MaterialApp
  } // build
} // FrientlychatApp

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text("Friendlychat")),
    ); // Scaffold
  }  // build
} // ChatScreen

      
