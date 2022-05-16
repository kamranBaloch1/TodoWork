import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:todos/pages/AuthPages/loginScreen.dart';
import 'package:todos/pages/homePage.dart';

class AuthMethods {
  CreateTheUser(String name, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "name": name,
        "email": email,
        "password": password,
        "createdOn": DateTime.now()
      }).then((value) {
        Fluttertoast.showToast(
            msg: "Account is been created", toastLength: Toast.LENGTH_LONG);
        Get.offAll(HomeScreen(),
            transition: Transition.leftToRightWithFade,
            duration: Duration(seconds: 1));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Fluttertoast.showToast(
            msg: "The password provided is too weak.",
            toastLength: Toast.LENGTH_LONG);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Fluttertoast.showToast(
            msg: "email-already-in-use", toastLength: Toast.LENGTH_LONG);
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  SignIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Fluttertoast.showToast(
          msg: "Logged In completed.", toastLength: Toast.LENGTH_LONG);
      Get.offAll(HomeScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Fluttertoast.showToast(
            msg: "No user found for that email.",
            toastLength: Toast.LENGTH_LONG);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Fluttertoast.showToast(
            msg: "Wrong password provided for that user.",
            toastLength: Toast.LENGTH_LONG);
      }
    }
  }

  SignOut() async {
    await FirebaseAuth.instance.signOut();
    Fluttertoast.showToast(msg: "Logged Out ", toastLength: Toast.LENGTH_LONG);
    Get.offAll(LoginScreen());
  }
}
