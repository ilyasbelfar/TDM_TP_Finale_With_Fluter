import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text("MusicService")),
        body: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "assets/images/music_clipart.jpg",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.grey,
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  shape: StadiumBorder(),
                  child: Icon(Icons.arrow_back_ios, color: Colors.blue.shade400,),
                  onPressed: () {
                  },
                ),
        RaisedButton(
          color: Colors.grey,
          padding: EdgeInsets.symmetric(
            vertical: 12,
          ),
          shape: StadiumBorder(),
          child: Icon(Icons.pause, color: Colors.blue.shade400,),
          onPressed: () {
          },
        ),
                RaisedButton(
                  color: Colors.grey,
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  shape: StadiumBorder(),
                  child: Icon(Icons.arrow_forward_ios, color: Colors.blue.shade400,),
                  onPressed: () {
                  },
                ),
              ],
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  color: Colors.grey,
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  shape: StadiumBorder(),
                  child: Icon(Icons.favorite_outline, color: Colors.blue.shade400,),
                  onPressed: () {
                  },
                ),
                Expanded(
                  child: Text('Craft beautiful UIs'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}