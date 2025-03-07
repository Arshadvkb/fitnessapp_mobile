import 'package:flutter/material.dart';
import 'chat_list.dart';

class ExpertHome extends StatelessWidget {
  const ExpertHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expert Home'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatListPage()),
            );
          },
          child: const Text('Go to Chat List'),
        ),
      ),
    );
  }
}
