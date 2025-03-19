import 'package:fitnessappnew/templates/user/user_home.dart';
import 'package:fitnessappnew/templates/user/user_menu.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:io';
import '../user/user_home.dart';

class UserViewCase extends StatelessWidget {
  const UserViewCase({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'View Reply',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 68, 255, 115)),
        useMaterial3: true,
      ),
      home: const UserPostView(title: 'View Reply'),
    );
  }
}

class UserPostView extends StatefulWidget {
  const UserPostView({super.key, required this.title});

  final String title;

  @override
  State<UserPostView> createState() => _UserPostViewState();
}

class _UserPostViewState extends State<UserPostView> {
  _UserPostViewState() {
    viewComplaints();
  }

  List<int> id_ = [];
  List<String> file_ = [];
  List<String> description_ = [];
  List<String> trainers_ = [];
  List<String> video_name_ = [];
  List<String> videoThumbnails = []; // List to store video thumbnail paths
  List<String> videoName_ = [];

  void viewComplaints() async {
    List<int> id = <int>[];
    List<String> trainers = <String>[];
    List<String> file = <String>[];
    List<String> description = <String>[];
    List<String> video_name = <String>[];
    List<String> thumbnails =
        <String>[]; // For storing the generated thumbnail paths

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/user_viewvideo';
      print("path======" + urls);
      print(url);

      var data = await http.post(Uri.parse(url));
      var jsondata = json.decode(data.body);

      String status = jsondata['status'];
      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id']);
        trainers.add(arr[i]['TRAINER'].toString());
        description.add(arr[i]['description'].toString());
        video_name.add(arr[i]['video_name'].toString());
        file.add(sh.getString('imgurl').toString() + "/" + arr[i]['video']);

        // Generate video thumbnail
        // String? thumbnailPath = await generateThumbnail(file[i]);
        // thumbnails.add(thumbnailPath ??
        //     ""); // Add thumbnail path or empty string if failed
        // print(arr[i]['video']);
      }

      setState(() {
        id_ = id;
        file_ = file;
        description_ = description;
        trainers_ = trainers;
        video_name_ = video_name;
        // videoThumbnails = thumbnails;
      });
    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
  }

  // Function to generate video thumbnail
  // Future<String?> generateThumbnail(String videoUrl) async {
  //   final filePath = await VideoThumbnail.thumbnailFile(
  //     video: videoUrl,
  //     imageFormat: ImageFormat.JPEG,
  //     maxHeight: 200,
  //     quality: 75,
  //   );
  //   return filePath;
  // }

  // Function to launch the URL
  Future<void> _launchURL(String url) async {
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          leadingWidth: 56.0,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Online Video',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        drawer: Usermennu(),
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _launchURL(file_[index]); // Launch the URL on tap
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: const Icon(
                              Icons.videocam,
                              size: 100,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text("Name: ${video_name_[index]}",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        Text("Description: ${description_[index]}",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
