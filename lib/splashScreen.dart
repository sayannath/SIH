import 'package:flutter/material.dart';
import 'package:location_camera/main.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _iconAnimationController;
  CurvedAnimation _iconAnimation;

  void handleTimeOut() {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (BuildContext context) => new HomePage()));
  }

  startTimeout() async {
    var duration = const Duration(seconds: 5);
    return new Timer(duration, handleTimeOut);
  }

  @override
  void initState() {
    super.initState();
    _iconAnimationController = AnimationController(
        vsync: this, duration: new Duration(milliseconds: 2200));
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeIn);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Smart India Hackathon',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Text(
                'Crop Detection App',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Roboto",
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
