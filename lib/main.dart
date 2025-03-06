import 'package:fitnessappnew/ip.dart';
import 'package:flutter/material.dart';
import 'templates/user/user_home.dart'; // Import user_home.dart

void main() {
  runApp(GymApp());
}

class GymApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home:
          RestaurantIpPage(), // Set HomePage from user_home.dart as the default page
      debugShowCheckedModeBanner: false,
    );
  }
}
