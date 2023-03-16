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
          'Gema adalah Aplikasi jual-beli akun game yang dikembangkan oleh seorang mahasiswa ,agar transaksi antara penjual dan beli aman dan nyaman'
    },
    {
      'question': 'Pedoman keamanan perdagangan',
      'answer':
          '1. JANGAN membeli produk sebagai bentuk pembayaran atau sebagai pertukaran untuk barang lain.  2. JANGAN  pernah setuju untuk bertransaksi di luar G2G  3. JANGAN melakukan transaksi lain dalam game. Pembelian hanya untuk item yang sesuai dengan deskripsi pesanan Anda saja'
    },
    {
      'question': 'Apa saja metode pembayaran yang dapat saya gunakan?',
      'answer':
          'Gema menawarkan  2 metode pembayaran dengan kesediaan yang ada antara lain ATM BCA dan pembayaran digital yaitu OVO.'
    },
    {
      'question': 'DO‘S?',
      'answer':
          'Jika Anda menemukan penjual melakukan perilaku yang tidak seharusnya, SILAHKAN mengambil tangkapan layar atau bukti apapun yang bisa Anda dapatkan dan kirimkan melalui email ke krulnr31@gmail.com, disertai dengan nomor pesanan Anda dan ringkasan keluhan'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ"),
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
