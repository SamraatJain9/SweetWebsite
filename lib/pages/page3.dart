// file: lib/page3.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;

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
          Divider(),
          Text('Past Festivals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: _pastFestivals.length,
              itemBuilder: (context, index) {
                var festival = _pastFestivals[index];
                return ListTile(
                  title: Text(festival['name']),
                  subtitle: Text(festival['date']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
