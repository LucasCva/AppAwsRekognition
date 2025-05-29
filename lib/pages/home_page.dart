import 'dart:io';

import 'package:aws_rekognition/controllers/image_controller.dart';
import 'package:aws_rekognition/service/image_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 21, 27),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16, screenHeight * 0.02, 0, 0),
                child: Text(
                  "Envie a sua foto para ser analisada",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(16, screenHeight * 0.01, 16, 0),
                child: Text(
                  "Nosso aplicativo utiliza o poder da inteligência artificial da Amazon Web Services (AWS) para realizar uma análise avançada de imagens. Por meio do serviço Amazon Rekognition, conseguimos detectar se sua imagem é algum tipo de conteúdo impróprio ou não",
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.white),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, screenHeight * 0.05, 0, 0),
                child: GestureDetector(
                  onTap: () async {
                    final image = await ImageController.pegarImagemDaGaleria();
                    if (image != null) {
                      setState(() {
                        _image = image;
                      });
                    }
                  },
                  child: Container(
                    height: screenHeight * 0.25,
                    width: screenWidth * 0.9,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 56, 59, 68),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: _image == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image, color: Colors.white),
                                Text(
                                  "Selecionar arquivo",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image, color: Colors.white),
                                Text(
                                  "Arquivo selecionado",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.03),
                child: Text("Ou", style: TextStyle(color: Colors.white)),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(
                  screenWidth * 0.05,
                  screenHeight * 0.03,
                  screenWidth * 0.05,
                  0,
                ),
                child: GestureDetector(
                  onTap: () async {
                    final image = await ImageController.pegarImagemDaCamera();
                    if (image != null) {
                      setState(() {
                        _image = image;
                      });
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 56, 59, 68),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt, color: Colors.white),
                        Text(
                          "  Abra a câmera & Tire uma foto",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, screenHeight * 0.03, 0, 0),
                child: Text(
                  _image == null
                      ? "Selecione uma imagem"
                      : "Imagem selecionada",
                  style: TextStyle(color: Colors.green),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, screenHeight * 0.05, 0, 0),
                child: GestureDetector(
                  onTap: () async {
                    if (_image == null || _isLoading) return;

                    setState(() {
                      _isLoading = true;
                    });

                    final response = await ImageService.enviarImagem(_image!);

                    setState(() {
                      _isLoading = false;
                      _image = null;
                    });

                    if (response.imageIsPermitted) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Color.fromARGB(255, 20, 21, 27),
                            title: Center(
                              child: Text(
                                "Imagem aceita",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            content: Text(
                              "Sua imagem foi analisada e está dentro dos padrões e foi adicionada à nossa galeria.",
                              style: TextStyle(color: Colors.white),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  "Ok",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      String motivos = response.moderationsList
                          .map((item) {
                            final categoria = item.parentName.isNotEmpty
                                ? " (${item.parentName})"
                                : "";
                            return "- ${item.name}$categoria (confiança: ${item.confidence.toStringAsFixed(1)}%)";
                          })
                          .join("\n");

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Color.fromARGB(255, 20, 21, 27),
                            title: Center(
                              child: Text(
                                "Imagem recusada",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sua imagem foi analisada e está fora dos padrões.\n\nMotivos:",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    motivos,
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  "Ok",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: _image == null ? Colors.grey : Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: _isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
