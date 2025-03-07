import 'dart:convert';

import 'package:fitnessappnew/templates/expert/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Healthtip extends StatefulWidget {
  const Healthtip({super.key});
  @override
  State<Healthtip> createState() => _HealthtipState();
}

class _HealthtipState extends State<Healthtip> {
  final _formKey = GlobalKey<FormState>();
  final _tipTitleController = TextEditingController();
  final _tipDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Tips'),
      ),
      drawer: SideMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextField(
                    controller: _tipTitleController,
                    decoration: const InputDecoration(
                      labelText: 'Tip Title',
                    ),
                  ),
                  TextField(
                    controller: _tipDescriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Tip Description',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
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
                              'POST', Uri.parse('$url/expert_helth_tips'));
                          request.fields['tip_title'] =
                              _tipTitleController.text;
                          request.fields['tip_description'] =
                              _tipDescriptionController.text;
                          request.fields['lid'] = lid!;

                          var response = await request.send();
                          if (response.statusCode == 200) {
                            var responseData =
                                await response.stream.bytesToString();
                            var jsonData = json.decode(responseData);
                            String status = jsonData['status'].toString();
                            if (status == "ok") {
                              print("ok");
                            } else {
                              print("error");
                            }
                          } else {
                            print("Server error");
                          }
                        } else {
                          print("URL not found in SharedPreferences");
                        }
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tipTitleController.dispose();
    _tipDescriptionController.dispose();
    super.dispose();
  }
}
