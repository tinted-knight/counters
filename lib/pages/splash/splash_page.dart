import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.red,
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(backgroundColor: Colors.white),
        ),
      ),
    );
  }
}
