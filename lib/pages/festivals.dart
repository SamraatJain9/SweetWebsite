import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(Page3App());

class Page3App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Page3(),
    );
  }
}

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  List<Map<String, dynamic>> _pastFestivals = [];
  List<Map<String, dynamic>> _upcomingFestivals = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadFestivalData();
    _startAutoUpdate();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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

  void _startAutoUpdate() {
    _timer = Timer.periodic(Duration(minutes: 5), (timer) {
      _loadFestivalData();
    });
  }

  Future<void> _loadFestivalData() async {
    try {
      final String response = await rootBundle.loadString('assets/festivals.json');
      final List<dynamic> data = json.decode(response);

      DateTime now = DateTime.now();
      List<Map<String, dynamic>> pastFestivals = [];
      List<Map<String, dynamic>> upcomingFestivals = [];

      for (var item in data) {
        DateTime festivalDate = DateTime.parse(item['date']);
        if (festivalDate.isBefore(now)) {
          pastFestivals.add(item);
        } else {
          upcomingFestivals.add(item);
        }
      }

      setState(() {
        _pastFestivals = pastFestivals;
        _upcomingFestivals = upcomingFestivals;
      });
    } catch (e) {
      print('Error loading festival data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Festival Timeline'),
      ),
      body: Column(
        children: [
          Text('Upcoming Festivals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: _upcomingFestivals.length,
              itemBuilder: (context, index) {
                var festival = _upcomingFestivals[index];
                return ListTile(
                  title: Text(festival['name']),
                  subtitle: Text(festival['date']),
                );
              },
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
