import 'package:flutter/material.dart';

class addworkout extends StatefulWidget {
  const addworkout({super.key});
  @override
  State<addworkout> createState() => _addworkoutState();
}

class _addworkoutState extends State<addworkout> {
  final _formKey = GlobalKey<FormState>();
  final _workoutnameController = TextEditingController();
  final _repsController = TextEditingController();
  final _setController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Workout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _workoutnameController,
              decoration: InputDecoration(
                labelText: 'Workout Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'reps',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'set',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'weight',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add your button functionality here
              },
              child: Text('Add Workout'),
            ),
          ],
        ),
      ),
    );
  }
}
