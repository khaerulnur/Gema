import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class UserProfileBrowse {
  String userId;
  int age;
  String name;
  String email;
  String imageUrl;

  UserProfileBrowse(
    this.userId,
    this.age,
    this.name,
    this.email,
    this.imageUrl,
  );

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'userId': userId,
        'name': name,
        'email': email,
      };
}

TextEditingController displayNameController = TextEditingController();
TextEditingController ageController = TextEditingController();
bool isLoading = false;
User? user;
UserProfileBrowse? userModel;
String? imageUrl;
bool showPassword = false;

class _EditProfileState extends State<EditProfile> {
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
          onPressed: () {},
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
                height: 15,
              ),
              Container(
                child: Center(
                  child: Text(
                    "KR",
                    style: TextStyle(
                      color: HexColor("5956E9"),
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      fontFamily: "Montserrat",
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 3,
                      color: Color.fromARGB(255, 126, 121, 121),
                    ),
                    shape: BoxShape.circle),
                width: 60,
                height: 60,
              ),
              const SizedBox(
                height: 35,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Nama"),
                controller: displayNameController,
                keyboardType: TextInputType.name,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Email"),

                controller: ageController,
                //
                keyboardType: TextInputType.name,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "No.Hp"),
                controller: displayNameController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "CANCEL",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
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
