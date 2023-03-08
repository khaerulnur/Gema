import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

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
        initialIndex: 1,
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
          body: const TabBarView(
            children: <Widget>[
              Center(
                child: Text("Semua Pesanan "),
              ),
              Center(
                child: Text("Menunggu Pembayaran"),
              ),
              Center(
                child: Text("Menunggu Konfirmasi"),
              ),
              Center(
                child: Text("Proses Pengiriman"),
              ),
              Center(
                child: Text("Pesanan Selesai"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
