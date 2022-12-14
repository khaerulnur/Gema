import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/screens/additem/add-item-detail.dart';

class PreviewImageScreen extends StatefulWidget {
  const PreviewImageScreen({Key? key, required this.imageFile})
      : super(key: key);

  final File imageFile;

  @override
  State<PreviewImageScreen> createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(right: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Text(
                  'Retake',
                  style: TextStyle(
                      color: Color(0xff3F4D55),
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  'Import Image',
                  style: TextStyle(
                    color: Color(0xff3F4D55),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              GestureDetector(
                child: Text(
                  'Use Photo',
                  style: TextStyle(
                      color: Color(0xff3F4D55),
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddItemDetail(imageFile: widget.imageFile),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: AspectRatio(
        aspectRatio: 0.85,
        child: Image(
          fit: BoxFit.cover,
          image: FileImage(widget.imageFile),
        ),
      ),
    );
  }
}
