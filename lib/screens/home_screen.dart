import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App - Home'),
        backgroundColor: Colors.red,
      ),

      body: Container(
        color: Colors.black,
        child: Center(
          child: Text(
            'Welcome to the Home Screen!',
            style: TextStyle(color: Colors.red,
            fontSize: 20),
          ),
        ),
      ),
    );
  }
}

