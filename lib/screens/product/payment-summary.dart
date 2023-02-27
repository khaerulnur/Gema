import 'dart:io';

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
      {Key? key, required this.totalHarga, required this.metodePembayaran})
      : super(key: key);
  final int totalHarga;
  final String metodePembayaran;
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
          onTap: () {
            _getFromGallery();
          },
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
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

  Future _getFromGallery() async {
    CustomLoading().showLoading();
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
    }
    String imageURL = await uploadPic(imageFile);
    addPaymentProof(imageURL, "2");
    CustomLoading().dismissLoading();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            )),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                      right: 25,
                      top: 10,
                    ),
                    child: Image.asset('assets/images/ic_selalu_salah.png',
                        width: 300),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 36),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        "Pesanan diproses",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Container(
                      height: 41,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: HexColor("#5956E9"),
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => HomeScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Ok",
                          style: TextStyle(
                              fontFamily: "montserrat",
                              fontWeight: FontWeight.w700,
                              /*letterSpacing: 0.3,*/
                              fontSize: 16,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
