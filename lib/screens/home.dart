import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "GEMA",
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: HexColor("#5956E9"),
      ),
      body: Column(
        children: [Text("PILIH PRODUK"),
          Expanded(
            child: GridView(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: <Widget>[
                Card(
                  child: Image.asset(
                    "assets/images/valorant.png",
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.all(10),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                ),
                Card(
                  child: Image.asset(
                    "assets/images/csgo.jpg",
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.all(10),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                ),
                Card(
                  child: Image.asset(
                    "assets/images/mobilelegend.jpg",
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.all(10),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                ),
                Card(
                  child: Image.asset(
                    "assets/images/fifa23.jpg",
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.all(10),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
