import 'package:flutter/material.dart';
import 'package:flutter_dapp/ui/Home.dart';

void main() {
  runApp(InitRoute());
}

class InitRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz DApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

