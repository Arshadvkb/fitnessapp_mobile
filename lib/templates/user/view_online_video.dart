// import 'package:flutter/material.dart';
//
// class view_online_video extends StatelessWidget {
//   const view_online_video({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ONLINE_TRAINING_VIDEOS '),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(20),
//         children: [
//           VideoCard(
//             title: 'Video 1',
//             description: 'Description for video 1',
//           ),
//           SizedBox(height: 20),
//           VideoCard(
//             title: 'Video 2',
//             description: 'Description for video 2',
//           ),
//           SizedBox(height: 20),
//           VideoCard(
//             title: 'Video 3',
//             description: 'Description for video 3',
//           ),
//           SizedBox(height: 20),
//           VideoCard(
//             title: 'Video 4',
//             description: 'Description for video 4',
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class VideoCard extends StatelessWidget {
//   final String title;
//   final String description;
//
//   const VideoCard({required this.title, required this.description});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: double.infinity,
//             height: 200,
//             color: Colors.black12,
//             child: const Icon(Icons.video_collection, size: 100),
//           ),
//           SizedBox(height: 10),
//           Text(
//             title,
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 5),
//           Text(description),
//         ],
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VideoProvider extends StatefulWidget {
  @override
  _VideoProviderState createState() => _VideoProviderState();
}

class _VideoProviderState extends State<VideoProvider> {
  List<String> videoIds = [];
  List<String> trainerNames = [];
  List<String> videoUrls = [];
  List<String> videoNames = [];
  List<String> descriptions = [];

  _VideoProviderState() {
    loadVideos();
  }

  Future<void> loadVideos() async {
    List<String> ids = [];
    List<String> trainers = [];
    List<String> videos = [];
    List<String> names = [];
    List<String> descs = [];

    try {
      final pref = await SharedPreferences.getInstance();
      String ip = pref.getString("url").toString();
      String url = "$ip/user_viewvideo";
      print(url);

      var response = await http.post(Uri.parse(url));
      var jsonData = json.decode(response.body);
      String status = jsonData['status'];

      if (status == 'ok') {
        var arr = jsonData["data"];

        for (int i = 0; i < arr.length; i++) {
          ids.add(arr[i]['id'].toString());
          trainers.add(arr[i]['TRAINER'].toString());
          videos.add(arr[i]['video'].toString());
          names.add(arr[i]['video_name'].toString());
          descs.add(arr[i]['description'].toString());
        }

        setState(() {
          videoIds = ids;
          trainerNames = trainers;
          videoUrls = videos;
          videoNames = names;
          descriptions = descs;
        });
      }
      print(status);
    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Training Videos"),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: videoIds.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 2,
                              fit: FlexFit.loose,
                              child: Text("Trainer: "),
                            ),
                            Flexible(
                              flex: 3,
                              fit: FlexFit.loose,
                              child: Text(trainerNames[index]),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 2,
                              fit: FlexFit.loose,
                              child: Text("Video Name: "),
                            ),
                            Flexible(
                              flex: 3,
                              fit: FlexFit.loose,
                              child: Text(videoNames[index]),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 2,
                              fit: FlexFit.loose,
                              child: Text("Description: "),
                            ),
                            Flexible(
                              flex: 3,
                              fit: FlexFit.loose,
                              child: Text(descriptions[index]),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 2,
                              fit: FlexFit.loose,
                              child: Text("Video URL: "),
                            ),
                            Flexible(
                              flex: 3,
                              fit: FlexFit.loose,
                              child: Text(videoUrls[index]),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                ),
              ),
            ),
            onTap: () {
              // Add video playback functionality here if needed
            },
          );
        },
      ),
    );
  }
}