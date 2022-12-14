import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/utility/custom-loading.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: CustomLoading().showLoading()),
      ),
    );
  }
}
