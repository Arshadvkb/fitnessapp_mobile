import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class complaints extends StatefulWidget {
  const complaints({super.key});

  @override
  State<complaints> createState() => _complaintsState();
}

class _complaintsState extends State<complaints> {
  final _formKey = GlobalKey<FormState>();
  final _complaintController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COMPLAINTS'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _complaintController,
                  decoration: InputDecoration(
                    labelText: 'Enter your complaint',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Submit Complaint'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final sh = await SharedPreferences.getInstance();
                      String? url = sh.getString("url");
                      String? lid = sh.getString("lid");
                      if (url != null) {
                        print("okkkkkkkkkkkkkkkkk");
                        print(url);
                        var request = http.MultipartRequest(
                            'POST', Uri.parse('$url/user_add_workout'));
                        request.fields['lid'] = lid!;
                        request.fields['complaint'] = _complaintController.text;
                        var response = await request.send();
                        if (response.statusCode == 200) {
                          print('Complaint submitted');
                          Fluttertoast.showToast(
                              msg: "Complaint submitted",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          print('Failed to submit complaint');
                          Fluttertoast.showToast(
                              msg: "Failed to submit complaint",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
