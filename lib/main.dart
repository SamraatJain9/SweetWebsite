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
            buildNavigationCard(context, 'Sweets/Bakery', MyHomePage(title: 'Sweets/Bakery'), isFullWidth: true),
            Row(
              children: [
                Expanded(child: buildNavigationCard(context, 'Upcoming Festivals & Gifts', Page3())),
                Expanded(child: buildNavigationCard(context, 'Offers', Page2())),
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
