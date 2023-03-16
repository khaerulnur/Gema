import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

var db = FirebaseFirestore.instance;

Future<QuerySnapshot<Map<String, dynamic>>> readAccount(String gameType) {
  final String uId = FirebaseAuth.instance.currentUser!.uid;
  return db
      .collection("gameAccount")
      .where("gameType", isEqualTo: gameType)
      .where("idPenjual", isNotEqualTo: uId)
      .where("status", isEqualTo: "available")
      .orderBy("idPenjual", descending: true)
      .orderBy("waktuPost", descending: true)
      .get();
}

Future<DocumentSnapshot<Map<String, dynamic>>> readAccountById(String id) {
  return db.collection("gameAccount").doc(id).get();
}

Future<DocumentReference<Map<String, dynamic>>> addAccountService(
    String deskripsi,
    String harga,
    String tautanGambar,
    String gameSelected,
    String serverSelected,
    String namaProduk) async {
  final String uId = FirebaseAuth.instance.currentUser!.uid;

  String firstName = '';
  String lastName = '';

  await db.collection('user').doc(uId).get().then((snapshot) {
    firstName = snapshot.data()!['firstName'].toString();
    lastName = snapshot.data()!['lastName'].toString();
  });
  return db.collection("gameAccount").add(
    {
      'deskripsi': deskripsi,
      'harga': harga,
      'idPenjual': uId,
      'namaPenjual': firstName + " " + lastName,
      'status': 'available',
      'tautanGambar': tautanGambar,
      'waktuPost': Timestamp.fromDate(DateTime.now()),
      'gameType': gameSelected,
      'server': serverSelected,
      'namaProduk': namaProduk,
    },
  );
}

Future<DocumentReference<Map<String, dynamic>>> orderService(
    String idPenjual, String idProduct) {
  final String uId = FirebaseAuth.instance.currentUser!.uid;
  return db.collection("order").add({
    'waktuPost': Timestamp.fromDate(DateTime.now()),
    'idPembeli': uId,
    'idPenjual': idPenjual,
    'idProduct': idProduct,
  });
}

Future<String> uploadPic(File filePhoto) async {
  UploadTask? uploadTask;
  String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  final ref = FirebaseStorage.instance.ref().child("account-pic/" + fileName);
  uploadTask = ref.putFile(filePhoto);
  final snapshot = await uploadTask.whenComplete(() {});
  final urlDownload = await snapshot.ref.getDownloadURL();
  return urlDownload;
}

Future<DocumentReference<Map<String, dynamic>>> productPurchase(
  String idProduct,
  double totalBayar,
  String urlBuktiPembayaran,
  String metodePembayaran,
  String idPenjual,
) {
  final String uId = FirebaseAuth.instance.currentUser!.uid;
  db.collection("gameAccount").doc(idProduct).set(
    {"status": "sold"},
    SetOptions(merge: true),
  );
  return db.collection("productPurchase").add({
    'waktuPost': Timestamp.fromDate(DateTime.now()),
    'idPembeli': uId,
    'idPenjual': idPenjual,
    'idProduct': idProduct,
    'totalBayar': totalBayar,
    'urlBuktiPembayaran':
        urlBuktiPembayaran.isEmpty ? null : urlBuktiPembayaran,
    'status': "pending",
    "metodePembayaran": metodePembayaran,
  });
}

addPaymentProof(String urlBuktiPambayaran, String id) {
  return db.collection("productPurchase").doc(id).set(
    {"urlBuktiPembayaran": urlBuktiPambayaran, "status": "verify"},
    SetOptions(merge: true),
  );
}

Future<QuerySnapshot<Map<String, dynamic>>> readPurchaseHistory() {
  final String uId = FirebaseAuth.instance.currentUser!.uid;
  return db
      .collection("productPurchase")
      .where("idPembeli", isEqualTo: uId)
      .orderBy("waktuPost", descending: true)
      .get();
}

Future<QuerySnapshot<Map<String, dynamic>>> readPurchaseHistoryPending() {
  final String uId = FirebaseAuth.instance.currentUser!.uid;
  return db
      .collection("productPurchase")
      .where("status", isEqualTo: "pending")
      .where("idPembeli", isEqualTo: uId)
      .orderBy("waktuPost", descending: true)
      .get();
}

Future<QuerySnapshot<Map<String, dynamic>>> readPurchaseHistoryVerify() {
  final String uId = FirebaseAuth.instance.currentUser!.uid;
  return db
      .collection("productPurchase")
      .where("status", isEqualTo: "verify")
      .where("idPembeli", isEqualTo: uId)
      .orderBy("waktuPost", descending: true)
      .get();
}

Future<QuerySnapshot<Map<String, dynamic>>> readPurchaseHistoryPaid() {
  final String uId = FirebaseAuth.instance.currentUser!.uid;
  return db
      .collection("productPurchase")
      .where("status", isEqualTo: "paid")
      .where("idPembeli", isEqualTo: uId)
      .orderBy("waktuPost", descending: true)
      .get();
}

Future<QuerySnapshot<Map<String, dynamic>>> readPurchaseHistoryComplete() {
  final String uId = FirebaseAuth.instance.currentUser!.uid;
  return db
      .collection("productPurchase")
      .where("status", isEqualTo: "complete")
      .where("idPembeli", isEqualTo: uId)
      .orderBy("waktuPost", descending: true)
      .get();
}

completeOrder(String id) {
  return db.collection("productPurchase").doc(id).set(
    {"status": "complete"},
    SetOptions(merge: true),
  );
}
