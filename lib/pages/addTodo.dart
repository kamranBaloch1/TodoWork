import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todos/backend/FirestoreMethods.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen>
    with TickerProviderStateMixin {
  TextEditingController dateinput = TextEditingController();
  TextEditingController titleC = TextEditingController();
  TextEditingController descC = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  String? _selectedTime;

  // We don't need to pass a context to the _show() function
  // You can safety use context as below
  Future<void> _show() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedTime = result.format(context);
      });
    }
  }

  addTodoData() async {
    setState(() {
      isLoading = true;
    });
    if (_selectedTime != null) {
      await FiresStoreMethods().addTodoToFireStore(titleC.text.trim(),
          descC.text.trim(), dateinput.text.trim(), _selectedTime.toString());

      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "Please set a time", toastLength: Toast.LENGTH_LONG);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => Scaffold(
        backgroundColor: Color.fromARGB(255, 5, 56, 97),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 6, 93, 165),
          title: Text('New Task'),
        ),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 70.h,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 20.w),
                            width: 320.w,
                            child: TextFormField(
                              controller: titleC,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 85, 155, 212),
                                        width: 2),
                                  ),
                                  focusedBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2),
                                  ),
                                  labelText: 'What task to be done ',
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintStyle: TextStyle(color: Colors.white),
                                  hintText: 'Task Name'),
                            )),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 20.w),
                            width: 320.w,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please set a Date';
                                }
                                return null;
                              },
                              style: TextStyle(color: Colors.white),
                              controller:
                                  dateinput, //editing controller of this TextField
                              decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.calendar_month,
                                    color: Colors.white,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 85, 155, 212),
                                        width: 2),
                                  ),
                                  focusedBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2),
                                  ),
                                  labelText: 'When it should be done',
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintStyle: TextStyle(color: Colors.white),
                                  hintText: 'Due Date'),
                              readOnly:
                                  true, //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(
                                        2000), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  //you can implement different kind of Date Format here according to your requirement

                                  setState(() {
                                    dateinput.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {
                                  print("Date is not selected");
                                }
                              },
                            )

                            // containerend
                            ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 22.w),
                          width: 320.w,
                          child: TextFormField(
                            controller: descC,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 20) {
                                return 'Description must be atleast 20 words';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.multiline,
                            minLines:
                                3, //Normal textInputField will be displayed
                            maxLines:
                                20, // when user presses enter it will adapt to it
                            decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.description,
                                  color: Colors.white,
                                ),
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
                                labelText: 'Describe your task',
                                labelStyle: TextStyle(color: Colors.white),
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Short Description'),
                          ),
                        ),

                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            _show();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 150.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                                _selectedTime != null
                                    ? _selectedTime!
                                    : "Set a time",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white)),
                          ),
                        ),

                        // ElevatedButton(
                        //     onPressed: _show, child: const Text('Pick a time')),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              addTodoData();
                            }
                          },
                          child: CircleAvatar(
                            radius: 30.r,
                            child: Icon(Icons.check,
                                color: Colors.white, size: 32),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
