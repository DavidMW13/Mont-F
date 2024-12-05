import 'package:flutter/material.dart';
import 'full_screen_image.dart';

class GalleryPage extends StatelessWidget {
  final List<String> images = [
    'assets/images/04.jpg',
    'assets/images/20230928101414_IMG_4547.jpg',
    'assets/images/PicsArt_09-19-08.51.36.jpg',
    'assets/images/PicsArt_09-19-08.54.37.jpg',
    'assets/images/20240217183451_IMG_5565.jpg',
    'assets/images/20240623114514_IMG_6725.jpg',
    'assets/images/20231118152107_IMG_5210.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Galería',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[850],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FullScreenImage(imagePath: images[index]),
                ),
              );
            },
            child: Hero(
              tag: images[index],
              child: Image.asset(
                images[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
