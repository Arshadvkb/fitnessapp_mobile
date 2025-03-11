import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

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
                        final now = DateTime.now();
                        final selectedTime = DateTime(
                          now.year,
                          now.month,
                          now.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                        _timeController.text =
                            DateFormat('HH:mm:ss').format(selectedTime);
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                      child: const Text('Add Diet'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Process data.
                          final sh = await SharedPreferences.getInstance();
                          String? url = sh.getString("url");
                          String? lid = sh.getString("lid");
                          if (url != null) {
                            print("okkkkkkkkkkkkkkkkk");
                            print(url);
                            var request = http.MultipartRequest(
                                'POST', Uri.parse('$url/user_add_diet'));
                            request.fields['meal_name'] =
                                _mealNameController.text;
                            request.fields['quantity'] =
                                _quantityController.text;
                            request.fields['time'] = _timeController.text;
                            request.fields['lid'] = lid!;
                            var response = await request.send();
                            if (response.statusCode == 200) {
                              print('Diet added successfully');
                              Fluttertoast.showToast(
                                  msg: 'Diet added successfully');
                            } else {
                              print('Failed to add diet');
                              Fluttertoast.showToast(msg: 'Failed to add diet');
                            }
                          }
                        }
                        ;
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
