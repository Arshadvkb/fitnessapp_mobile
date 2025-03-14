import 'dart:convert';
import 'package:fitnessappnew/templates/user/chat%20(1).dart';
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
    String? imgUrl = sh.getString("imgurl"); // Get the image URL here

    if (url == null || lid == null || imgUrl == null) {
      throw Exception('URL, LID, or imgUrl is null');
    }

    final response = await http.post(
      Uri.parse(url + '/user_view_expert'),
      headers: {
        'Content-Type': 'application/json', // Ensure you're sending JSON
      },
      body: json.encode({'lid': lid}), // Send 'lid' in the body
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        _scheduleItems = List<ScheduleItem>.from(
          data['data'].map((item) => ScheduleItem.fromJson(item, imgUrl)),
        );
      });
    } else {
      throw Exception('Failed to load expert details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with Expert'),
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
                          MyChatPage(title: 'Chat with ${schedule.expert}'),
                    ),
                  );
                },
                child: ScheduleCard(
                  expert: schedule.expert,
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
  final String expert;
  final String image;
  final String email;
  final String LOGIN;

  const ScheduleCard({
    required this.expert,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' $expert',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  ' $email',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
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
                          builder: (context) => MyChatApp(),
                        ),
                      );
                    } catch (e) {
                      Fluttertoast.showToast(msg: "Error: $e");
                    }
                  },
                  child: Text('Chat'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Model for ScheduleItem
class ScheduleItem {
  final String expert;
  final String image;
  final String email;
  final String LOGIN;

  ScheduleItem({
    required this.expert,
    required this.image,
    required this.email,
    required this.LOGIN,
  });

  factory ScheduleItem.fromJson(Map<String, dynamic> json, String imageUrl) {
    return ScheduleItem(
      expert: json['name'],
      image: "$imageUrl/${json['image']}",
      email: json['email'],
      LOGIN: json['LOGIN'],
    );
  }
}

// Placeholder for the page to navigate to
// class MyChatPage2 extends StatelessWidget {
//   final String title;

//   const MyChatPage2({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: Center(
//         child: Text('Chat Screen - Implement your chat functionality here!'),
//       ),
//     );
//   }
// }

// class MyChatApp2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MyChatPage(title: 'Chat with Expert'),
//     );
//   }
// }
