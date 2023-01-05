import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/Utility/style-text.dart';
import 'package:flutter_ecommerce/screens/home/home.dart';
import 'package:flutter_ecommerce/screens/register.dart';
import 'package:flutter_ecommerce/services/auth-service.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  bool passwordVisible = true;
  final formKey = GlobalKey<FormState>();
  AuthService authController = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: HexColor("#5956E9"),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 52,
                ),
                child: Text(
                  "WELCOME \n TO GEMA",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 55,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 35, right: 35),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Harap masukkan Email!";
                        } else if (!RegExp(
                                "^[a-zA-Z0-9.!#%&'+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)")
                            .hasMatch(value)) {
                          return "Harap Masukkan Email Valid";
                        }
                      },
                      controller: emailCtrl,
                      decoration: InputDecoration(
                        hintText: "Email",
                        fillColor: HexColor("#5956E9"),
                        prefixIcon: Icon(
                          Icons.email,
                          color: HexColor("#5956E9"),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: HexColor("#5956E9"),
                          ),
                        ),
                      ),
                      style: GemaStyle.text17semibold,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Harap Masukkan Password!";
                        }
                      },
                      obscureText: passwordVisible,
                      obscuringCharacter: '*',
                      controller: passCtrl,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(
                          Icons.lock,
                          color: HexColor("#5956E9"),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: HexColor("#5956E9"),
                          ),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: HexColor("#5956E9"),
                          ),
                        ),
                      ),
                      style: GemaStyle.text17semibold,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: HexColor("#5956E9"),
                        ),
                      ),
                      onTap: () {},
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: HexColor("#5956E9"),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      authController.login(emailCtrl.text, passCtrl.text,context);
                    }
                  },
                  child: Text("Login"),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              child: Text(
                "Create Account",
                style: TextStyle(
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: HexColor("#5956E9"),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const RegisterScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
