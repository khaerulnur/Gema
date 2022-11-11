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
      body: GridView(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: <Widget>[
          Card(
            child: Column(
              children: [
                Image.asset(
                    "assets/images/valorant.png")
              ],
            ),
          ),
          FlutterLogo( ),
          FlutterLogo(),
          FlutterLogo(),
        ],
      ),
    );
  }
}
