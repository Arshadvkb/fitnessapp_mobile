import 'package:fitnessappnew/templates/user/editprofile.dart';
import 'package:fitnessappnew/templates/user/user_home.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class user_profile extends StatefulWidget {
  const user_profile({super.key, required this.title});

  final String title;

  @override
  State<user_profile> createState() => _user_profileState();
}

class _user_profileState extends State<user_profile> {
  @override
  void initState() {
    super.initState();
    senddata();
  }

  String name = 'name';
  String pin = 'pin';
  String place = 'place';
  String phone = 'phone';
  String email = 'email';
  String image = 'image';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: 280,
                width: double.infinity,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16.0, 240.0, 16.0, 16.0),
                child: InkWell(
                  onTap: () {
                    // showDialog(context: context, builder: (context) => Image.network(photo),);
                  },
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(16.0),
                            margin: EdgeInsets.only(top: 16.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(left: 110.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                            SizedBox(
                                              height: 40,
                                            )
                                          ],
                                        ),
                                        Spacer(),
                                        CircleAvatar(
                                          backgroundColor: Colors.green,
                                          child: IconButton(
                                              onPressed: () {
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //       builder: (context) =>
                                                //           editprofile(),
                                                //     ));
                                              },
                                              icon: Icon(
                                                Icons.edit_outlined,
                                                color: Colors.white,
                                                size: 18,
                                              )),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: DecorationImage(
                                    image: NetworkImage(image),
                                    fit: BoxFit.cover)),
                            margin: EdgeInsets.only(left: 20.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Profile Information"),
                            ),
                            Divider(),
                            ListTile(
                              title: Text('Place'),
                              subtitle: Text(' ${place}  '),
                              leading: Icon(Icons.location_city,
                                  color: Colors.green),
                            ),
                            Divider(),
                            ListTile(
                              title: Text('Email'),
                              subtitle: Text('$email'),
                              leading:
                                  Icon(Icons.mail_outline, color: Colors.green),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Phone"),
                              subtitle: Text(phone),
                              leading: Icon(Icons.phone, color: Colors.green),
                            ),
                            Divider(),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 60,
                left: 20,
                child: MaterialButton(
                  minWidth: 0.2,
                  elevation: 0.2,
                  color: Colors.white,
                  child: const Icon(Icons.arrow_back_ios_outlined,
                      color: Colors.green),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void senddata() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    final urls = Uri.parse(url + "/user_home");
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          setState(() {
            email = jsonDecode(response.body)['email'].toString();
            name = jsonDecode(response.body)['name'].toString();
            phone = jsonDecode(response.body)['phone'].toString();

            place = jsonDecode(response.body)['place'].toString();
            image = sh.getString('imgurl2').toString() +
                jsonDecode(response.body)['image'];
          });
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
