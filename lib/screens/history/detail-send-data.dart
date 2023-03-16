import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/screens/chat/chat-screen.dart';
import 'package:flutter_ecommerce/screens/home/home.dart';
import 'package:flutter_ecommerce/services/profile-service.dart';
import 'package:flutter_ecommerce/services/service.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Utility/custom-loading.dart';

class DetailSendDataScreen extends StatefulWidget {
  const DetailSendDataScreen(
      {Key? key,
      required this.totalHarga,
      required this.metodePembayaran,
      required this.documentReference,
      required this.idProduct,
      required this.waktuPost,
      required this.idPenjual,
      required this.idOrder})
      : super(key: key);
  final double totalHarga;
  final String metodePembayaran;
  final String documentReference;
  final String idProduct;
  final String waktuPost;
  final String idPenjual;
  final String idOrder;
  @override
  State<DetailSendDataScreen> createState() => _DetailSendDataScreenState();
}

class _DetailSendDataScreenState extends State<DetailSendDataScreen> {
  DocumentSnapshot<Map<String, dynamic>>? dataPenjual;
  DocumentSnapshot<Map<String, dynamic>>? dataProduct;
  @override
  void initState() {
    super.initState();
    getDataPenjual();
    getDataAccount();
  }

  Future<void> getDataPenjual() async {
    var data = await ProfileService().getUserById(widget.idPenjual);
    setState(() {
      dataPenjual = data;
    });
  }

  Future<void> getDataAccount() async {
    var data = await readAccountById(widget.idProduct);
    setState(() {
      dataProduct = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back_outlined),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            "Detail Pesanan",
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
      body: dataPenjual != null && dataProduct != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rowGlobal(
                    "Order Id :",
                    widget.documentReference,
                  ),
                  rowGlobal("Tanggal Pembelian", widget.waktuPost),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(thickness: 2),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Detail Pesanan",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.shopping_bag,
                            color: HexColor("#5956E9"),
                          ),
                          Text(
                            dataPenjual!["firstName"].toString() +
                                " " +
                                dataPenjual!["lastName"].toString(),
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Image.network(
                            dataProduct!["tautanGambar"],
                            height: 50,
                            width: 50,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dataProduct!["gameType"],
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  dataProduct!["deskripsi"],
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Harga : Rp.${dataProduct!["harga"]}",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(thickness: 2),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Rincian Pembayaran",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  rowGlobal("Metode Pembayaran", widget.metodePembayaran),
                  rowGlobal(
                    "Total Harga",
                    "Rp.${widget.totalHarga}",
                  ),
                ],
              ),
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        children: [
          Expanded(
            child: InkWell(
              child: Container(
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: HexColor("#5956E9"),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Chat",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ChatScreen(),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: InkWell(
              child: Container(
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: HexColor("#5956E9"),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: const Text(
                    "Selesaikan Pesanan",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              onTap: () {
                completeOrder(widget.idOrder);
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const HomeScreen(),
                  ),
                );
                showDialog(
                  context: context,
                  builder: (context) {
                    return dialogSuccess();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget dialogSuccess() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      )),
      contentPadding: EdgeInsets.only(top: 10.0),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 36),
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "Berhasil menyelesaikan pesanan ",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: SizedBox(
              height: 41,
              width: double.infinity,
              child: ElevatedButton(
                key: Key("btnOkSalahPasswordTransaksi"),
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: HexColor("#5956E9"),
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0))),
                onPressed: () {
                  Navigator.of(context).pop();
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
    );
  }

  Widget rowGlobal(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key,
          style: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
