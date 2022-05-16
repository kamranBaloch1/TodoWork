import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _emailC = new TextEditingController();

  bool _isLoading = false;

  UserResetPassword() async {
    if (_emailC.text.trim().isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailC.text.trim())
            .then((value) {
          Fluttertoast.showToast(
              msg: "Password reset instructions have been sent to this email!",
              toastLength: Toast.LENGTH_LONG);
          setState(() {
            _isLoading = false;
            _emailC.clear();
          });
        });
      } catch (err) {
        Fluttertoast.showToast(
            msg:
                "There is no user record corresponding to this identifier. The user may have been deleted.",
            toastLength: Toast.LENGTH_LONG);
        print(err.toString());
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please enter your email!", toastLength: Toast.LENGTH_LONG);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 640),
      builder: () => Scaffold(
        backgroundColor: Color.fromARGB(255, 5, 56, 97),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 9, 98, 172),
          centerTitle: true,
          title: Text(
            "Reset Password",
            style: TextStyle(fontSize: 22, fontStyle: FontStyle.italic),
          ),
        ),
        body: Column(
          children: <Widget>[
            _isLoading
                ? Container(
                    child: LinearProgressIndicator(),
                  )
                : Container(),
            Container(
              // padding: EdgeInsets.only(top: 70.h),
              padding: EdgeInsets.fromLTRB(20.w, 30.h, 0, 0),
              width: 340.w,
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
                  hintText: 'Enter your email address',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  contentPadding: const EdgeInsets.all(15),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 85, 155, 212), width: 2),
                  ),
                  focusedBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                onChanged: (value) {
                  // do something
                },
              ),
            ),
            GestureDetector(
              onTap: () async {
                UserResetPassword();
              },
              child: Container(
                margin: EdgeInsets.only(top: 20.h),
                alignment: Alignment.center,
                width: 200.w,
                height: 40.h,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 17, 113, 192),
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "Send",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
