import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todos/backend/FirestoreMethods.dart';

class SingleTodoView extends StatefulWidget {
  String todoId;
  String todoName;
  String desc;
  String dueDate;
  DateTime createdOn;
  String setTime;
  SingleTodoView(
      {required this.todoId,
      required this.dueDate,
      required this.createdOn,
      required this.desc,
      required this.setTime,
      required this.todoName});

  @override
  State<SingleTodoView> createState() => _SingleTodoViewState();
}

class _SingleTodoViewState extends State<SingleTodoView>
    with TickerProviderStateMixin {
  @override
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _dateinput = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _desc = TextEditingController();

  DeleteTodoFunc() async {
    setState(() {
      isLoading = true;
    });
    await FiresStoreMethods().Deleteodo(widget.todoId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => Scaffold(
        backgroundColor: Color.fromARGB(255, 5, 56, 97),
        body: isLoading
            ? Center(
                child: SpinKitSquareCircle(
                color: Color.fromARGB(255, 100, 179, 243),
                size: 100.0,
                controller: AnimationController(
                    vsync: this, duration: const Duration(milliseconds: 1200)),
              ))
            : SingleChildScrollView(
                child: SafeArea(
                    child: Container(
                  margin: EdgeInsets.fromLTRB(0.w, 30.h, 0, 0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.fromLTRB(20.w, 20.h, 0, 0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  widget.todoName,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              // IconButton(
                              //     onPressed: () {},
                              //     icon: Icon(
                              //       Icons.edit,
                              //       color: Colors.blue,
                              //       size: 26,
                              //     ))
                            ],
                          )),
                      Container(
                        width: 300.w,
                        child: Divider(
                          height: 60.h,
                          thickness: 1.3,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15.w, 10.h, 8.w, 0),
                        child: Row(children: <Widget>[
                          Expanded(
                            child: Text(
                              widget.desc,
                              style: TextStyle(
                                  fontSize: 22,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          // IconButton(
                          //     onPressed: () {},
                          //     icon: Icon(
                          //       Icons.edit,
                          //       color: Colors.blue,
                          //       size: 26,
                          //     )),
                        ]),
                      ),

                      Container(
                        padding: EdgeInsets.fromLTRB(10.w, 20.h, 0, 0),
                        child: Row(children: <Widget>[
                          Text(
                            "Time",
                            style: TextStyle(
                                fontSize: 19,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500),
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Icon(
                                Icons.timelapse_rounded,
                                color: Colors.red,
                              )),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "||",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Text(
                              widget.setTime,
                              style: TextStyle(
                                  fontSize: 19,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ]),
                      ),

                      ///set Date
                      Container(
                        padding: EdgeInsets.fromLTRB(10.w, 20.h, 0, 0),
                        child: Row(children: <Widget>[
                          Text(
                            "Date",
                            style: TextStyle(
                                fontSize: 19,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500),
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Icon(
                                Icons.timelapse_rounded,
                                color: Colors.red,
                              )),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "||",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Text(
                              widget.dueDate,
                              style: TextStyle(
                                  fontSize: 19,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ]),
                      ),
                      GestureDetector(
                        onTap: () {
                          DeleteTodoFunc();
                        },
                        child: Container(
                          // margin: EdgeInsets.only(top: 80.h),
                          margin: EdgeInsets.fromLTRB(0, 50.h, 0, 70.h),
                          alignment: Alignment.center,
                          width: 120.w,
                          height: 42.h,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 189, 33, 22),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "Delete",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.5,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
              ),
      ),
    );
  }
}
