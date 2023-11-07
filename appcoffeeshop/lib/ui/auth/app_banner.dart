//import 'dart:math';

import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.only(bottom: 100.0),
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 50,
      ),
      child: const Text(
        'TAT Coffee',
        style: TextStyle(
          color: Colors.white,
          //color: Colors.white,
          fontSize: 35,
          fontFamily: 'Anton',
          wordSpacing: 3,
          letterSpacing: 13,
          fontWeight: FontWeight.normal,
          //decorationColor: Colors.white,
        ),
      ),
    );
  }
}
