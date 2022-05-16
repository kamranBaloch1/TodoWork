import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todos/pages/AuthPages/loginScreen.dart';
import 'package:todos/pages/homePage.dart';

class CheckerPage extends StatelessWidget {
  const CheckerPage({Key? key}) : super(key: key);

  getcurrentUser() async {
    return await FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: getcurrentUser(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return HomeScreen();
            }
            {
              return LoginScreen();
            }
          }),
    );
  }
}
