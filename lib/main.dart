import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()),);
}

class FavorisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoris'),
      ),
      body: Center(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount :  10,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("title $index"),
              leading: Icon(Icons.music_note),
              isThreeLine: false,
              dense: true,
              contentPadding: EdgeInsets.all(10.0),
              onTap: () {
                print('index: $index');
              },
            );
          },
        ),
      ),);}}

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
        appBar: AppBar(title: const Text("MusicService"),
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.menu),
              color: Colors.white,
              onSelected: (choix) async {
                if(choix==0) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FavorisScreen()),
                  );
                }
                if(choix==1) {
                  final path = await FilePicker.getFilePath(type: FileType.audio);
                  if (path != null) {
                    print(path);
                  }
              }},
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("Mes Favoris",style: TextStyle(color: Colors.black),),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Parcourir Musiques",style: TextStyle(color: Colors.black),),
                ),
              ],
            ),
          ],),
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
  var _isFavorite = false;
  var _isPlaying = false;

  @override
  void initState() {
    requestPermission();
    super.initState();
  }

  void requestPermission() async {
    var status = await Permission.storage.status;
    if(!status.isGranted) {
      await Permission.storage.request();
    }
  }

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
        // Slider(
        //   activeColor: Colors.pink,
        //   inactiveColor: Colors.blueGrey,
        //   onChanged: (value) {
        //     print(value);
        //   },
        //   onChangeStart: (value) {
        //     print(value);
        //   },
        //   onChangeEnd: (value) {
        //     print(value);
        //   },
        //   value: 4,
        //   min: 0.0,
        //   max: 15,
        // ),
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
          child: Icon(_isPlaying?Icons.pause:Icons.play_arrow_rounded, color: Colors.blue.shade400,),
          onPressed: () {
            setState(() {
              _isPlaying=!_isPlaying;
            });
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
                  child: Icon(_isFavorite?Icons.favorite:Icons.favorite_outline, color: Colors.red,),
                  onPressed: () {
                    setState(() {
                      _isFavorite=!_isFavorite;
                    });
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