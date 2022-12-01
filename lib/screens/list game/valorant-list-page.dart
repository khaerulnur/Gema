import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/screens/global-widgets/list-akun-global.dart';
import 'package:flutter_ecommerce/services/akun-service.dart';
import 'package:hexcolor/hexcolor.dart';

class PerdanaTselInputScreen extends StatefulWidget {
  const PerdanaTselInputScreen({Key? key}) : super(key: key);

  @override
  State<PerdanaTselInputScreen> createState() => _PerdanaTselInputScreenState();
}

class _PerdanaTselInputScreenState extends State<PerdanaTselInputScreen> {
  @override
  Widget build(BuildContext context) {
    return ListAkunGlobal(stream: readAccountValorant());
  }
}
