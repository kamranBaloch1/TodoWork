
// Future<void> _displayTextInputDialog(BuildContext context) async {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//               backgroundColor: Color.fromARGB(255, 8, 122, 175),
//               title: Text(
//                 'Edit Your task',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontStyle: FontStyle.italic,
//                     fontSize: 24.sp,
//                     fontWeight: FontWeight.w400),
//               ),
//               content: SingleChildScrollView(
//                 child: Form(
//                   // key: _formKey,
//                   child: Column(
//                     children: <Widget>[
//                       Divider(
//                         height: 60.h,
//                         thickness: 2,
//                         color: Colors.white,
//                       ),
//                       Container(
//                           margin: EdgeInsets.only(left: 20.w),
//                           width: 320.w,
//                           child: TextFormField(
//                             controller: _name,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter some text';
//                               }
//                               return null;
//                             },
//                             style: TextStyle(color: Colors.white),
//                             keyboardType: TextInputType.text,
//                             decoration: InputDecoration(
//                                 suffixIcon: Icon(
//                                   Icons.edit,
//                                   color: Colors.white,
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Color.fromARGB(255, 115, 185, 241),
//                                       width: 2),
//                                 ),
//                                 focusedBorder: new OutlineInputBorder(
//                                   borderRadius: new BorderRadius.circular(5.0),
//                                   borderSide:
//                                       BorderSide(color: Colors.white, width: 2),
//                                 ),
//                                 labelStyle: TextStyle(color: Colors.white),
//                                 hintStyle: TextStyle(color: Colors.white),
//                                 hintText: widget.todoName),
//                           )),
//                       SizedBox(
//                         height: 20.h,
//                       ),
//                       Container(
//                           margin: EdgeInsets.only(left: 20.w),
//                           width: 320.w,
//                           child: TextFormField(
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please set a Date';
//                               }
//                               return null;
//                             },
//                             style: TextStyle(color: Colors.white),
//                             controller:
//                                 _dateinput, //editing controller of this TextField
//                             decoration: InputDecoration(
//                                 suffixIcon: Icon(
//                                   Icons.calendar_month,
//                                   color: Colors.white,
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Color.fromARGB(255, 115, 185, 241),
//                                       width: 2),
//                                 ),
//                                 focusedBorder: new OutlineInputBorder(
//                                   borderRadius: new BorderRadius.circular(5.0),
//                                   borderSide:
//                                       BorderSide(color: Colors.white, width: 2),
//                                 ),
//                                 labelStyle: TextStyle(color: Colors.white),
//                                 hintStyle: TextStyle(color: Colors.white),
//                                 hintText: widget.dueDate),
//                             readOnly:
//                                 true, //set it true, so that user will not able to edit text
//                             onTap: () async {
//                               DateTime? pickedDate = await showDatePicker(
//                                   context: context,
//                                   initialDate: DateTime.now(),
//                                   firstDate: DateTime(
//                                       2000), //DateTime.now() - not to allow to choose before today.
//                                   lastDate: DateTime(2101));

//                               if (pickedDate != null) {
//                                 print(
//                                     pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
//                                 String formattedDate =
//                                     DateFormat('yyyy-MM-dd').format(pickedDate);
//                                 print(
//                                     formattedDate); //formatted date output using intl package =>  2021-03-16
//                                 //you can implement different kind of Date Format here according to your requirement

//                                 setState(() {
//                                   _dateinput.text =
//                                       formattedDate; //set output date to TextField value.
//                                 });
//                               } else {
//                                 print("Date is not selected");
//                               }
//                             },
//                           )

//                           // containerend
//                           ),
//                       SizedBox(
//                         height: 20.h,
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(left: 22.w),
//                         width: 320.w,
//                         child: TextFormField(
//                           controller: _desc,
//                           validator: (value) {
//                             if (value == null ||
//                                 value.isEmpty ||
//                                 value.length < 20) {
//                               return 'Description must be atleast 20 words';
//                             }
//                             return null;
//                           },
//                           style: TextStyle(color: Colors.white),
//                           keyboardType: TextInputType.multiline,
//                           minLines: 3, //Normal textInputField will be displayed
//                           maxLines:
//                               10, // when user presses enter it will adapt to it
//                           decoration: InputDecoration(
//                               suffixIcon: Icon(
//                                 Icons.description,
//                                 color: Colors.white,
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                     color: Color.fromARGB(255, 115, 185, 241),
//                                     width: 2),
//                               ),
//                               focusedBorder: new OutlineInputBorder(
//                                 borderRadius: new BorderRadius.circular(5.0),
//                                 borderSide:
//                                     BorderSide(color: Colors.white, width: 2),
//                               ),
//                               labelStyle: TextStyle(color: Colors.white),
//                               hintStyle: TextStyle(color: Colors.white),
//                               labelText: widget.desc),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20.h,
//                       ),
//                       GestureDetector(
//                         onTap: () {},
//                         child: CircleAvatar(
//                           backgroundColor: Colors.green,
//                           radius: 30.r,
//                           child:
//                               Icon(Icons.check, color: Colors.white, size: 32),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ));
//         });
//   }

 
 