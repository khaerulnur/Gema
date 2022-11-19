import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce/screens/home.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Utility/style-text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController nohapeCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPassCtrl = TextEditingController();

  bool passwordVisible = true;
  bool confirmPassVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Register",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: HexColor("#5956E9"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Harap masukkan First Name";
                      }
                    },
                    controller: firstNameCtrl,
                    decoration: InputDecoration(
                      hintText: "First Name",
                      fillColor: HexColor("#5956E9"),
                    ),
                    style: GemaStyle.text17semibold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Harap Masukkan Last Name";
                      }
                    },
                    controller: lastNameCtrl,
                    decoration: InputDecoration(
                      hintText: "Last Name",
                    ),
                    style: GemaStyle.text17semibold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Harap Masukkan Nomor Hp";
                      } else if (value.length <= 12) {
                        return "Masukkan minimal 12 digit Nomor Hp";
                      }
                    },
                    controller: nohapeCtrl,
                    decoration: InputDecoration(
                      hintText: "No Hp",
                    ),
                    style: GemaStyle.text17semibold,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Harap masukkan Email";
                      } else if (!RegExp(
                              "^[a-zA-Z0-9.!#%&'+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)")
                          .hasMatch(value)) {
                        return "Harap Masukkan Email Valid";
                      }
                      return null;
                    },
                    controller: emailCtrl,
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                    style: GemaStyle.text17semibold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Harap Masukkan Password!";
                      } else if (value.length <= 8) {
                        return "Masukkan Minimal 8 Digit Password";
                      } else if (passwordCtrl.text != confirmPassCtrl.text) {
                        return ("Masukkan Password Yang Sama");
                      }
                    },
                    obscureText: passwordVisible,
                    obscuringCharacter: '*',
                    controller: passwordCtrl,
                    decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                    ),
                    style: GemaStyle.text17semibold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Harap Masukkan Konfirmasi Password!";
                      } else if (passwordCtrl.text != confirmPassCtrl.text) {
                        return ("Masukkan Password Yang Sama");
                      }
                    },
                    obscureText: confirmPassVisible,
                    obscuringCharacter: '*',
                    controller: confirmPassCtrl,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      suffixIcon: IconButton(
                        icon: Icon(confirmPassVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            confirmPassVisible = !confirmPassVisible;
                          });
                        },
                      ),
                    ),
                    style: GemaStyle.text17semibold,
                  ),
                ),
                SizedBox(
                  height: 200,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: SizedBox(
          height: 44,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: HexColor("#5956E9"),
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const HomeScreen(),
                  ),
                );
              }
            },
            child: Text("Create"),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
