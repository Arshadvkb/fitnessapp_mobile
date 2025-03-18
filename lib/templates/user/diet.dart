import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Trackdiet extends StatefulWidget {
  const Trackdiet({Key? key}) : super(key: key);

  @override
  _trackdietPageState createState() => _trackdietPageState();
}

class _trackdietPageState extends State<Trackdiet> {
  List<ScheduleItem> _scheduleItems = [];

  @override
  void initState() {
    super.initState();
    fetchTimeScheduleData();
  }

  Future<void> fetchTimeScheduleData() async {
    final sh = await SharedPreferences.getInstance();
    String? url = sh.getString("url");
    String? lid = sh.getString("lid");

    if (url == null || lid == null) {
      throw Exception('URL or LID is null');
    }

    final response = await http.post(
      Uri.parse(url + '/user_view_tracked_diet'),
      headers: {
        'Content-Type': 'application/json', // Ensure you're sending JSON
      },
      body: json.encode({'lid': lid}), // Send 'lid' in the body
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      setState(() {
        _scheduleItems = List<ScheduleItem>.from(
          data['data'].map((item) => ScheduleItem.fromJson(item)),
        );
      });
    } else {
      throw Exception('Failed to load diet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: _scheduleItems.length,
        itemBuilder: (context, index) {
          final schedule = _scheduleItems[index];
          return Column(
            children: [
              ScheduleCard(
                food: schedule.food,
                quantity: schedule.quantity,
                time: schedule.time,
              ),
              SizedBox(height: 16), // Add gap between containers
            ],
          );
        },
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final String food;
  final String quantity;
  final String? time;

  const ScheduleCard({
    required this.food,
    required this.quantity,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Make container full width
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Text(
            'Food: $food',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Quantity: $quantity',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Time: $time',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}

// Model for ScheduleItem
class ScheduleItem {
  final String food;
  final String quantity;
  final String? time;

  ScheduleItem({
    required this.food,
    required this.quantity,
    required this.time,
  });

  factory ScheduleItem.fromJson(Map<String, dynamic> json) {
    return ScheduleItem(
      food: json['food'],
      quantity: json['quantity'],
      time: json['time'],
    );
  }
}
