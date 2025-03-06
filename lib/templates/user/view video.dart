import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

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

  void viewComplaints() async {
    List<int> id = <int>[];
    List<String> trainers = <String>[];
    List<String> file = <String>[];
    List<String> description = <String>[];
    List<String> video_name = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/user_viewvideo';
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
        file.add(sh.getString('imgurl').toString() + arr[i]['video']);
      }

      setState(() {
        id_ = id;
        file_ = file;
        description_ = description;
        trainers_ = trainers;
        video_name_ = video_name;
      });
    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
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
                        Container(
                          width: 300.0,
                          height: 200.0,
                          child: VideoPlayerWidget(videoUrl: file_[index]),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            file_[index],
                            width: double.infinity,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text("Name: ${video_name_[index]}",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        Text("Decription: ${description_[index]}",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
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

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() {
        if (_controller.value.hasError) {
          print("Video Player Error: ${_controller.value.errorDescription}");
        }
      });
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.play(); // Auto-play the video on load
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error: ${snapshot.error}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
