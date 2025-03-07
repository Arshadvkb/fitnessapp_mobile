import 'package:fitnessappnew/templates/expert/expert_home.dart';
import 'package:fitnessappnew/templates/login.dart';
import 'package:flutter/material.dart';
import 'chat_list.dart';
import 'health_tip.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text(
              'Expert Panel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ExpertHome()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.chat),
                  title: const Text('Chat List'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatListPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.health_and_safety),
                  title: const Text("New Tip"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Healthtip()),
                    );
                  },
                ),
                // Add more navigation items here
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
