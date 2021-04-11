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
      // home: AnimationPage(),

      home: AnimateRotation(),
    );
  }
}

class AnimateRotation extends StatefulWidget {
  @override
  _AnimateRotationState createState() => _AnimateRotationState();
}

class _AnimateRotationState extends State<AnimateRotation>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _iconController;
  bool _isRotating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();

    _iconController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _iconController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animations'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RotationTransition(
              turns: _controller,
              child: Container(
                padding: EdgeInsets.all(16),
                child: FlutterLogo(
                  size: 100,
                ),
              ),
            ),
            IconButton(
              icon: AnimatedIcon(
                icon: AnimatedIcons.play_pause,
                progress: _iconController,
              ),
              onPressed: () {
                if (_isRotating) {
                  _controller.stop();
                  _iconController.reverse();
                } else {
                  _controller.repeat();
                  _iconController.forward();
                }

                _isRotating = !_isRotating;
              },
            )
          ],
        ),
      ),
    );
  }
}

// class AnimationPage extends StatefulWidget {
//   @override
//   _AnimationPageState createState() => _AnimationPageState();
// }
//
// class _AnimationPageState extends State<AnimationPage> {
//   bool _isBag = false;
//   double _size = 100.0;
//
//   Tween _animationTween = Tween<double>(begin: 0, end: pi * 2);
//   Tween _colorTween = ColorTween(begin: Colors.blue, end: Colors.purple);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Animations'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TweenAnimationBuilder<Color>(
//               // tween: _animationTween,
//               tween: _colorTween,
//               duration: Duration(seconds: 3),
//               builder: (context, Color value, child) {
//                 return Container(
//                   color: value,
//                   height: _size,
//                   width: _size,
//                 );                // return Transform.rotate(
//                 //   angle: value,
//                 //   child: AnimatedContainer(
//                 //     duration: Duration(seconds: 1),
//                 //     color: Colors.blue,
//                 //     height: _size,
//                 //     width: _size,
//                 //   ),
//                 // );
//               },
//             ),
//             RaisedButton(
//               child: Text('Animate'),
//               onPressed: () {
//                 setState(() {
//                   _size = _isBag ? 200 : 100;
//                   _isBag = !_isBag;
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
