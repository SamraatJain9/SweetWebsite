import 'package:flutter/material.dart';
import 'package:sweets/main.dart';
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
            buildNavigationCard(context, 'Sweets/Bakery', MyHomePage(title: 'Sweets/Bakery'), isFullWidth: true),
            Row(
              children: [
                Expanded(child: buildNavigationCard(context, 'Offers', Page2())),
                Expanded(child: buildNavigationCard(context, 'Upcoming Festivals & Gifts', Page3())),
              ],
            ),
            buildNavigationCard(context, 'Fast Foods | Live Kitchen', Page4(), isFullWidth: true),
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
