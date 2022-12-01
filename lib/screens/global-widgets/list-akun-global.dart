import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ListAkunGlobal extends StatefulWidget {
  const ListAkunGlobal({Key? key, required this.stream}) : super(key: key);
  final Stream<QuerySnapshot<Object?>> stream;
  @override
  State<ListAkunGlobal> createState() => _ListAkunGlobalState();
}

class _ListAkunGlobalState extends State<ListAkunGlobal> {
  var searchCtrl = new TextEditingController();

  bool statusLanjut = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("data"),
          backgroundColor: HexColor("#5956E9"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        isDense: true,
                        filled: true,
                        fillColor: HexColor("EBF2F2"),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Cari barang yang diinginkan',
                      ),
                      controller: searchCtrl,
                    ),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/filter.png"),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Divider(thickness: 1.5),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 20, bottom: 25),
              child: Text(
                "Daftar Produk",
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: widget.stream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    print("tidak ada data");
                    return Text("data");
                  } else {
                    print(snapshot.data);
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            padding:
                                const EdgeInsets.only(bottom: 10, left: 16),
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
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                top: 0, bottom: 5),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      snapshot
                                                          .data!
                                                          .docs[index]
                                                              ["informasiGame"]
                                                          .toString(),
                                                    ),
                                                    Text(
                                                      snapshot.data!
                                                          .docs[index]["status"]
                                                          .toString(),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      snapshot.data!
                                                          .docs[index]["harga"]
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                SizedBox(width: 22),
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
                          );
                        },
                      ),
                    );
                  }
                })
          ],
        ),
        floatingActionButton: buttonNavigasi(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget buttonNavigasi() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 90,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            Divider(
              thickness: 5,
              color: HexColor("F5F5F5"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Setoran Saldo Awal",
                      ),
                      Text(
                        "Rp10000,-",
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: statusLanjut
                              ? HexColor("E55300")
                              : Colors.lightBlue),
                      child: Center(
                        child: Text(
                          'Lanjutkan',
                          style: statusLanjut
                              ? TextStyle(color: Colors.white)
                              : TextStyle(color: Colors.orange),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
