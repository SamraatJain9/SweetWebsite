import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'homepage.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
    await Future.delayed(const Duration(seconds: 1), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome...',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
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
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Eat Pure, Gift Pure',
              style: TextStyle(
                fontSize: 20, // Adjust the font size as needed
              ),
            ),
            const SizedBox(height: 16), // Add some spacing below the welcome text
            Row(
              children: [
                Expanded(child: buildNavigationCard(context, 'Deliveroo', 'https://deliveroo.co.uk', 'Order here', isUrl: true)),
                Expanded(child: buildNavigationCard(context, 'Uber Eats', 'https://ubereats.com', 'Order here', isUrl: true)),
              ],
            ),
            buildNavigationCard(context, 'Sweets/Bakery', MyHomePage(title: 'Sweets/Bakery'), 'Click here', isFullWidth: true),
            buildNavigationCard(context, 'Restaurant', Page4(), 'Click here', isFullWidth: true),
            Row(
              children: [
                Expanded(child: buildNavigationCard(context, 'Festivals & Gifting', Page3(), 'Click here')),
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
          child: Container(
            width: isFullWidth ? double.infinity : null,
            height: 100, // Adjust the height as needed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 8), // Add some spacing between the texts
                Text(
                  subLabel,
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
