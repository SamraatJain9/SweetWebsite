import 'package:flutter/material.dart';
import 'pages/page1.dart';
import 'pages/page2.dart';
import 'pages/page3.dart';
import 'pages/page4.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          buildNavigationCard(context, '1', Page1()),
          buildNavigationCard(context, '2', Page2()),
          buildNavigationCard(context, '3', Page3()),
          buildNavigationCard(context, '4', Page4()),
        ],
      ),
    );
  }

  Widget buildNavigationCard(BuildContext context, String label, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
