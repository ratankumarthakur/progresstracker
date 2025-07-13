import 'package:flutter/material.dart';

class exercise extends StatefulWidget {
  const exercise({super.key});

  @override
  State<exercise> createState() => _exerciseState();
}

class _exerciseState extends State<exercise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercise"),
      ),
    );
  }
}
