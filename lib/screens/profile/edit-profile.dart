import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../services/profile-service.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();

  TextEditingController noHpCtrl = TextEditingController();

  Future<void> getDataPenjual() async {
    var data = await ProfileService().getCurrentUser();
    setState(() {
      firstNameCtrl.text = data["firstName"];
      lastNameCtrl.text = data["lastName"];

      noHpCtrl.text = data["noHp"];
    });
  }

  @override
  void initState() {
    super.initState();
    getDataPenjual();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("5956E9"),
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 35,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "First name"),
                controller: firstNameCtrl,
                keyboardType: TextInputType.name,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "last name"),
                controller: lastNameCtrl,
                keyboardType: TextInputType.name,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "No.Hp"),
                controller: noHpCtrl,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "CANCEL",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await ProfileService().editProfile(
                          firstNameCtrl.text, lastNameCtrl.text, noHpCtrl.text);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
