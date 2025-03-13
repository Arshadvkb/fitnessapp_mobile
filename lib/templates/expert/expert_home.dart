import 'package:flutter/material.dart';
import 'chat_list.dart';
import 'side_menu.dart';

class ExpertHome extends StatelessWidget {
  const ExpertHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expert Home'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Add navigation to settings page here
            },
          ),
        ],
      ),
      drawer: const SideMenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to Expert Home',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
