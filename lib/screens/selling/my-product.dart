import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/screens/product/list-my-product.dart';
import 'package:hexcolor/hexcolor.dart';

class MyProductScreen extends StatefulWidget {
  const MyProductScreen({Key? key}) : super(key: key);

  @override
  State<MyProductScreen> createState() => _MyProductScreenState();
}

class _MyProductScreenState extends State<MyProductScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            shadowColor: HexColor("#5956E9"),
            backgroundColor: HexColor("#5956E9"),
            title: Text("Produk Saya"),
            leading: Container(),
            centerTitle: true,
            bottom: TabBar(
              tabs: const <Widget>[
                Tab(
                  child: Text("Live", textAlign: TextAlign.center),
                ),
                Tab(
                  child: Text("Habis", textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              ListMyOrderProductScreen(statusProduct: 'available'),
              ListMyOrderProductScreen(statusProduct: 'sold'),
            ],
          ),
        ),
      ),
    );
  }
}
