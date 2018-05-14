https://codelabs.developers.google.com/codelabs/flutter/

<3.>
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

<4.>
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
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder:(_, int index) +> _messages[index],
              itenCount: _messages.length,
            ), // ListView
          ), // Flexible
          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor);
            child: _buildTextComposer(),
          ), // Container
        ], // Widget
      ), // Column          
    ); // Scaffold
  }  // build
} // ChatScreen

<5., 6., 7.>
class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin{
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  
  @override
  void dispose(){
    for (ChatMessage mesage in _messages)
      message.animationcontroller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text("Friendlychat")),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder:(_, int index) +> _messages[index],
              itenCount: _messages.length,
            ), // ListView
          ), // Flexible
          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor);
            child: _buildTextComposer(),
          ), // Container
        ], // Widget
      ), // Column          
    ); // Scaffold
  }  // build

  Widget _buildTextComposer() {
    return new Icontheme(
      data: new IconthemeData(color: Theme.of(context).accentColor),
      
      child: new Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
        children: <Widget>[
          new Flexible(
            child: new TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: new InputDecoration.collapsed(
                hintText: "Send a message"),
            ), // TextField
          ), // Flexible
          new Container(
            margin: new EdgeInsets.symmetric(horizontal: 4.0),
            child: new IconButton(
              icon: new Icon(Icons.send),
              onPressed: () +> _handleSubmitted(_textController.text)
            ), // IconButton
          ), // Container
        ], // children
      ), // Row
    ), // container
    ); // IconTheme
  } // Widget
  
  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = new ChatMessage(
      text: text,
      animationController; new AnimiationController(
        duration: new Duration(milliseconds: 700),
        vsync: this,
      ), //AnimationController
    ); // ChatMessage
    setState(() {
      _message.insert(0,message);
    }); // setState
    message.animationController.forward();
  }
   
class ChatMessage extens StatelessWidget {
  const String _name = "Matt";
  
  ChatMessage({this.text, this.animatedController});
  final String text;
  final AnimationController animationController;
  @override
  Widget build(BuildContext context){
    return new SizeTransiztion(
      sizeFction: new CurvedAnimation(
        parent: animationcontroller, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CirleAvatar(child: new Text(_name[0])),
          ), // Container
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(_name, style: Theme.of(context).textTheme.subhead),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(text),
              ), // container
            ], // children
          ), // Column
        ], // children
      ), // Row
    ) // container
    ); // SizeTransition
  } // build
} // ChatMessage

