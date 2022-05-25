import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:tp_tdm/audio.dart';
import 'package:tp_tdm/database_helper.dart';

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
              title: Text("title $index", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              leading: RaisedButton(
                color: Colors.grey,
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                ),
                shape: CircleBorder(),
                child: Icon(Icons.music_note, color: Colors.red,),
                onPressed: () {
                },
              ),
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
  MethodChannel _channel = const MethodChannel('ilyas.belfar.tp_tdm/musicservice');
  var _isFavorite = false;
  var _isPlaying = false;
  List<Audio> _audioList = [];

  final dbHelper = DatabaseHelper.instance;

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

  Future<List<Audio>> getAudios() async {
    if(_audioList.length == 0) {
      List<dynamic> musicMapList =
      await _channel.invokeMethod('audio_picker.getAudios');
      List<Audio> musicList =
      musicMapList.map((musicMap) => Audio.fromMap(musicMap)).toList();
      _audioList = musicList;
      return _audioList;
    }
    else {
      return _audioList;
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
                    vertical: 10,
                  ),
                  shape: CircleBorder(),
                  child: Icon(Icons.arrow_back_ios, color: Colors.black,),
                  onPressed: () {
                    _query();
                  },
                ),
        RaisedButton(
          color: Colors.grey,
          padding: EdgeInsets.symmetric(
            vertical: 10,
          ),
          shape: CircleBorder(),
          child: Icon(_isPlaying?Icons.pause:Icons.play_arrow_rounded, color: Colors.black,),
          onPressed: () {
            setState(() {
              _isPlaying=!_isPlaying;
            });
          },
        ),
                RaisedButton(
                  color: Colors.grey,
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  shape: CircleBorder(),
                  child: Icon(Icons.arrow_forward_ios, color: Colors.black,),
                  onPressed: () {
                    print(getAudios());
                  },
                ),
              ],
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  color: Colors.grey,
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  shape: CircleBorder(),
                  child: Icon(_isFavorite?Icons.favorite:Icons.favorite_outline, color: Colors.red,),
                  onPressed: () {
                    setState(() {
                      _isFavorite=!_isFavorite;
                    });
                    _insert();
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
  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      'songName' : 'Artisan & Didin Canon 16 - Glock',
      'songPath' : 'Glock.mp3'
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }
}