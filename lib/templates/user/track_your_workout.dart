import 'package:flutter/material.dart' ;
import 'package:fitnessappnew/templates/user/diet.dart';
import 'package:fitnessappnew/templates/user/workout.dart';

class track_progress extends StatefulWidget {
  const track_progress({super.key});

  @override
  State<track_progress> createState() => _track_progressState();
}

class _track_progressState extends State<track_progress>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TRACK_YOUR_PROGRESS'),
        bottom: TabBar(
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
    );
  }
}
