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
final CollectionReference idPenjual = FirebaseFirestore.instance.collection("");

Future<QuerySnapshot<Map<String, dynamic>>> readAccountValorant() {
  return db
      .collection("valorantAccount")
      .orderBy("waktuPost", descending: true)
      .get();
}

Future<QuerySnapshot<Map<String, dynamic>>> readAccountCsgo() {
  return db
      .collection("csgoAccount")
      .orderBy("waktuPost", descending: true)
      .get();
}

Future<QuerySnapshot<Map<String, dynamic>>> readAccountFifa23() {
  return db
      .collection("fifa23Account")
      .orderBy("waktuPost", descending: true)
      .get();
}

Future<QuerySnapshot<Map<String, dynamic>>> readAccountMobileLegend() {
  return db
      .collection("mobileLegendAccount")
      .orderBy("waktuPost", descending: true)
      .get();
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

  if (gameSelected == 'Valorant') {
    return db.collection("valorantAccount").add(
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
  } else if (gameSelected == "CSGO") {
    return db.collection("csgoAccount").add(
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
  } else if (gameSelected == "Mobile Legend") {
    return db.collection("mobileLegendAccount").add(
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
  } else {
    return db.collection("fifa23Account").add(
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
