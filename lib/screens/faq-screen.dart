import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final questions = [
    {
      'question': 'Apa itu Gema',
      'answer':
          'Flutter is a mobile app development framework created by Google. It allows developers to build natively compiled applications for mobile, web, and desktop from a single codebase.'
    },
    {
      'question': 'Pedoman keamanan perdagangan',
      'answer':
          '1. JANGAN membeli produk sebagai bentuk pembayaran atau sebagai pertukaran untuk barang lain.  2. JANGAN  pernah setuju untuk bertransaksi di luar G2G  3. JANGAN melakukan transaksi lain dalam game. Pembelian hanya untuk item yang sesuai dengan deskripsi pesanan Anda saja'
    },
    {
      'question': 'Is Flutter only for mobile app development?',
      'answer':
          'No, Flutter can be used to develop applications for mobile, web, and desktop. It supports building for Android, iOS, web, and desktop platforms.'
    },
    {
      'question': 'Is Flutter only for Android and iOS?',
      'answer':
          'No, Flutter can be used to build applications for Android, iOS, web, and desktop. It has good support for all these platforms.'
    },
    {
      'question': 'Is Flutter only for small apps?',
      'answer':
          'No, Flutter can be used to build small as well as large and complex apps. It has the capabilities and performance to handle any size of app.'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final question = questions[index]['question'];
            final answer = questions[index]['answer'];
            return ExpansionTile(
              title: Text(question!),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(answer!),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
