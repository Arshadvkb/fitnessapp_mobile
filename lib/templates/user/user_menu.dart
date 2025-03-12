import 'package:fitnessappnew/templates/expert/expert_home.dart';
import 'package:fitnessappnew/templates/login.dart';
import 'package:fitnessappnew/templates/user/user_home.dart';
import 'package:fitnessappnew/templates/user/view_profile.dart';
import 'package:flutter/material.dart';

import 'complaints.dart';

class Usermennu extends StatelessWidget {
  const Usermennu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.green,
        child: Column(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'USER MENU',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
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
                                builder: (context) => HomePage()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.warning, color: Colors.green),
                      title: const Text(
                        'Complaints',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const complaints()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.person_2, color: Colors.green),
                      title: const Text(
                        'View Profile',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const viewprofile()),
                        );
                      },
                    ),

                    // Add more navigation items here
                  ],
                ),
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
      ),
    );
  }
}
