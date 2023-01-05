import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

Future<void> addAccountService(String deskripsi, int harga, String tautanGambar,
    String gameSelected, String serverSelected) {
  final String uId = FirebaseAuth.instance.currentUser!.uid;
  if (gameSelected == 'Valorant') {
    return db.collection("valorantAccount").add(
      {
        'deskirpsi': deskripsi,
        'harga': harga,
        'idPenjual': uId,
        'status': 'available',
        'tautanGambar': tautanGambar,
        'waktuPost': Timestamp.fromDate(DateTime.now()),
        'gameType': gameSelected,
        'server': serverSelected,
      },
    );
  } else if (gameSelected == "CSGO") {
    return db.collection("csgoAccount").add(
      {
        'deskirpsi': deskripsi,
        'harga': harga,
        'idPenjual': uId,
        'status': 'available',
        'tautanGambar': tautanGambar,
        'waktuPost': Timestamp.fromDate(DateTime.now()),
        'gameType': gameSelected,
        'server': serverSelected,
      },
    );
  } else if (gameSelected == "Mobile Legend") {
    return db.collection("mobileLegendAccount").add(
      {
        'deskirpsi': deskripsi,
        'harga': harga,
        'idPenjual': uId,
        'status': 'available',
        'tautanGambar': tautanGambar,
        'waktuPost': Timestamp.fromDate(DateTime.now()),
        'gameType': gameSelected,
        'server': serverSelected,
      },
    );
  } else {
    return db.collection("fifa23Account").add(
      {
        'deskirpsi': deskripsi,
        'harga': harga,
        'idPenjual': uId,
        'status': 'available',
        'tautanGambar': tautanGambar,
        'waktuPost': Timestamp.fromDate(DateTime.now()),
        'gameType': gameSelected,
        'server': serverSelected,
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
