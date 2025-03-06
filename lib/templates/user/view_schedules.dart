import 'package:flutter/material.dart';

class time_schedule extends StatelessWidget {
  const time_schedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TIME_SCHEDULE'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          ScheduleCard(
            date: '2023-10-01',
            time: '6:00 AM',
            trainer: 'John Doe',
            workout: 'Morning Yoga',
          ),
          SizedBox(height: 20),
          ScheduleCard(
            date: '2023-10-01',
            time: '8:00 AM',
            trainer: 'Jane Smith',
            workout: 'Breakfast',
          ),
          SizedBox(height: 20),
          ScheduleCard(
            date: '2023-10-01',
            time: '10:00 AM',
            trainer: 'John Doe',
            workout: 'Cardio Workout',
          ),
          SizedBox(height: 20),
          ScheduleCard(
            date: '2023-10-01',
            time: '12:00 PM',
            trainer: 'Jane Smith',
            workout: 'Lunch',
          ),
          SizedBox(height: 20),
          ScheduleCard(
            date: '2023-10-01',
            time: '3:00 PM',
            trainer: 'John Doe',
            workout: 'Strength Training',
          ),
          SizedBox(height: 20),
          ScheduleCard(
            date: '2023-10-01',
            time: '6:00 PM',
            trainer: 'Jane Smith',
            workout: 'Dinner',
          ),
          SizedBox(height: 20),
          ScheduleCard(
            date: '2023-10-01',
            time: '8:00 PM',
            trainer: 'John Doe',
            workout: 'Evening Walk',
          ),
        ],
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final String date;
  final String time;
  final String trainer;
  final String workout;

  const ScheduleCard({
    required this.date,
    required this.time,
    required this.trainer,
    required this.workout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(
            'Date: $date',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Time: $time',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Trainer: $trainer',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Workout: $workout',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
