import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:todos/backend/authMethods.dart';

import 'package:todos/pages/addTodo.dart';
import 'package:todos/pages/singelTodoView.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "Logout",
        style: TextStyle(fontSize: 19),
      ),
      onPressed: () {
        AuthMethods().SignOut();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are you sure you want to logOut?"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showTodosTile(String name, String desc, String date, String todoId,
      DateTime createdDate, String time) {
    return Container(
      width: 400,
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
            child: SizedBox(
              width: 300.0.w,
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: false,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
          Container(
            // padding: EdgeInsets.fromLTRB(left, top, right, bottom),
            padding: EdgeInsets.fromLTRB(30.w, 10.h, 0, 0),

            child: SizedBox(
              width: 300.0.w,
              child: Text(
                desc,
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: false,
                style: TextStyle(
                  color: Color.fromARGB(255, 247, 246, 246),
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(60, 8, 0, 0),
            child: Text(
              "To be done on : " + date,
              style: TextStyle(
                  color: Color.fromARGB(255, 247, 246, 246),
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500),
            ),
          ),

          ///sending to view the todo
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SingleTodoView(
                        todoId: todoId,
                        todoName: name,
                        desc: desc,
                        dueDate: date,
                        setTime: time,
                        createdOn: createdDate)),
              );
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(40.w, 13.h, 0, 0.h),
              alignment: Alignment.center,
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 9, 48, 78),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                "View",
                style:
                    TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => Scaffold(
        backgroundColor: Color.fromARGB(255, 5, 56, 97),
        appBar: AppBar(
          actions: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 7.w),
              child: IconButton(
                icon: const Icon(
                  Icons.exit_to_app_rounded,
                  size: 28,
                ),
                onPressed: () {
                  // handle the press
                  showAlertDialog(context);
                },
              ),
            ),
          ],
          backgroundColor: Color.fromARGB(255, 6, 93, 165),
          centerTitle: true,
          title: Text(
            "Add Your Tasks",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("Todos")
                        .orderBy('createdOn', descending: true)
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          padding: EdgeInsets.only(top: 250),
                          alignment: Alignment.center,
                          child: SpinKitRotatingCircle(
                            color: Colors.cyan[600],
                            size: 100.0,
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.active) {
                        if (snapshot.data!.docs.isNotEmpty) {
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return showTodosTile(
                                  snapshot.data!.docs[index]['TodoName'],
                                  snapshot.data!.docs[index]['desc'],
                                  snapshot.data!.docs[index]['DueDate'],
                                  snapshot.data!.docs[index]['todoId'],
                                  snapshot.data!.docs[index]['createdOn']
                                      .toDate(),
                                  snapshot.data!.docs[index]['setTime'],
                                );
                              });
                        } else {
                          return Column(
                            children: <Widget>[
                              SizedBox(
                                height: 80,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 40.w),
                                child: Image(
                                  image: AssetImage("assets/img/no.jpg"),
                                  width: 300,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(50, 30, 0, 0),
                                child: Text(
                                  "No tasks to complete",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic),
                                ),
                              )
                            ],
                          );
                        }
                      } else {
                        return Text("error");
                      }
                    })
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.large(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddTodoScreen()),
            );
          },
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 29,
          ),
          backgroundColor: Color.fromARGB(255, 21, 89, 145),
          tooltip: 'add todos',
          elevation: 5,
          splashColor: Colors.grey,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
