import 'package:cloud_firestore/cloud_firestore.dart';

var db = FirebaseFirestore.instance;

Stream<QuerySnapshot> readAccountValorant() {
  return db
      .collection("account")
      .orderBy("waktuPost", descending: true)
      .snapshots();
}

Stream<QuerySnapshot> readAccountCsgo() {
  return db
      .collection("account")
      .where("informasiGame", isEqualTo: "csgo")
      .orderBy("waktuPost", descending: true)
      .snapshots();
}
