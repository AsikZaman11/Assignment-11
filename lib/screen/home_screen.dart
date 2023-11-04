import 'dart:convert';

import 'package:assignment11/screen/gallery_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenUI();
}

class HomeScreenUI extends State<HomeScreen> {
  bool inProgress = false;
  List<Gallery> galleryList = [];

  Future<void> getImages() async {
    inProgress = true;
    setState(() {});

    Response response =
    await get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    if (response.statusCode == 200) {
      List<dynamic> jsonObj = jsonDecode(response.body);

      for (Map<String, dynamic> DartObj in jsonObj) {
        galleryList.add(Gallery(DartObj['albumId'], DartObj['id'],
            DartObj['title'], DartObj['url'], DartObj['thumbnailUrl']));
      }
      inProgress = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    getImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Gallery App"),
      ),
      body: inProgress
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: galleryList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GalleryDetails(
                          gallery: galleryList[index],
                        )
                    )
                );
              },
              leading: Image.network(galleryList[index].thumbnailUrl),
              title: Text(galleryList[index].title),
            ),
          );
        },
      ),
    );
  }
}


