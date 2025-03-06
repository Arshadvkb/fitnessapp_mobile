import 'templates/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Order System',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RestaurantIpPage(),
    );
  }
}

class RestaurantIpPage extends StatefulWidget {
  @override
  _RestaurantIpPageState createState() => _RestaurantIpPageState();
}

class _RestaurantIpPageState extends State<RestaurantIpPage> {
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RestaurantIpPage()),
        );
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal[200]!, Colors.teal[400]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.teal[100],
                          child: Icon(
                            Icons.restaurant,
                            color: Colors.teal,
                            size: 60,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Restaurant Connect',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal[800],
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Restaurant Ip',
                            prefixIcon: Icon(Icons.vpn_key, color: Colors.teal),
                            filled: true,
                            fillColor: Colors.teal[50],
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.teal[200]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.teal[400]!),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            senddata();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.teal[600], // Button color
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            textStyle: TextStyle(fontSize: 18),
                          ),
                          child: Text('Connect'),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void senddata() async {
    String ip = _usernameController.text.toString();

    print(ip);
    SharedPreferences sh = await SharedPreferences.getInstance();

    sh.setString('ip', ip);
    sh.setString('url', 'http://$ip:8000');
    sh.setString('imgurl', 'http://$ip:8000/');
    sh.setString('imgurl2', 'http://$ip:8000/');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
