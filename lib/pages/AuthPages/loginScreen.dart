import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:todos/backend/authMethods.dart';
import 'package:todos/pages/AuthPages/ResetPassword.dart';
import 'package:todos/pages/AuthPages/signupScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isloading = false;

  TextEditingController _emailC = new TextEditingController();
  TextEditingController _passwordC = new TextEditingController();

  loginUser() async {
    setState(() {
      _isloading = true;
    });
    await AuthMethods()
        .SignIn(_emailC.text.trim(), _passwordC.text.trim())
        .then((val) {
      setState(() {
        _isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 640),
      builder: () => Scaffold(
        backgroundColor: Color.fromARGB(255, 5, 56, 97),
        body: _isloading
            ? Center(
                child: SpinKitRotatingCircle(
                color: Colors.white,
                size: 80.0,
              ))
            : SingleChildScrollView(
                child: SafeArea(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(top: 100.h),
                            alignment: Alignment.center,
                            child: Text(
                              "Login to continue",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.sp,
                                  // fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            )),
                        Container(
                          padding: EdgeInsets.only(top: 70.h),
                          width: 320.w,
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            controller: _emailC,
                            validator: (value) {
                              return RegExp(
                                          "[a-z0-9!#%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                      .hasMatch(value!)
                                  ? null
                                  : "Invalid email address";
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.mail, color: Colors.white),
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              contentPadding: const EdgeInsets.all(15),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 85, 155, 212),
                                    width: 2),
                              ),
                              focusedBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                              ),
                            ),
                            onChanged: (value) {
                              // do something
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15.h),
                          width: 320.w,
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            controller: _passwordC,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 6) {
                                return 'Password is too short';
                              }
                              return null;
                            },
                            obscureText: _isObscure,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  }),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              contentPadding: const EdgeInsets.all(15),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 85, 155, 212),
                                    width: 2),
                              ),
                              focusedBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                              ),
                            ),
                            onChanged: (value) {
                              // do something
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              loginUser();
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 20.h),
                            alignment: Alignment.center,
                            width: 250.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 17, 113, 192),
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(ResetPassword(),
                                transition: Transition.cupertinoDialog,
                                duration: Duration(seconds: 1));
                          },
                          child: Container(
                              // padding: EdgeInsets.only(top: 20.h),
                              padding: EdgeInsets.fromLTRB(0, 20.h, 20.w, 0),
                              alignment: Alignment.topRight,
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.sp,
                                    // fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    fontStyle: FontStyle.italic),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(SignupScreen(),
                                transition: Transition.rightToLeftWithFade,
                                duration: Duration(seconds: 1));
                          },
                          child: Container(
                              padding: EdgeInsets.only(top: 100.h),
                              alignment: Alignment.center,
                              child: Text(
                                "Don't have an account?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.sp,
                                    // fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
