import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';


class CustomLoading {
  showLoading() {
    EasyLoading.instance
      // ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.chasingDots
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 50.0
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = Colors.white.withOpacity(0)
      ..indicatorColor = HexColor("E55300")
      ..textColor = Colors.white
      ..maskColor = Colors.grey.withOpacity(0.1)
      ..userInteractions = false
      ..maskType = EasyLoadingMaskType.custom
      ..boxShadow = <BoxShadow>[]
      ..dismissOnTap = false;

    EasyLoading.show();
  }

  showFullScreenLoading() {
    EasyLoading.instance
      // ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.chasingDots
      ..loadingStyle = EasyLoadingStyle.custom
      ..maskType = EasyLoadingMaskType.custom
      ..indicatorSize = 50.0
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = Colors.white.withOpacity(0)
      ..indicatorColor = HexColor("E55300")
      ..textColor = Colors.white
      ..maskColor = Colors.grey
      ..userInteractions = false
      ..boxShadow = <BoxShadow>[]
      ..dismissOnTap = false;

    EasyLoading.show();
  }

  dismissLoading() {
    EasyLoading.dismiss();
  }
}