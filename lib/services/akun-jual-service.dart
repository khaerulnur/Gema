import 'package:cloud_firestore/cloud_firestore.dart';

var db = FirebaseFirestore.instance;
final CollectionReference  idPenjual = FirebaseFirestore.instance.collection("");

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

Future<void> addAccountService(String deskripsi, int harga, 
    String status, String tautanGambar) {
  return db.collection("Account").add(
    {
      'deskirpsi': deskripsi,
      'harga': harga,
      'idPenjual': deskripsi,
      'status': status,
      'tautanGambar': tautanGambar,
      'waktuPost': Timestamp.fromDate(DateTime.now()),
    },
  );
}
