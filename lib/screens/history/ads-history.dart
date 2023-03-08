import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AdsHistoryScreen extends StatefulWidget {
  const AdsHistoryScreen({Key? key}) : super(key: key);

  @override
  State<AdsHistoryScreen> createState() => _AdsHistoryScreenState();
}

class _AdsHistoryScreenState extends State<AdsHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: DefaultTabController(
        initialIndex: 1,
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            shadowColor: HexColor("#5956E9"),
            backgroundColor: HexColor("#5956E9"),
            title: Text("Daftar Penjualan"),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              tabs: const <Widget>[
                Tab(
                  child: Text("Semua Pesanan", textAlign: TextAlign.center),
                ),
                Tab(
                  child:
                      Text("Menunggu Konfirmasi", textAlign: TextAlign.center),
                ),
                Tab(
                  child:
                      Text("Menunggu Pengiriman", textAlign: TextAlign.center),
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
                child: Text("Menunggu Konfirmasi"),
              ),
              Center(
                child: Text("Menunggu Pengiriman"),
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
