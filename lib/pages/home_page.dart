import 'dart:io';

import 'package:aws_rekognition/controllers/image_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    File? _image;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, screenHeight * 0.02, 0, 0),
              child: Text(
                "Envie a sua foto para ser analisada",
                style: TextStyle(fontSize: 30),
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(16, screenHeight * 0.01, 16, 0),
              child: Text(
                "Nosso aplicativo utiliza o poder da inteligência artificial da Amazon Web Services (AWS) para realizar uma análise avançada de imagens. Por meio do serviço Amazon Rekognition, conseguimos detectar se sua imagem é algum tipo de conteúdo impróprio ou não",
                textAlign: TextAlign.justify,
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(0, screenHeight * 0.05, 0, 0),
              child: GestureDetector(
                onTap: () async {
                  final image = await ImageController.pegarImagemDaGaleria();
                  if (image != null) {
                    _image = image;
                  }
                },
                child: Container(
                  height: screenHeight * 0.25,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image),
                        Text(
                          "Selecionar arquivo",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(0, screenHeight * 0.05, 0, 0),
              child: Text("Ou"),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(
                screenWidth * 0.05,
                screenHeight * 0.05,
                screenHeight * 0.05,
                0,
              ),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt),
                    Text("Abra a câmera & Tire uma foto"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
