import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Trackworkout extends StatefulWidget {
  const Trackworkout({Key? key}) : super(key: key);

  @override
  _trackworukoutPageState createState() => _trackworukoutPageState();
}

class _trackworukoutPageState extends State<Trackworkout> {
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
      Uri.parse(url + '/user_view_workout'),
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
      throw Exception('Failed to load workout');
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
                name: schedule.name,
                reps: schedule.reps,
                sets: schedule.sets,
                weight: schedule.weight,
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
  final String name;
  final int reps;
  final int sets;
  final double weight;

  const ScheduleCard({
    required this.name,
    required this.reps,
    required this.sets,
    required this.weight,
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
            'Workout: $name',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Reps: $reps',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Sets: $sets',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Weight: $weight',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// Model for ScheduleItem
class ScheduleItem {
  final String name;
  final int reps;
  final int sets;
  final double weight;

  ScheduleItem({
    required this.name,
    required this.reps,
    required this.sets,
    required this.weight,
  });

  factory ScheduleItem.fromJson(Map<String, dynamic> json) {
    return ScheduleItem(
      name: json['name'],
      reps: json['reps'],
      sets: json['set'],
      weight: json['weight'],
    );
  }
}
