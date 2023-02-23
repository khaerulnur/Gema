import 'package:flutter/material.dart';

import '../../services/game-account-service.dart';
import '../global-widgets/list-akun-global.dart';

class MobileLegendListPage extends StatefulWidget {
  const MobileLegendListPage({Key? key}) : super(key: key);

  @override
  State<MobileLegendListPage> createState() => _MobileLegendListPageState();
}

class _MobileLegendListPageState extends State<MobileLegendListPage> {
  @override
  Widget build(BuildContext context) {
    return ListAkunGlobal(
      stream: readAccountMobileLegend(),
      appbarTitle: 'Akun Mobile Legend ',
    );
  }
}
