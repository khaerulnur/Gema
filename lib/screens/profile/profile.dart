import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/screens/profile/edit-profile.dart';
import 'package:flutter_ecommerce/services/auth-service.dart';
import 'package:flutter_ecommerce/services/profile-service.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../utility/custom-loading.dart';
import '../home/home.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: ProfileService().getUser(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            color: Colors.white10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: HexColor("5956E9"),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  height: 140,
                  width: double.infinity,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 38, top: 40, bottom: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Center(
                            child: Text(
                              snapshot.data!["firstName"]
                                      .toString()
                                      .substring(0, 1).toUpperCase() +
                                  snapshot.data!["lastName"]
                                      .toString()
                                      .substring(0, 1).toUpperCase(),
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
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!["firstName"].toString() +
                                  " " +
                                  snapshot.data!["lastName"].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontFamily: "Montserrat",
                                  fontSize: 14),
                            ),
                            Text(
                              snapshot.data!["noHp"].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontFamily: "Montserrat",
                                  fontSize: 14),
                            ),
                            Text(
                              snapshot.data!["email"].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontFamily: "Montserrat",
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      buildMenuItem(
                        "Home",
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const HomeScreen(),
                            ),
                          );
                        },
                      ),
                      Divider(),
                      buildMenuItem("Edit Profile", () {
                         Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const EditProfile(),
                            ),
                          );
                      }),
                      Divider(),
                      buildMenuItem("Riwayat Pemesanan", () {}),
                      Divider(),
                      buildMenuItem("Chat", () {}),
                      Divider(),
                      buildMenuItem("FAQ", () {}),
                      Divider(),
                      buildMenuItem(
                        "Logout",
                        () {
                          AuthService().signOut();
                        },
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          CustomLoading().dismissLoading();
          print("tidak ada data");
          return Text("data");
        }
      },
    );
  }

  Widget buildMenuItem(String text, Function() onTap) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(
          fontFamily: "Montserrat",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: HexColor("5956E9"),
        ),
      ),
      onTap: onTap,
    );
  }
}
