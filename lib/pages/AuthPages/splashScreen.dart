import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todos/pages/AuthPages/checkerPage.dart';
import 'package:todos/pages/AuthPages/loginScreen.dart';
import 'package:todos/pages/homePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 0.5).animate(animation);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animation.forward();
      }
    });
    animation.forward();

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CheckerPage()),
      );
    });
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 56, 97),
      body: Container(
        child: Center(
          child: FadeTransition(
              opacity: _fadeInFadeOut,
              child: CircleAvatar(
                radius: 90,
                backgroundImage: AssetImage("assets/img/logo.png"),
              )),
        ),
      ),
    );
  }
}
