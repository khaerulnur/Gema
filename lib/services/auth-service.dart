import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/services/profile-service.dart';
import 'package:flutter_ecommerce/utility/wrongpass-dialog.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ProfileService profileService = ProfileService();
  Stream<User?> streamAuthStatus() {
    return _auth.authStateChanges();
  }

  Future login(String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
      if (e.toString() ==
          '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
        wrongPassTransactionAlertDialog(
            context, 'Password atau Email yang DiMasukkan Salah');
      } else if (e.toString() ==
          '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
        wrongPassTransactionAlertDialog(
            context, 'Password atau Email yang DiMasukkan Salah');
      }
    }
  }

  // Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<UserCredential?> registerWithEmailAndPassword(
      BuildContext context,
      String email,
      String password,
      String firstName,
      String lastName,
      String noHp) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      profileService.setUser(firstName, lastName, noHp, email);

      return result;
    } catch (e) {
      wrongPassTransactionAlertDialog(
          context, "Email yang diMasukkan Telah Digunakan");
      return null;
    }
  }
}
