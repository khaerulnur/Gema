import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecommerce/screens/profile/edit-profile.dart';

class ProfileService {
  var db = FirebaseFirestore.instance;

  Future<void> setUser(
    String firstName,
    String lastName,
    String noHp,
    String email,
  ) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    return db.collection("user").doc(firebaseUser!.uid).set(
      {
        "firstName": firstName,
        "lastName": lastName,
        "noHp": noHp,
        "email": email,
        "createdAt": FieldValue.serverTimestamp()
      },
    );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    print(firebaseUser!.uid);
    return db.collection("user").doc(firebaseUser.uid).get();
  }
}
