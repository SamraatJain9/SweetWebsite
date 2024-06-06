import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
      MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Home Page')),
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _onMenuSelected(String choice) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Selected: $choice')),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title, textAlign: TextAlign.center),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Offers'),
              Tab(text: 'Sweets'),
              Tab(text: 'Saltines'),
            ],
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              controller: _tabController,
              children: [
                Center(child: Text('Tab 1 Content')),
                Center(child: Text('Tab 2 Content')),
                Center(child: Text('Tab 3 Content')),
              ],
            ),
            Positioned(
              top: 10,
              left: 10,
              child: PopupMenuButton<String>(
                onSelected: _onMenuSelected,
                itemBuilder: (BuildContext context) {
                  return {'Upcoming Festivals', 'New Beginnings(Story)', 'Social Media'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
                child: Icon(Icons.menu),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail),
              label: 'Contact Us: contact@gmail.com',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'Order Now',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Google Maps: 123 Blecker Street',
            ),
          ],
          onTap: (int index) {
            switch (index) {
              case 0:
                _launchURL('mailto:contact@shop.com');
                break;
              case 1:
                _launchURL('https://www.google.com/maps/place/Shop+Address');
                break;
              case 2:
                _launchURL('https://www.google.com/maps/search/?api=1&query=Shop+Location');
                break;
            }
          },
        ),
      ),
    );
  }
}
