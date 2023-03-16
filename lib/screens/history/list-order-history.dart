import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/screens/history/detail-send-data.dart';
import 'package:flutter_ecommerce/screens/product/payment-summary.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import '../../Utility/custom-loading.dart';
import 'package:intl/date_symbol_data_local.dart';

class ListOrderHistoryScreen extends StatefulWidget {
  const ListOrderHistoryScreen(
      {Key? key, required this.stream, required this.route})
      : super(key: key);
  final Future<QuerySnapshot<Map<String, dynamic>>>? stream;
  final String route;
  @override
  State<ListOrderHistoryScreen> createState() => _ListOrderHistoryScreenState();
}

class _ListOrderHistoryScreenState extends State<ListOrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: widget.stream,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData == false) {
              CustomLoading().showLoading();
              return Container();
            } else if (snapshot.data!.docs.isEmpty) {
              CustomLoading().dismissLoading();
              return Center(
                child: Text("Transaksi tidak ditemukan"),
              );
            } else {
              CustomLoading().dismissLoading();
              print(snapshot.data);
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (widget.route == 'verify' ||
                              widget.route == 'complete') {
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => selectRoute(
                                    snapshot.data!.docs[index]["totalBayar"]
                                        .toString(),
                                    snapshot.data!.docs[index]
                                        ["metodePembayaran"],
                                    snapshot.data!.docs[index].id,
                                    snapshot.data!.docs[index]["idProduct"],
                                    snapshot.data!.docs[index]["waktuPost"]
                                        .toDate(),
                                    snapshot.data!.docs[index]["idPenjual"],
                                    snapshot.data!.docs[index].id),
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(bottom: 10, left: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: HexColor("#F1F1F1"),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Image.asset(
                                      "assets/images/bag.png",
                                      width: 18,
                                      height: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              top: 0, bottom: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot
                                                    .data!.docs[index]["status"]
                                                    .toString(),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                DateFormat.yMMMMd('id').format(
                                                    snapshot
                                                        .data!
                                                        .docs[index]
                                                            ["waktuPost"]
                                                        .toDate()),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                snapshot.data!
                                                    .docs[index]["totalBayar"]
                                                    .toString(),
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color: HexColor("E3E3E3"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget selectRoute(
      String totalHarga,
      String metodePembayaran,
      String documentReference,
      String idProduct,
      DateTime waktuPost,
      String idPenjual,
      String idOrder) {
    if (widget.route == "pending") {
      return PaymentSummaryScreen(
        totalHarga: double.parse(totalHarga) + 2000,
        metodePembayaran: metodePembayaran,
        documentReference: documentReference,
        routeFrom: 'history',
      );
    } else if (widget.route == "paid") {
      return DetailSendDataScreen(
        totalHarga: double.parse(totalHarga),
        metodePembayaran: metodePembayaran,
        documentReference: documentReference,
        idProduct: idProduct,
        waktuPost: DateFormat.yMMMMd('id').format(waktuPost),
        idPenjual: idPenjual, idOrder: idOrder,
      );
    } else {
      return PaymentSummaryScreen(
        totalHarga: double.parse(totalHarga) + 2000,
        metodePembayaran: metodePembayaran,
        documentReference: documentReference,
        routeFrom: 'history',
      );
    }
  }
}
