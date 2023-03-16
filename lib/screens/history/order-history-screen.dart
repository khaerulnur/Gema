import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/screens/product/payment-summary.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../services/service.dart';
import 'list-order-history.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: DefaultTabController(
        initialIndex: 0,
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            shadowColor: HexColor("#5956E9"),
            backgroundColor: HexColor("#5956E9"),
            title: Text("Daftar Pemesanan"),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              tabs: const <Widget>[
                Tab(
                  child: Text("Semua Pesanan", textAlign: TextAlign.center),
                ),
                Tab(
                  child:
                      Text("Menunggu Pembayaran", textAlign: TextAlign.center),
                ),
                Tab(
                  child:
                      Text("Menunggu Konfirmasi", textAlign: TextAlign.center),
                ),
                Tab(
                  child: Text("Proses Pengiriman", textAlign: TextAlign.center),
                ),
                Tab(
                  child: Text("Pesanan Selesai", textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ListOrderHistoryScreen(
                  stream: readPurchaseHistory(), route: "verify"),
              ListOrderHistoryScreen(
                  stream: readPurchaseHistoryPending(), route: "pending"),
              ListOrderHistoryScreen(
                  stream: readPurchaseHistoryVerify(), route: "verify"),
              ListOrderHistoryScreen(
                  stream: readPurchaseHistoryPaid(), route: "paid"),
              ListOrderHistoryScreen(
                  stream: readPurchaseHistoryComplete(), route: "complete"),
            ],
          ),
        ),
      ),
    );
  }
}
