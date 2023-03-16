import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/screens/history/detail-send-data.dart';
import 'package:flutter_ecommerce/screens/product/payment-summary.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import '../../Utility/custom-loading.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../services/service.dart';

class ListMyOrderProductScreen extends StatefulWidget {
  const ListMyOrderProductScreen({Key? key, required this.statusProduct})
      : super(key: key);

  final String statusProduct;
  @override
  State<ListMyOrderProductScreen> createState() =>
      _ListMyOrderProductScreenState();
}

class _ListMyOrderProductScreenState extends State<ListMyOrderProductScreen> {
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
          future: widget.statusProduct == 'sold'
              ? readListMyProductSold()
              : readListMyProductAvailable(),
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
                        onTap: () {},
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
                                                    .docs[index]["harga"]
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
}
