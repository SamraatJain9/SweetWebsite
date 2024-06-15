import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import '../main.dart'; // Import main.dart to access HomeScreen

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  int _selectedSweet = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _autoScroll();
  }

  void _autoScroll() {
    Timer.periodic(Duration(seconds: 2), (timer) {
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


  Widget buildCard(String imageUrl, String title) {
    final screenHeight = MediaQuery.of(context).size.height;
    final cardHeight = screenHeight * 0.6; // Adjust the ratio as needed

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
          title: Text(widget.title, textAlign: TextAlign.center),
          centerTitle: true,
          leading: PopupMenuButton<String>(
            onSelected: _onMenuSelected,
            itemBuilder: (BuildContext context) {
              return {'Upcoming Festivals', 'New Beginnings(Story)', 'Social Media'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            icon: const Icon(Icons.menu),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Sweets'),
              Tab(text: 'Saltines'),
              Tab(text: 'Bakery'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Row(
              children: [
                // Side panel
                Container(
                  width: 150, // Adjust the width as needed
                  color: Colors.deepPurple[200], // Example background color
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Evenly space the buttons vertically
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust horizontal padding as needed
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedSweet = 1;
                            });
                          },
                          child: Text("Category - 1"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust horizontal padding as needed
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedSweet = 2;
                            });
                          },
                          child: Text("Category - 2"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust horizontal padding as needed
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedSweet = 3;
                            });
                          },
                          child: Text("Category - 3"),
                        ),
                      ),
                    ],
                  ),
                ),
                // List of sweets cards
                Expanded(
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      if (_selectedSweet == 1)
                        buildCard('https://images.unsplash.com/photo-1551106652-a5bcf4b29ab6?q=80&w=1965&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'Sweet 1'),
                      if (_selectedSweet == 2)
                        buildCard('https://images.unsplash.com/photo-1558234469-50fc184d1cc9?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'Sweet 2'),
                      if (_selectedSweet == 3)
                        buildCard('https://images.unsplash.com/photo-1591123220262-87ed377f7c08?q=80&w=2073&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'Sweet 3'),
                    ],
                  ),
                ),
              ],
            ),

            // Center widget for other tabs
            Center(
              child: Text(
                'Coming Soon...',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                'Coming Soon...',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyHomePage(title: 'Shop Offers'),
  ));
}
