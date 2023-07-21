import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class MyRiveAnimation extends StatefulWidget {
  @override
  _MyRiveAnimationState createState() => _MyRiveAnimationState();
}

class _MyRiveAnimationState extends State<MyRiveAnimation> {
  Artboard? _artboard;
  RiveAnimationController? controller;

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
  }

  void _loadRiveFile() async {
    final bytes = await rootBundle.load('assets/5158-10360-jumpy.riv');
    final file = RiveFile.import(bytes);
    final artboard = file.mainArtboard;
    artboard.addController(controller = SimpleAnimation('animation_name'));
    setState(() => _artboard = artboard);
  }

  @override
  Widget build(BuildContext context) {
    return _artboard != null
        ? RiveAnimation.asset(
            'assets/5158-10360-jumpy.riv',
            // artboard: '_artboard',
            controllers: [controller!],
          )
        : Container(); // Return an empty container until the animation is loaded
  }
}
