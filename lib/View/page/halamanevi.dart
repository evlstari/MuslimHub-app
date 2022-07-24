import 'package:flutter/material.dart';

class HalamanEvi extends StatefulWidget {
  const HalamanEvi({ Key? key }) : super(key: key);

  @override
  State<HalamanEvi> createState() => _HalamanEviState();
}

class _HalamanEviState extends State<HalamanEvi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Halaman Evi"),),
      body: Center(
        child: Text("Bisa di ganti/modif/ semaune evi wes mau diapain wkwk "),
      ),
    );
  }
}