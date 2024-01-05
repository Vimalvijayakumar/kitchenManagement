import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kitchen_manager/data/models/stock_model.dart';

class Repository {
  final CollectionReference admin =
      FirebaseFirestore.instance.collection("admin");
  final CollectionReference stock =
      FirebaseFirestore.instance.collection('stock');
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

  Future<DocumentReference> addStock(StockModel stockdata) {
    return stock.add(stockdata.toJson());
  }

  Future<List<StockModel>> getStock() async {
    try {
      List<StockModel> listData = [];
      var data = await stock.get();
      if (data.docs.isNotEmpty) {
        listData =
            data.docs.map((e) => StockModel.fromJson(e.data(), e.id)).toList();
      }
      return listData;
    } catch (e) {
      return [];
    }
  }

  updateStock(String documentId, StockModel updateData) async {
    await stock
        .doc(documentId)
        .set(updateData.toJson(), SetOptions(merge: true));
  }

  Future<void> deletestock(String id) {
    return stock.doc(id).delete();
  }
}
