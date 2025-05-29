import 'package:aws_rekognition/pages/home_page.dart';
import 'package:aws_rekognition/pages/images_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _pages = [HomePage(), ImagesPage()];
  int _indiceAtual = 0;

  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_indiceAtual],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 197, 197, 197),
        backgroundColor: Color.fromARGB(255, 20, 21, 27),
        onTap: onTabTapped,
        currentIndex: _indiceAtual,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: "Imagens"),
        ],
      ),
    );
  }
}
