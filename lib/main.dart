import 'dart:math';

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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnimationPage(),
    );
  }
}

class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  bool _isBag = false;
  double _size = 100.0;

  Tween _animationTween = Tween<double>(begin: 0, end: pi * 2);
  Tween _colorTween = ColorTween(begin: Colors.blue, end: Colors.purple);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<Color>(
              // tween: _animationTween,
              tween: _colorTween,
              duration: Duration(seconds: 3),
              builder: (context, Color value, child) {
                return Container(
                  color: value,
                  height: _size,
                  width: _size,
                );                // return Transform.rotate(
                //   angle: value,
                //   child: AnimatedContainer(
                //     duration: Duration(seconds: 1),
                //     color: Colors.blue,
                //     height: _size,
                //     width: _size,
                //   ),
                // );
              },
            ),
            RaisedButton(
              child: Text('Animate'),
              onPressed: () {
                setState(() {
                  _size = _isBag ? 200 : 100;
                  _isBag = !_isBag;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
