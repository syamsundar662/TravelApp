import 'package:flutter/material.dart';

class ShowLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Loading View'),
        ),
        body: Center(
          child: _circularProgressIndicator(),
        ));
  }

  Widget _circularProgressIndicator() {
    return CircularProgressIndicator();
  }
}
