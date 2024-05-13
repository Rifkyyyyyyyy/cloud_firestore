import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page3State();
}

class _Page3State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('page 1'),),);
  }
}