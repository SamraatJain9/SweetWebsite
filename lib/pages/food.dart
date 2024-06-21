import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

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
          title: Text("Choose Delivery Service",
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          ),
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
                  child: Text("Uber Eats",
                    style: GoogleFonts.montserrat(),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _launchURL('https://www.deliveroo.com');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Deliveroo clicked')),
                    );
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text("Deliveroo",
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
    String phoneNumber = '+91 1234567890'; // Replace with actual random generator
    String emailAddress = 'contact@gmail.com'; // Replace with actual random generator

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Contact Us", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Phone: $phoneNumber', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),),
              SizedBox(height: 10),
              Text('Email: $emailAddress', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),),
            ),
          ],
        );
      },
    );
  }

  void _showMenuDialog(BuildContext context) {
    // Example vegetarian fast food items
    List<String> vegetarianItems = [
      'Veggie Burger',
      'Vegetarian Pizza',
      'Vegetable Stir-fry',
      'Caprese Salad',
      'Falafel Wrap',
      'Grilled Veggie Panini',
      'Vegetarian Sushi Rolls',
      'Quinoa Salad',
      'Vegetarian Tacos',
      'Spinach and Cheese Quesadilla',
      'Vegetarian Spring Rolls',
      'Eggplant Parmesan',
      'Vegetarian Chili',
      'Vegetarian Lasagna',
      'Stuffed Bell Peppers'
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text("Pure Vegetarian Menu", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),)),
          content: Container(
            color: Colors.redAccent,
            width: MediaQuery.of(context).size.width * 0.3, // 80% of screen width
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (String item in vegetarianItems)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: Text(
                          item,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),),
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Fast Food', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0), // Adjust height as needed
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Eat Pure, Gift Pure',
              style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/lk.gif',
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Fast Food & Live Kitchen',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _showMenuDialog(context);
                  },
                  child: Text('View Menu', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),),
                ),
              ],
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
}
