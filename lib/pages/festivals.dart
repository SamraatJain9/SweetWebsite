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
          contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    _launchURL('https://www.ubereats.com');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Uber Eats clicked')),
                    );
                    Navigator.of(context).pop();
                  },
                  child: Text("Uber Eats"),
                ),
                TextButton(
                  onPressed: () {
                    _launchURL('https://www.deliveroo.com');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Deliveroo clicked')),
                    );
                    Navigator.of(context).pop();
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

  void _showContactUsDialog(BuildContext context) {
    String phoneNumber = '+91 1234567890'; // Replace with actual random generator
    String emailAddress = 'contact@gmail.com'; // Replace with actual random generator

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Contact Us"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Phone: $phoneNumber'),
              SizedBox(height: 10),
              Text('Email: $emailAddress'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
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
      final String response =
      await rootBundle.loadString('assets/festivals.json');
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
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
          children: [
            Text(
              'Eat Pure, Gift Pure',
              style: TextStyle(
                fontSize: 20,
                // Adjust the font size as needed
              ),
            ),
            const SizedBox(height: 16),
            // Today's Festivals
            Card(
              margin: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Today\'s Festivals',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (_getTodayFestivals().isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('No festivals today'),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _getTodayFestivals().length,
                      itemBuilder: (context, index) {
                        var festival = _getTodayFestivals()[index];
                        return ListTile(
                          title: Text(festival['name']),
                          subtitle: Text(festival['date']),
                        );
                      },
                    ),
                ],
              ),
            ),

            // Upcoming Festivals
            Card(
              margin: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Upcoming Festivals',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (_upcomingFestivals.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('No upcoming festivals'),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _upcomingFestivals.length,
                      itemBuilder: (context, index) {
                        var festival = _upcomingFestivals[index];
                        return ListTile(
                          title: Text(festival['name']),
                          subtitle: Text(festival['date']),
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
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
            label: 'Google Maps: 123 Blecker Street',
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
              _launchURL(
                  'https://www.google.com/maps/search/?api=1&query=Shop+Location');
              break;
          }
        },
      ),
    );
  }

  List<Map<String, dynamic>> _getTodayFestivals() {
    DateTime now = DateTime.now();
    // Remove time component from now
    DateTime today = DateTime(now.year, now.month, now.day);

    List<Map<String, dynamic>> todayFestivals = _upcomingFestivals
        .where((festival) {
      DateTime festivalDate = DateTime.parse(festival['date']);
      // Remove time component from festival date
      DateTime festivalDay = DateTime(festivalDate.year, festivalDate.month, festivalDate.day);
      return festivalDay.isAtSameMomentAs(today);
    })
        .toList();

    // Also check past festivals if there are any festivals today
    todayFestivals.addAll(_pastFestivals
        .where((festival) {
      DateTime festivalDate = DateTime.parse(festival['date']);
      DateTime festivalDay = DateTime(festivalDate.year, festivalDate.month, festivalDate.day);
      return festivalDay.isAtSameMomentAs(today);
    })
    );

    return todayFestivals;
  }

}
