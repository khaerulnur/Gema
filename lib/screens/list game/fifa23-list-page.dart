import 'package:flutter/material.dart';
import '../../services/service.dart';
import '../global-widgets/list-akun-global.dart';

class FifaListPage extends StatefulWidget {
  const FifaListPage({Key? key}) : super(key: key);

  @override
  State<FifaListPage> createState() => _FifaListPageState();
}

class _FifaListPageState extends State<FifaListPage> {
  @override
  Widget build(BuildContext context) {
    return ListAkunGlobal(
      stream: readAccountFifa23(),
      appbarTitle: 'Akun Fifa23 ',
    );
  }
}
