import 'package:flutter/material.dart';
import 'homepage.dart';
import 'pages/page2.dart';
import 'pages/page3.dart';
import 'pages/page4.dart';

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
            buildNavigationCard(context, 'Sweets/Bakery', MyHomePage(title: 'Sweets/Bakery'), 'Click here', isFullWidth: true),
            buildNavigationCard(context, 'Fast Foods | Live Kitchen Restaurant', Page4(), 'Click here', isFullWidth: true),
            Row(
              children: [
                Expanded(child: buildNavigationCard(context, 'Upcoming Festivals & Gifting', Page3(), 'Click here')),
                Expanded(child: buildNavigationCard(context, 'Offers', Page2(), 'Click here')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavigationCard(BuildContext context, String label, Widget page, String subLabel, {bool isFullWidth = false}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
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
