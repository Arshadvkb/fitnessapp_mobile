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
          Container(
            width: double.infinity,
            color: Colors.green,
            child: const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Center(
                child: Text(
                  'Expert Panel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.home, color: Colors.green),
                  title: const Text(
                    'Home',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ExpertHome()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.chat, color: Colors.green),
                  title: const Text(
                    'Chat List',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatListPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.health_and_safety, color: Colors.green),
                  title: const Text(
                    "New Tip",
                    style: TextStyle(fontSize: 18),
                  ),
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
            leading: Icon(Icons.logout, color: Colors.redAccent),
            title: const Text(
              'Logout',
              style: TextStyle(fontSize: 18),
            ),
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
