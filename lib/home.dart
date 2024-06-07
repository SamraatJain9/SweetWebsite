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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildNavigationCard(context, '1', Page1(), isFullWidth: true),
            Row(
              children: [
                Expanded(child: buildNavigationCard(context, '2', Page2())),
                Expanded(child: buildNavigationCard(context, '3', Page3())),
              ],
            ),
            buildNavigationCard(context, '4', Page4(), isFullWidth: true),
          ],
        ),
      ),
    );
  }

  Widget buildNavigationCard(BuildContext context, String label, Widget page, {bool isFullWidth = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        child: Container(
          width: isFullWidth ? double.infinity : null,
          height: 150, // Adjust the height as needed
          child: Center(
            child: Text(
              label,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}
