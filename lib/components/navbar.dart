import 'package:flutter/material.dart';

class NewcomerNavbar extends StatelessWidget {
  const NewcomerNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        'assets/images/templogo2.png',
        width: 350,
        height: 150,
      ),
    );
  }
}