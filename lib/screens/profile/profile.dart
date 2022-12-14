import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/services/auth.dart';
import 'package:hexcolor/hexcolor.dart';

import '../home/home.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.only(left: 38, top: 40, bottom: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Khaerul Nur\nHaerulnur31@gmail.com\n081234567891",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: "Montserrat",
                        fontSize: 14),
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
                        builder: (BuildContext context) => const HomeScreen(),
                      ),
                    );
                  },
                ),
                Divider(),
                buildMenuItem("Edit Profile", () {}),
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
