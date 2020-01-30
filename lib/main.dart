import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:location_camera/splashScreen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white,
        primarySwatch: Colors.indigo,
        accentColor: Colors.indigo,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
      ),
      home: SplashScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position _location = Position(latitude: 0.0, longitude: 0.0);
  File _image;

  Future openCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    Navigator.of(context).pop();

    setState(() {
      _image = image;
    });
  }

  Future openGallery() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    Navigator.of(context).pop();

    setState(() {
      _image = picture;
    });
  }

  void _displayCurrentLocation() async {
    final location = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _location = location;
    });
  }

  showFloatingActionButton(){
    if(_image == null){
      return FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        tooltip: 'Open Camera',
        onPressed: _optionsDialogBox,
      );
    } else {
      return FloatingActionButton(
        child: Icon(Icons.close),
        onPressed: (){
          setState(() {
            _image = null;
          });
        },
      );
    }
  }

  showLocation(){
    if(_image != null){
      _displayCurrentLocation();
      return Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            ),
            Text(
              "Latitude:  ${_location.latitude}\n"
              "Longitude: ${_location.longitude}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: "Roboto",
                ),
              ),
            ],
          ),
        );
      }
      else {
        return Container();
      }
  }

  Future<void> _optionsDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      'Take a Picture',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onTap: openCamera,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  GestureDetector(
                    child: Text(
                      'Choose from Gallery',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onTap: openGallery,
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart India Hackathon'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: _image == null
                  ? Text(
                      'No Image is Selected.',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Roboto"),
                    )
                  : Container(
                    width: 400.0,
                    height: 400.0,
                    child: Image.file(_image),
                  ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
            ),
            showLocation(),
          ],
        ),
      ),
      floatingActionButton: showFloatingActionButton(),
    );
  }
}
