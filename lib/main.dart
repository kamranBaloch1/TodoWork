import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todos/pages/AuthPages/ResetPassword.dart';
import 'package:todos/pages/AuthPages/loginScreen.dart';
import 'package:todos/pages/AuthPages/signupScreen.dart';
import 'package:todos/pages/addTodo.dart';
import 'package:todos/pages/homePage.dart';
import 'package:todos/pages/AuthPages/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(name: "/addTodo", page: () => AddTodoScreen()),
          GetPage(name: "/homePage", page: () => HomeScreen()),
          GetPage(name: "/loginPage", page: () => LoginScreen()),
          GetPage(name: "/singupScreen", page: () => SignupScreen()),
          GetPage(name: "/resetPassword", page: () => ResetPassword()),
        ],
        home: SplashScreen());
  }
}
