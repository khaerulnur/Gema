import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/main.dart';
import 'package:flutter_ecommerce/screens/home/home.dart';
import 'package:flutter_ecommerce/screens/login.dart';
import 'package:flutter_ecommerce/screens/verify-email.dart';
import 'package:flutter_ecommerce/services/auth-service.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Utility/custom-loading.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacity;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 2500), vsync: this);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward().then((_) {
      navigationPage(context);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  navigationPage(BuildContext context) {
    final AuthService authController = AuthService();
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => StreamBuilder<User?>(
          stream: authController.streamAuthStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              CustomLoading().dismissLoading();
              return snapshot.data != null ? VerifyEmailScreen() : LoginScreen();
            } else {
              return CircularProgressIndicator(
                color: Colors.black54,
                strokeWidth: 2,
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#5956E9"),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.3),
              child: Opacity(
                opacity: opacity.value,
                child: Image.asset(
                  'assets/images/controller-icon.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Text(
              "GEMA",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "GAME ACCOUNT STORE",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.white),
                    children: const [
                      TextSpan(text: 'Powered by'),
                      TextSpan(
                          text: ' khaerul',
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
