import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page3State();
}

class _Page3State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('page 2'),),);
  }
}