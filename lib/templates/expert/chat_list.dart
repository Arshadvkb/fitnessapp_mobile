import 'package:flutter/material.dart';
import 'side_menu.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat List'),
      ),
      drawer: const SideMenu(),
      body: ListView.builder(
        itemCount: 10, // Replace with the actual number of people
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text('Person ${index + 1}'), // Replace with actual names
            subtitle: Text('Tap to chat'),
            onTap: () {
              // Navigate to chat page
            },
          );
        },
      ),
    );
  }
}
