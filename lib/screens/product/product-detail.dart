import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/screens/product/product-payment.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key, required this.data}) : super(key: key);
  final QueryDocumentSnapshot<Map<String, dynamic>> data;

  @override
  ProductDetailScreenState createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: HexColor("#5956E9"),
        backgroundColor: HexColor("#5956E9"),
        title: Text(
          widget.data["gameType"],
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        actions: const [
          Icon(
            Icons.favorite_border,
            color: Colors.black,
            size: 28,
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.data["tautanGambar"]),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.data["namaProduk"].toString().toUpperCase(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: HexColor("#5956E9")),
                ),
                Text(
                  "Rp." + widget.data["harga"].toString(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: HexColor("#5956E9")),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              'SERVER ' + widget.data["server"],
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: HexColor("#5956E9")),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Text(
                widget.data["deskripsi"],
                style: TextStyle(
                  fontSize: 16,
                  color: HexColor("#5956E9"),
                ),
              ),
            ),
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              decoration: BoxDecoration(
                color: HexColor("#5956E9"),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Beli",
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
                  builder: (BuildContext context) => ProductPaymentScreen(
                    data: widget.data,
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget storageWidget(isSelected, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        alignment: Alignment.center,
        width: 75,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Color(0xfffD1C0F4),
          border: Border.all(color: Colors.white, width: isSelected ? 2 : 0),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
