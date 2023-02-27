import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/screens/product/payment-summary.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Utility/style-text.dart';

class ProductPaymentScreen extends StatefulWidget {
  const ProductPaymentScreen({Key? key, required this.data}) : super(key: key);
  final QueryDocumentSnapshot<Map<String, dynamic>> data;

  @override
  State<ProductPaymentScreen> createState() => _ProductPaymentScreenState();
}

class _ProductPaymentScreenState extends State<ProductPaymentScreen> {
  String metodePembayaran = 'BCA';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                "Bayar",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => PaymentSummaryScreen(
                    totalHarga: widget.data["harga"] + 2000,
                    metodePembayaran: metodePembayaran,
                  ),
                ),
              );
            },
          ),
        ),
        appBar: AppBar(
          shadowColor: HexColor("#5956E9"),
          backgroundColor: HexColor("#5956E9"),
          centerTitle: true,
          leading: InkWell(
            child: Icon(Icons.arrow_back_outlined),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Ringkasan Belanja'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.data["namaProduk"], style: GemaStyle.text14bold),
                  Text(
                    "Rp." + widget.data["harga"].toString(),
                    style: GemaStyle.textblack14normal,
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                widget.data["gameType"],
                style: GemaStyle.textblack14normal,
              ),
              SizedBox(height: 5),
              Text(widget.data["namaPenjual"],
                  style: GemaStyle.textblack14normal),
              Divider(thickness: 5),
              Text("Metode Pembayaran", style: GemaStyle.text14bold),
              SizedBox(height: 5),
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(metodePembayaran),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    )
                  ],
                ),
                onTap: () {
                  _showModalBottomSheetMetodePembayaran();
                },
              ),
              SizedBox(height: 5),
              Divider(thickness: 5),
              SizedBox(height: 5),
              Text("Detail Pembayaran", style: GemaStyle.text14bold),
              SizedBox(height: 5),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      rowDetail("Metode pembayaran", metodePembayaran),
                      SizedBox(height: 5),
                      Divider(thickness: 1),
                      SizedBox(height: 5),
                      rowDetail(
                        "Total Pesanan",
                        "Rp." + widget.data["harga"].toString(),
                      ),
                      SizedBox(height: 5),
                      rowDetail("Biaya Admin", "2000"),
                      SizedBox(height: 5),
                      Divider(thickness: 1),
                      SizedBox(height: 5),
                      rowDetail(
                        "Total Pembayaran",
                        "Rp." + (widget.data["harga"] + 2000).toString(),
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    width: 0.7,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showModalBottomSheetMetodePembayaran() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, StateSetter setStateModal) {
            return Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(21),
                  topRight: Radius.circular(21),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/bottom-sheet-icon.png",
                      width: 38,
                    ),
                  ),
                  SizedBox(
                    height: 27,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        child: Icon(Icons.arrow_back, size: 25),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Metode Pembayaran",
                        style: GemaStyle.textblack14normal,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pilih Metode Pembayaran",
                        style: GemaStyle.textblack14normal,
                      ),
                      InkWell(
                        child: Container(
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("BCA "),
                                metodePembayaran == "BCA "
                                    ? Icon(Icons.radio_button_checked,
                                        color: HexColor('#2C7381'), size: 20)
                                    : Icon(Icons.radio_button_unchecked,
                                        color: HexColor("#D9DEEA"), size: 20)
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              width: 0.7,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            metodePembayaran = "BCA ";
                          });
                          setStateModal(() {
                            metodePembayaran = "BCA ";
                          });
                        },
                      ),
                      InkWell(
                        child: Container(
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("OVO"),
                                metodePembayaran == "OVO"
                                    ? Icon(Icons.radio_button_checked,
                                        color: HexColor('#2C7381'), size: 20)
                                    : Icon(Icons.radio_button_unchecked,
                                        color: HexColor("#D9DEEA"), size: 20)
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              width: 0.7,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            metodePembayaran = "OVO";
                          });
                          setStateModal(() {
                            metodePembayaran = "OVO";
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget rowDetail(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GemaStyle.textblack14normal),
        Text(value, style: GemaStyle.textblack14normal),
      ],
    );
  }
}
