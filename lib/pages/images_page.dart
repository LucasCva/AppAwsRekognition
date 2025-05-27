import 'package:flutter/material.dart';

class ImagesPage extends StatefulWidget {
  const ImagesPage({super.key});

  @override
  State<ImagesPage> createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  final List<String> imageUrls = [
    'https://picsum.photos/id/237/300/300',
    'https://picsum.photos/id/238/300/300',
    'https://picsum.photos/id/239/300/300',
    'https://picsum.photos/id/240/300/300',
    'https://picsum.photos/id/241/300/300',
    'https://picsum.photos/id/242/300/300',
    'https://app-caserta-2025.s3.us-east-1.amazonaws.com/imagens/1748313013_843b5dd3-66b6-4750-853f-f7a2dbfe0d5a3692764802108515078.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: imageUrls.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8),
              child: Image.network(imageUrls[index], fit: BoxFit.cover),
            );
          },
        ),
      ),
    );
  }
}
