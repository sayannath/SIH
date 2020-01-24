import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePage(),
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

  Future<void> _optionsDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      'Take a Picture',
                      style: TextStyle(
                        color: Colors.white,
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
                        color: Colors.white,
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
        title: Text('Flutter Location with Camera'),
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
                          color: Colors.white,
                          fontFamily: "Roboto"),
                    )
                  : Image.file(_image),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    onPressed: _displayCurrentLocation,
                    color: Colors.green,
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('Get Location',
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  ),
                  Text(
                    "Latitude:  ${_location.latitude}\n"
                    "Longitude: ${_location.longitude}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: "Roboto",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.add_a_photo),
        tooltip: 'Open Camera',
        onPressed: _optionsDialogBox,
      ),
    );
  }
}
