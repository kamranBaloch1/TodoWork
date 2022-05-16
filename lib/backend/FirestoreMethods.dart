import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todos/pages/homePage.dart';
import 'package:uuid/uuid.dart';

class FiresStoreMethods {
  addTodoToFireStore(
      String name, String desc, String dueDate, String time) async {
    try {
      String uuid = Uuid().v4();
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("Todos")
          .doc(uuid)
          .set({
        "todoId": uuid,
        "TodoName": name,
        "DueDate": dueDate,
        "setTime": time,
        "desc": desc,
        "currentUid": FirebaseAuth.instance.currentUser!.uid,
        "createdOn": DateTime.now()
      }).then((value) {
        Fluttertoast.showToast(
            msg: "Todo is been added", toastLength: Toast.LENGTH_LONG);
        Get.offAll(HomeScreen());
      });
    } catch (err) {
      Fluttertoast.showToast(
          msg: "Something went wrong!", toastLength: Toast.LENGTH_LONG);
    }
  }

  Deleteodo(String todoId) {
    try {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("Todos")
          .doc(todoId)
          .delete()
          .then((value) {
        Fluttertoast.showToast(
            msg: "Task is been deleted", toastLength: Toast.LENGTH_LONG);
        Get.offAll(HomeScreen());
      });
    } catch (err) {
      Fluttertoast.showToast(
          msg: "Something went wrong!", toastLength: Toast.LENGTH_LONG);
    }
  }

  // EditTodos(String todoId, String todoname, String todoDesc, String todoDate) {
  //   FirebaseFirestore.instance.collection("Todos").doc(todoId).update({
  //     "TodoName": todoname,
  //     "DueDate": todoDate,
  //     "desc": todoDesc
  //   }).then((value) {
  //     Fluttertoast.showToast(
  //         msg: "Task is been updated", toastLength: Toast.LENGTH_LONG);
  //   });
  // }
}
