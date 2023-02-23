import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ecommerce/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecommerce/screens/login.dart';
import 'package:flutter_ecommerce/screens/product/product-detail.dart';
import 'package:flutter_ecommerce/screens/profile/edit-profile.dart';
import 'package:flutter_ecommerce/screens/register.dart';
import 'package:flutter_ecommerce/services/auth-service.dart';
import 'package:flutter_ecommerce/utility/custom-loading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final AuthService authController = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authController.streamAuthStatus(),
      builder: (context, snapshot) {
        print(snapshot);
        if (snapshot.connectionState == ConnectionState.active) {
          CustomLoading().dismissLoading();
          return MaterialApp(
            builder: EasyLoading.init(),
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: snapshot.data != null ? HomeScreen() : LoginScreen(),
          );
        } else {
          return CircularProgressIndicator(
            color: Colors.black54,
            strokeWidth: 2,
          );
        }
      },
    );
  }
}
