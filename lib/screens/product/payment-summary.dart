import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce/Utility/custom-loading.dart';
import 'package:flutter_ecommerce/Utility/style-text.dart';
import 'package:flutter_ecommerce/screens/additem/preview-image.dart';
import 'package:flutter_ecommerce/screens/home/home.dart';
import 'package:flutter_ecommerce/screens/profile/edit-profile.dart';
import 'package:flutter_ecommerce/services/service.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class PaymentSummaryScreen extends StatefulWidget {
  const PaymentSummaryScreen(
      {Key? key,
      required this.totalHarga,
      required this.metodePembayaran,
      required this.documentReference})
      : super(key: key);
  final double totalHarga;
  final String metodePembayaran;
  final DocumentReference<Map<String, dynamic>> documentReference;
  @override
  State<PaymentSummaryScreen> createState() => _PaymentSummaryScreenState();
}

class _PaymentSummaryScreenState extends State<PaymentSummaryScreen> {
  late File imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: InkWell(
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            decoration: BoxDecoration(
              color: HexColor("#5956E9"),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "Upload bukti pembayaran",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          onTap: () async {
            await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return takePicture();
                });
            String imageURL = await uploadPic(imageFile);
            addPaymentProof(imageURL, widget.documentReference.id);
          },
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const HomeScreen(),
              ),
            );
          },
        ),
        title: Center(
          child: Text(
            "Pembayaran",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.timer,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Selesaikan Pembayaran Sebelum",
                        style: GemaStyle.textblack14normal,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "22.25 WIB",
                        style: GemaStyle.textblack15semibold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(
                  Icons.attach_money,
                  color: Colors.grey,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    "Transfer Ke ",
                    style: GemaStyle.textblack14normal,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 29),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "KHAERUL NUR",
                    style: GemaStyle.textblack14normal,
                  ),
                  widget.metodePembayaran == "BCA"
                      ? Image.asset(
                          "assets/images/bca-logo.png",
                          fit: BoxFit.fitWidth,
                          width: 40,
                          height: 40,
                        )
                      : Image.asset(
                          "assets/images/ovo-logo.jpg",
                          fit: BoxFit.fitWidth,
                          width: 40,
                          height: 40,
                        )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 29),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.metodePembayaran == "BCA"
                      ? Text(
                          "7112131231",
                          style: GemaStyle.textblack15semibold,
                        )
                      : Text(
                          "089513904031",
                          style: GemaStyle.textblack15semibold,
                        ),
                  InkWell(
                    onTap: () async {
                      await Clipboard.setData(widget.metodePembayaran == "BCA"
                          ? ClipboardData(text: "7112131231")
                          : ClipboardData(text: "089513904031"));
                    },
                    child: Text(
                      "Salin",
                      style: GemaStyle.textblue15semibold,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 29),
              child: Text(
                "Jumlah bayar",
                style: GemaStyle.textblack14normal,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 29),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rp. " + widget.totalHarga.toString(),
                    style: GemaStyle.textblack15semibold,
                  ),
                  InkWell(
                    onTap: () async {
                      await Clipboard.setData(
                          ClipboardData(text: widget.totalHarga.toString()));
                    },
                    child: Text(
                      "Salin",
                      style: GemaStyle.textblue15semibold,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  takePicture() {
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
                            color: Color.fromARGB(255, 126, 121, 121),
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
                            color: Color.fromARGB(255, 126, 121, 121),
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
      Navigator.pop(context);
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
      Navigator.pop(context);
    }
  }
}

Future<String> uploadPic(File filePhoto) async {
  UploadTask? uploadTask;
  String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  final ref = FirebaseStorage.instance.ref().child("ss-payment/" + fileName);
  uploadTask = ref.putFile(filePhoto);
  final snapshot = await uploadTask.whenComplete(() {});
  final urlDownload = await snapshot.ref.getDownloadURL();
  return urlDownload;
}
