import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'pages/sweets.dart';
import 'pages/offers.dart';
import 'pages/festivals.dart';
import 'pages/food.dart';
import 'package:google_fonts/google_fonts.dart';

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
              'assets/logo.jpg', // Replace with your background image path
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

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  void _showOrderMethodDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Choose Delivery Service",
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          ),
          contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0), // Adjust padding as needed
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    _launchURL('https://www.swiggy.com/');
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text(
                    "Swiggy",
                    style: GoogleFonts.montserrat(),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _launchURL('https://www.zomato.com/');
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text(
                    "Zomato",
                    style: GoogleFonts.montserrat(),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showContactUsDialog(BuildContext context) {
    String phoneNumber = '+91 8707464728'; // Replace with actual random generator
    String emailAddress = 'cashcons@gmail.com'; // Replace with actual random generator

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Contact Us",
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Phone: $phoneNumber',
                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Email: $emailAddress',
                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Swarnikaa'.toUpperCase(),
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold, // Montserrat Regular (400)
            ),
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
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700, // Montserrat Regular (400)
                ),
              ),
            ),
            const SizedBox(height: 16), // Add some spacing below the welcome text
            Row(
              children: [
                Expanded(child: buildNavigationCard(context, 'Swiggy', 'https://www.swiggy.com/', 'Order here', isUrl: true)),
                Expanded(child: buildNavigationCard(context, 'Zomato', 'https://www.zomato.com/', 'Order here', isUrl: true)),
              ],
            ),
            buildNavigationCard(context, 'Mithai Mandapam', MyHomePage(title: 'Eat Pure, Gift Pure'), 'Click here', isFullWidth: true),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: 'Contact Us',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Order Now',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Google Maps: A-17A, Ganesh Nagar, Mansarovar',
          ),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              _showContactUsDialog(context);
              break;
            case 1:
              _showOrderMethodDialog(context);
              break;
            case 2:
              _launchURL("https://www.google.com/maps/place/26%C2%B050'08.0%22N+75%C2%B045'19.9%22E/@26.8354442,75.7554997,20z/data=!4m4!3m3!8m2!3d26.835552!4d75.755533?entry=ttu");
              break;
          }
        },
        selectedFontSize: 14.0, // Adjust as needed
        unselectedFontSize: 14.0, // Adjust as needed
        selectedItemColor: Colors.redAccent, // Example color
        unselectedItemColor: Colors.black, // Example color
        type: BottomNavigationBarType.fixed, // Adjust based on your design
        selectedLabelStyle: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        unselectedLabelStyle: GoogleFonts.montserrat(),
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
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: Color(0xFFFFD700),
              width: 2.0,
            ),
          ),
          child: Container(
            width: isFullWidth ? double.infinity : null,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label.toUpperCase(),
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500, // Montserrat Bold
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subLabel.toUpperCase(),
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
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
