import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'pages/sweets.dart';
import 'pages/offers.dart';
import 'pages/festivals.dart';
import 'pages/food.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Initial Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 32, // Adjust the font size as needed
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false, // Remove the debug banner
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/logopen.jpeg', // Replace with your background image path
              fit: BoxFit.scaleDown,
            ),
          ),
          // Centered text
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swarnikaa'.toUpperCase(),
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto Regular',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFF5F5DC),
      ),
      backgroundColor: Color(0xFFF5F5DC),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Eat Pure, Gift Pure'.toUpperCase(), // Convert text to uppercase
              style: TextStyle(
                fontSize: 18, // Adjust the font size as needed
              ),
            ),
            const SizedBox(height: 16), // Add some spacing below the welcome text
            Row(
              children: [
                Expanded(child: buildNavigationCard(context, 'Deliveroo', 'https://deliveroo.co.uk', 'Order here', isUrl: true)),
                Expanded(child: buildNavigationCard(context, 'Uber Eats', 'https://ubereats.com', 'Order here', isUrl: true)),
              ],
            ),
            buildNavigationCard(context, 'Sweets/Bakery', MyHomePage(title: 'Eat Pure, Gift Pure'), 'Click here', isFullWidth: true),
            buildNavigationCard(context, 'Restaurant', Page4(), 'Click here', isFullWidth: true),
            Row(
              children: [
                Expanded(child: buildNavigationCard(context, 'Festivals - Gifts', Page3(), 'Click here')),
                Expanded(child: buildNavigationCard(context, 'Offers', Page2(), 'Click here')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavigationCard(BuildContext context, String label, dynamic destination, String subLabel, {bool isUrl = false, bool isFullWidth = false}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          if (isUrl && destination is String) {
            if (await canLaunch(destination)) {
              await launch(destination);
            } else {
              throw 'Could not launch $destination';
            }
          } else if (destination is Widget) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destination),
            );
          }
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
            side: BorderSide(
              color: Color(0xFFFFD700), // Silver color
              width: 2.0, // Adjust the width of the border
            ),
          ),
          child: Container(
            width: isFullWidth ? double.infinity : null,
            height: 100, // Adjust the height as needed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label.toUpperCase(), // Convert label text to uppercase
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 8), // Add some spacing between the texts
                Text(
                  subLabel.toUpperCase(), // Convert subLabel text to uppercase
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
