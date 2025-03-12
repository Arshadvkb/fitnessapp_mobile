import 'package:fitnessappnew/templates/user/add_diet.dart';
import 'package:fitnessappnew/templates/user/add_workout.dart';
import 'package:flutter/material.dart';
import 'package:fitnessappnew/templates/user/diet.dart';
import 'package:fitnessappnew/templates/user/workout.dart';

class TrackProgress extends StatefulWidget {
  const TrackProgress({super.key});

  @override
  State<TrackProgress> createState() => _TrackProgressState();
}

class _TrackProgressState extends State<TrackProgress>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void changeTab() {
    setState(() {
      _selectedIndex = 1; // Change to desired index
      _tabController.index = _selectedIndex; // Sync controller
    });
  }

  void _onWorkoutButtonPressed() {
    print('Workout');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => addworkout()));
    // Add your workout-specific functionality here
  }

  void _onDietButtonPressed() {
    print('Diet');
    // Add your diet-specific functionality here
    Navigator.push(context, MaterialPageRoute(builder: (context) => adddiet()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TRACK_YOUR_PROGRESS'),
          bottom: TabBar(
            onTap: (i) {
              setState(() {
                _selectedIndex = i;
              });
            },
            controller: _tabController,
            tabs: const [
              Tab(text: "Track your workout"),
              Tab(text: "Track your diet"),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            WorkoutTracking(),
            Trackdiet(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_selectedIndex == 0) {
              _onWorkoutButtonPressed();
            } else if (_selectedIndex == 1) {
              _onDietButtonPressed();
            }
          },
          child: const Icon(Icons.add),
        ));
  }
}
