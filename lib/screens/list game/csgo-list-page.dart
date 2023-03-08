import 'package:flutter/material.dart';

import '../../services/service.dart';
import '../global-widgets/list-akun-global.dart';

class CsgoListPage extends StatefulWidget {
  const CsgoListPage({Key? key}) : super(key: key);

  @override
  State<CsgoListPage> createState() => _CsgoListPageState();
}

class _CsgoListPageState extends State<CsgoListPage> {
  @override
  Widget build(BuildContext context) {

    return ListAkunGlobal(stream: readAccount("CSGO"), appbarTitle: 'Akun CSGO ',);
  }
}
