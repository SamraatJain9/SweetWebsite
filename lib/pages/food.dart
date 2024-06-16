import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Page4 extends StatelessWidget {
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
          title: Text("Choose Delivery Service"),
          contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0), // Adjust padding as needed
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    // Launch Uber Eats link
                    _launchURL('https://www.ubereats.com');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Uber Eats clicked')),
                    );
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text("Uber Eats"),
                ),
                TextButton(
                  onPressed: () {
                    // Launch Deliveroo link
                    _launchURL('https://www.deliveroo.com');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Deliveroo clicked')),
                    );
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text("Deliveroo"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fast Food'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/lk.gif',
              fit: BoxFit.cover, // Make the GIF cover the entire background
            ),
          ),
          Center(
            child: Text(
              'Fast Food & Live Kitchen',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
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
            label: 'Google Maps: 123 Blecker Street',
          ),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              _launchURL('mailto:contact@gmail.com');
              break;
            case 1:
              _showOrderMethodDialog(context);
              break;
            case 2:
              _launchURL('https://www.google.com/maps/search/?api=1&query=Shop+Location');
              break;
          }
        },
      ),
    );
  }
}
