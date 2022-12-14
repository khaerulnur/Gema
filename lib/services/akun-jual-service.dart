import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

var db = FirebaseFirestore.instance;
final CollectionReference idPenjual = FirebaseFirestore.instance.collection("");

Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
    readAccountValorant() {
  return db
      .collection("valorantAccount")
      .orderBy("waktuPost", descending: true)
      .get()
      .then((snapshot) => snapshot.docs);
}

Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> readAccountCsgo() {
  return db
      .collection("csgoAccount")
      .orderBy("waktuPost", descending: true)
      .get()
      .then((snapshot) => snapshot.docs);
}

Future<void> addAccountService(
    String deskripsi, int harga, String tautanGambar) {
  final User? uId = FirebaseAuth.instance.currentUser;
  return db.collection("Account").add(
    {
      'deskirpsi': deskripsi,
      'harga': harga,
      'idPenjual': uId,
      'status': 'available',
      'tautanGambar': tautanGambar,
      'waktuPost': Timestamp.fromDate(DateTime.now()),
    },
  );
}

Future<String> uploadPic(File filePhoto) async {
  UploadTask? uploadTask;

  final ref = FirebaseStorage.instance.ref().child("account-pic/");
  uploadTask = ref.putFile(filePhoto);
  final snapshot = await uploadTask.whenComplete(() {});
  final urlDownload = await snapshot.ref.getDownloadURL();
  return urlDownload;
}
