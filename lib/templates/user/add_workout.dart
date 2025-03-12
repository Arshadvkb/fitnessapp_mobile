import 'package:fitnessappnew/templates/user/workout.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
        child: Form(
          key: _formKey,
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
                controller: _repsController,
                decoration: InputDecoration(
                  labelText: 'Reps',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _setController,
                decoration: InputDecoration(
                  labelText: 'Set',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _weightController,
                decoration: InputDecoration(
                  labelText: 'Weight',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Add Workout'),
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
                          'POST', Uri.parse('$url/user_add_workout'));
                      request.fields['workout_name'] =
                          _workoutnameController.text;
                      request.fields['reps'] = _repsController.text;
                      request.fields['set'] = _setController.text;
                      request.fields['weight'] = _weightController.text;
                      request.fields['lid'] = lid!;
                      var response = await request.send();
                      if (response.statusCode == 200) {
                        print('workout noted');
                        Fluttertoast.showToast(msg: 'success');
                      } else {
                        print('Failed to add workout');
                        Fluttertoast.showToast(msg: 'Failed to add workout');
                      }
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
