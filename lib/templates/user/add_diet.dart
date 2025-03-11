import 'package:flutter/material.dart';

class adddiet extends StatefulWidget {
  const adddiet({super.key});

  @override
  State<adddiet> createState() => _adddietState();
}

class _adddietState extends State<adddiet> {
  final _formKey = GlobalKey<FormState>();
  final _mealNameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Diet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextField(
                    controller: _mealNameController,
                    decoration: InputDecoration(
                      labelText: 'Meal Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _quantityController,
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _timeController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Time',
                      border: OutlineInputBorder(),
                    ),
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        // Handle the selected time
                        _timeController.text = pickedTime.format(context);
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Add your button functionality here
                    },
                    child: Text('Add Diet'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
