import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 140,
      child: Row(
        children: [
          Container(
            decoration:
                BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}
