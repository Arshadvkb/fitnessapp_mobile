import 'dart:convert';

import 'package:fitnessappnew/templates/expert/chat2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class chatwithexpert extends StatefulWidget {
  const chatwithexpert({Key? key}) : super(key: key);

  @override
  _chatwithexpertState createState() => _chatwithexpertState();
}

class _chatwithexpertState extends State<chatwithexpert> {
  List<ScheduleItem> _scheduleItems = [];

  @override
  void initState() {
    super.initState();
    fetchTimeScheduleData();
  }

  Future<void> fetchTimeScheduleData() async {
    final sh = await SharedPreferences.getInstance();
    String? url = sh.getString("url");
    String? lid = sh.getString("lid");

    if (url == null || lid == null) {
      throw Exception('URL or LID is null');
    }

    final response = await http.post(
      Uri.parse(url + '/expert_veiw_user'),
      headers: {
        'Content-Type': 'application/json', // Ensure you're sending JSON
      },
      body: json.encode({'lid': lid}), // Send 'lid' in the body
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        _scheduleItems = List<ScheduleItem>.from(
          data['data'].map((item) => ScheduleItem.fromJson(item)),
        );
      });
    } else {
      throw Exception('Failed to load expert details');
    }
  }

  Future<String?> getUsername() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String? lid = sh.getString('lid');
    String? url = sh.getString('url');
    print(url);
    print('iuuuuuuuurl');

    try {
      final response = await http.get(Uri.parse(url! + 'get-username/$lid/'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['username'];
      } else {
        print('Error: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with User'),
        iconTheme:
            IconThemeData(color: Colors.green), // Change icon color to green
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: (Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: _scheduleItems.length,
        itemBuilder: (context, index) {
          final schedule = _scheduleItems[index];
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  // Navigate to another page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MyChatPage2(title: 'Chat with ${schedule.user}'),
                    ),
                  );
                },
                child: ScheduleCard(
                  user: schedule.user,
                  image: schedule.image,
                  email: schedule.email,
                  LOGIN: schedule.LOGIN,
                ),
              ),
              SizedBox(height: 16), // Add gap between containers
            ],
          );
        },
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final String user;
  final String image;
  final String email;
  final String LOGIN;

  const ScheduleCard({
    required this.user,
    required this.image,
    required this.email,
    required this.LOGIN,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Make container full width
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
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(image),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' $user',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                ' $email',
                style: TextStyle(fontSize: 16),
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      Fluttertoast.showToast(msg: "Chat with ID: ${LOGIN}");
                      SharedPreferences sh =
                          await SharedPreferences.getInstance();
                      sh.setString(
                          'clid', LOGIN.toString()); // Ensure lid is a string
                      // Navigate to the ChatScreen and pass the tutor ID
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MyChatPage2(title: 'Chat with $user'),
                        ),
                      );
                    } catch (e) {
                      Fluttertoast.showToast(msg: "Error: $e");
                    }
                  },
                  child: Text('Chat'))
            ],
          ),
        ],
      ),
    );
  }
}

// Model for ScheduleItem
class ScheduleItem {
  final String user;
  final String image;
  final String email;
  final String LOGIN;

  ScheduleItem(
      {required this.user,
      required this.image,
      required this.email,
      required this.LOGIN});

  factory ScheduleItem.fromJson(Map<String, dynamic> json) {
    return ScheduleItem(
      user: json['name'],
      image: json['image'],
      email: json['email'],
      LOGIN: json['LOGIN'],
    );
  }
}

// Placeholder for the page to navigate to

