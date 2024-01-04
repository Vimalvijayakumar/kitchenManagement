import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Repository {
  final CollectionReference admin =
      FirebaseFirestore.instance.collection("admin");
  var authInstance = FirebaseAuth.instance;
  Future login(String email, String password) async {
    var data = await authInstance.signInWithEmailAndPassword(
        email: email, password: password);
    return Future.value(data);
  }

  Future chkAdmin(String email) async {
    QuerySnapshot data = await admin.where("email", isEqualTo: email).get();
    if (data.docs.isEmpty) {
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
