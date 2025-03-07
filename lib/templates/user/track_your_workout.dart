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
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onWorkoutButtonPressed() {
    print('Workout');
    // Add your workout-specific functionality here
  }

  void _onDietButtonPressed() {
    print('Diet');
    // Add your diet-specific functionality here
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
            DietTracking(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_selectedIndex == 0) {
              _onWorkoutButtonPressed();
            } else {
              _onDietButtonPressed();
            }
          },
          child: const Icon(Icons.add),
        ));
  }
}
