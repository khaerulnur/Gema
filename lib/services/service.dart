import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ecommerce/models/user-model.dart';
import 'package:flutter_ecommerce/screens/profile/edit-profile.dart';

var db = FirebaseFirestore.instance;

Future<QuerySnapshot<Map<String, dynamic>>> readAccount(String gameType) {
  final String uId = FirebaseAuth.instance.currentUser!.uid;
  return db
      .collection("gameAccount")
      .where("gameType", isEqualTo: gameType)
      .where("idPenjual", isNotEqualTo: uId)
      .orderBy("idPenjual", descending: true)
      .orderBy("waktuPost", descending: true)
      .get();
}

Future<DocumentReference<Map<String, dynamic>>> addPaymentProof(
    String tautanGambar, String idProduk) async {
  final String uId = FirebaseAuth.instance.currentUser!.uid;
  return db.collection("paymentProof").add(
    {
      'idPembeli': uId,
      'tautanGambar': tautanGambar,
      'waktuTransaksi': Timestamp.fromDate(DateTime.now()),
    },
  );
}

Future<DocumentReference<Map<String, dynamic>>> addAccountService(
    String deskripsi,
    int harga,
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
