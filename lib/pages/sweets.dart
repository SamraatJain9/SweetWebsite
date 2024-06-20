import 'package:flutter/material.dart';
import 'package:sweets/pages/bakery.dart';
import 'package:sweets/pages/saltines.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import '../main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _autoScroll();
  }

  void _autoScroll() {
    Timer.periodic(Duration(seconds: 12), (timer) {
      if (_scrollController.hasClients) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        final currentScrollPosition = _scrollController.position.pixels;
        final screenHeight = MediaQuery.of(context).size.height;

        if (currentScrollPosition < maxScrollExtent) {
          _scrollController.animateTo(
            currentScrollPosition + screenHeight,
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            0.0,
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
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

  Widget buildCard(String imageUrl, String title) {
    final screenHeight = MediaQuery.of(context).size.height;
    final cardHeight = screenHeight * 0.7; // Adjust the ratio as needed

    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: cardHeight,
        child: SingleChildScrollView( // Wrap the Card with SingleChildScrollView
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    height: cardHeight - 60, // Adjust the height of the image
                    width: double.infinity,
                  ),
                ),
                ListTile(
                  title: Center(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title, textAlign: TextAlign.center, style: TextStyle(fontSize: 24),),
          centerTitle: true,

          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Sweet|Type1'),
              Tab(text: 'Sweet|Type2'),
              Tab(text: 'Sweet|Type3'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Row(
              children: [
                Container(
                  width: 135,
                  color: Colors.redAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const MySaltyPage(title: 'Eat Pure, Gift Pure')),
                            );
                            setState(() {
                              _scrollController.animateTo(
                                0.0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            });
                          },
                          child: Text("Saltines"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const MyBakeryPage(title: 'Eat Pure, Gift Pure')),
                            );
                            setState(() {

                              _scrollController.animateTo(
                                0.0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            });
                          },
                          child: Text("Bakery"),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: _scrollController,
                      child: ListView(
                        controller: _scrollController,
                        children: [
                          buildCard('https://images.unsplash.com/photo-1551106652-a5bcf4b29ab6?q=80&w=1965&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'Sweet 1A'),
                          buildCard('https://images.unsplash.com/photo-1551106652-a5bcf4b29ab6?q=80&w=1965&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'Sweet 1B'),
                        ],
                      ),
                    )
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 150,
                  color: Colors.redAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const MySaltyPage(title: 'Eat Pure, Gift Pure')),
                            );
                            setState(() {

                              _scrollController.animateTo(
                                0.0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            });
                          },
                          child: Text("Saltines"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const MyBakeryPage(title: 'Eat Pure, Gift Pure')),
                            );
                            setState(() {

                              _scrollController.animateTo(
                                0.0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            });
                          },
                          child: Text("Bakery"),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: _scrollController,
                      child: ListView(
                        controller: _scrollController,
                        children: [
                          buildCard('https://images.unsplash.com/photo-1551106652-a5bcf4b29ab6?q=80&w=1965&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'Sweet 2A'),
                          buildCard('https://images.unsplash.com/photo-1551106652-a5bcf4b29ab6?q=80&w=1965&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'Sweet 2B'),
                        ],
                      ),
                    )
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 150,
                  color: Colors.redAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const MySaltyPage(title: 'Eat Pure, Gift Pure')),
                            );
                            setState(() {

                              _scrollController.animateTo(
                                0.0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            });
                          },
                          child: Text("Saltines"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const MyBakeryPage(title: 'Eat Pure, Gift Pure')),
                            );
                            setState(() {

                              _scrollController.animateTo(
                                0.0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            });
                          },
                          child: Text("Bakery"),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: _scrollController,
                      child: ListView(
                        controller: _scrollController,
                        children: [
                          buildCard('https://images.unsplash.com/photo-1551106652-a5bcf4b29ab6?q=80&w=1965&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'Sweet 3A'),
                          buildCard('https://images.unsplash.com/photo-1551106652-a5bcf4b29ab6?q=80&w=1965&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'Sweet 3B'),
                        ],
                      ),
                    )
                ),
              ],
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
                _showContactUsDialog(context);
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
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyHomePage(title: 'Shop Offers'),
  ));
}
