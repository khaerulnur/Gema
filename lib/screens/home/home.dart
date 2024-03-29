import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/screens/additem/preview-image.dart';
import 'package:flutter_ecommerce/screens/chat/chat-screen.dart';
import 'package:flutter_ecommerce/screens/home/home-content.dart';
import 'package:flutter_ecommerce/screens/profile/profile.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../selling/my-product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isProfile = false;

  Widget generateListPage(BuildContext context) {
    List<Widget> opsiWidget = <Widget>[
      homeContent(context),
      ChatScreen(routeFrom: 'home',),
      Text("Sell3"),
      MyProductScreen(),
      ProfileScreen(),
    ];
    return opsiWidget.elementAt(selectedIndex);
  }

  late File imageFile;
  int selectedIndex = 0;
  final scaffoldState = GlobalKey<ScaffoldState>();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        key: scaffoldState,
        appBar: isProfile
            ? null
            : AppBar(
                title: Center(
                  child: Text(
                    "GEMA",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
                automaticallyImplyLeading: false,
                backgroundColor: HexColor("#5956E9"),
              ),
        body: generateListPage(context),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          // ignore: prefer_const_literals_to_create_immutables
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline_rounded), label: "Sell"),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "My Ads",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: "Profile"),
          ],
          selectedItemColor: HexColor("#5956E9"),
          unselectedItemColor: Colors.grey,
          currentIndex: selectedIndex,
          onTap: (index) {
            if (index == 0) {
              setState(() {
                isProfile = false;
                selectedIndex = index;
              });
            } else if (index == 1) {
              setState(() {
                isProfile = true;
                selectedIndex = index;
              });
            } else if (index == 2) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 500),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: _getFromCamera,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Center(
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: HexColor("5956E9"),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            width: 3,
                                            color: Color.fromARGB(
                                                255, 126, 121, 121),
                                          ),
                                          shape: BoxShape.circle),
                                      width: 60,
                                      height: 60,
                                    ),
                                    Text(
                                      "Take a Picture",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: _getFromGallery,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Center(
                                        child: Icon(
                                          Icons.photo_album,
                                          color: HexColor("5956E9"),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            width: 3,
                                            color: Color.fromARGB(
                                                255, 126, 121, 121),
                                          ),
                                          shape: BoxShape.circle),
                                      width: 60,
                                      height: 60,
                                    ),
                                    Text(
                                      "Choose From Album",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            } else {
              setState(() {
                isProfile = true;
                selectedIndex = index;
              });
            }
          },
          showSelectedLabels: true,
        ),
      ),
    );
  }

  Future _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(
        () {
          imageFile = File(pickedFile.path);
        },
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return PreviewImageScreen(imageFile: imageFile);
          },
        ),
      );
    }
  }

  Future _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(
        () {
          imageFile = File(pickedFile.path);
        },
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return PreviewImageScreen(imageFile: imageFile);
          },
        ),
      );
    }
  }
}
