import 'package:flutter/material.dart';


class GalleryDetails extends StatelessWidget {
  final Gallery gallery;
  const GalleryDetails({super.key, required this.gallery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Details"),
      ),
      body: Column(
        children: [
          Image.network(gallery.url),
          Text(gallery.title),
          Text('ID: ${gallery.id}'),
        ],
      ),
    );
  }
}


class Gallery {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Gallery(this.albumId, this.id, this.title, this.url, this.thumbnailUrl);
}