import 'package:flutter/material.dart';

class ShowLoading extends StatelessWidget {
  const ShowLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Loading View'),
        ),
        body: Center(
          child: _circularProgressIndicator(),
        ));
  }

  Widget _circularProgressIndicator() {
    return const CircularProgressIndicator();
  }
}
