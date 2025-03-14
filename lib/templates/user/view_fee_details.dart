import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class view_fee_deatils extends StatefulWidget {
  const view_fee_deatils({Key? key}) : super(key: key);

  @override
  _view_fee_deatilsPageState createState() => _view_fee_deatilsPageState();
}

class _view_fee_deatilsPageState extends State<view_fee_deatils> {
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
      Uri.parse(url + '/user_view_fee_deatils'),
      headers: {
        'Content-Type': 'application/json', // Ensure you're sending JSON
      },
      body: json.encode({'lid': lid}), // Send 'lid' in the body
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        _scheduleItems = List<ScheduleItem>.from(
          data['data'].map((item) => ScheduleItem.fromJson(item)),
        );
      });
    } else {
      throw Exception('Failed to load time schedule');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Fee Details'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: _scheduleItems.length,
        itemBuilder: (context, index) {
          final schedule = _scheduleItems[index];
          return Column(
            children: [
              ScheduleCard(
                date: schedule.date,
                fees: schedule.fees,
                status: schedule.status,
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
  final int fees;
  final String status;
  final String? date;

  const ScheduleCard({
    required this.fees,
    required this.status,
    required this.date,
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
            'fee: $fees',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'status: $status',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Date: $date',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Add your button action here
            },
            child: Text('Pay Now'),
          ),
        ],
      ),
    );
  }
}

// Model for ScheduleItem
class ScheduleItem {
  final int fees;
  final String status;
  final String date;

  ScheduleItem({required this.fees, required this.status, required this.date});

  factory ScheduleItem.fromJson(Map<String, dynamic> json) {
    return ScheduleItem(
      fees: json['fees'],
      status: json['status'],
      date: json['date'],
    );
  }
}
