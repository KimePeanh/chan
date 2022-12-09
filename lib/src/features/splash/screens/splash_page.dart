import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/splash.jpg"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent, brightness: Brightness.dark),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
