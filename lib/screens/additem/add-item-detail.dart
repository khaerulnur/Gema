import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/screens/home/home.dart';
import 'package:flutter_ecommerce/services/game-account-service.dart';
import 'package:flutter_ecommerce/utility/custom-loading.dart';
import 'package:hexcolor/hexcolor.dart';

class AddItemDetail extends StatefulWidget {
  const AddItemDetail({Key? key, required this.imageFile}) : super(key: key);
  final File imageFile;
  @override
  State<AddItemDetail> createState() => _AddItemDetailState();
}

class _AddItemDetailState extends State<AddItemDetail> {
  TextEditingController rankCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController deskripsiCtrl = TextEditingController();
  TextEditingController namaProdukCtrl = TextEditingController();

  List listGame = ["Valorant", "CSGO", "Mobile Legend", "Fifa23"];
  List listServer = ["SEA", "NA", "EU", "Japan"];

  String gameSelected = "Valorant";
  String serverSelected = "SEA";

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Item Detail",
            style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: HexColor("#5956E9"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Image.file(
                    widget.imageFile,
                    width: 100,
                    height: 100,
                  ),
                  Flexible(
                    child: TextFormField(
                      controller: deskripsiCtrl,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Harap masukkan Deskripsi";
                        }
                      },
                      decoration: InputDecoration(hintText: "Tulis Deskripsi"),
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
              rowDetail((value) {
                if (value == null || value.isEmpty) {
                  return "Harap masukkan nama produk ";
                } else if (value.length > 24) {
                  return "Nama produk harus kurang dari 24 karakter";
                }
              }, "Nama Produk ", namaProdukCtrl, "nama produk",
                  TextInputType.text),
              rowDetail((value) {
                if (value == null || value.isEmpty) {
                  return "Harap masukkan Rank";
                }
              }, "Rank ", rankCtrl, "rank", TextInputType.text),
              rowDetail((value) {
                if (value == null || value.isEmpty) {
                  return "Harap masukkan Harga";
                }
              }, "Harga", priceCtrl, "harga", TextInputType.number),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Game",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Montserrat"),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      width: double.infinity,
                      child: DropdownButton(
                        isExpanded: true,
                        value: gameSelected,
                        items: listGame.map((value) {
                          return DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            gameSelected = value.toString();
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Server",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Montserrat"),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      width: double.infinity,
                      child: DropdownButton(
                        isExpanded: true,
                        value: serverSelected,
                        items: listServer.map((value) {
                          return DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            serverSelected = value.toString();
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: SizedBox(
                  child: ElevatedButton.icon(
                    label: Text(
                      'Upload',
                    ),
                    icon: Icon(Icons.post_add),
                    style: ElevatedButton.styleFrom(
                      primary: HexColor("#5956E9"),
                    ),
                    onPressed: () {
                      print(widget.imageFile);
                      if (formKey.currentState!.validate()) {
                        _dialogBuilder(context);
                      }
                    },
                  ),
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
        ),
      ),
    );
  }

  Widget rowDetail(
      String? Function(String?)? validator,
      String name,
      TextEditingController controller,
      String hintText,
      TextInputType keyboardType) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            name,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                fontFamily: "Montserrat"),
          ),
        ),
        Expanded(
          flex: 7,
          child: TextFormField(
            keyboardType: keyboardType,
            validator: validator,
            controller: controller,
            decoration: InputDecoration(hintText: hintText),
          ),
        )
      ],
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Apakah Anda Yakin Data yang Diisi Sudah Benar?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Belum'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Lanjut'),
              onPressed: () async {
                String imageURL;
                CustomLoading().showLoading();
                imageURL = await uploadPic(widget.imageFile);
                addAccountService(
                    deskripsiCtrl.text,
                    int.parse(priceCtrl.text),
                    imageURL,
                    gameSelected,
                    serverSelected,
                    namaProdukCtrl.text);
                CustomLoading().dismissLoading();
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const HomeScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
