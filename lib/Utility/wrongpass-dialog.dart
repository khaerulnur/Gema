import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

 void wrongPassTransactionAlertDialog(BuildContext context , String messageError) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            )),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                      right: 25,
                      top: 10,
                    ),
                    child: Image.asset('assets/images/ic_selalu_salah.png',
                        width: 300),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 36),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        messageError,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Container(
                      height: 41,
                      width: double.infinity,
                      child: ElevatedButton(
                        key: Key("btnOkSalahPasswordTransaksi"),
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: HexColor("#5956E9"),
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0))),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Ok",
                          style: TextStyle(
                              fontFamily: "montserrat",
                              fontWeight: FontWeight.w700,
                              /*letterSpacing: 0.3,*/
                              fontSize: 16,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }