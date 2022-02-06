import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_app/animations/translate_music.dart';
import 'package:music_app/models/band.dart';
import 'package:music_app/service/api_service.dart';
import 'package:music_app/widgets/blur_backgroud.dart';
import 'package:music_app/widgets/slider_background.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final PageController bandPageController =
      PageController(viewportFraction: 0.8);
  final PageController bgPageController = PageController();
  final PageController songPageController = PageController();

  @override
  void initState() {
    bandPageController.addListener(bgListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: FutureBuilder(
        future: ApiService().getBands(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Band> bands = snapshot.data;
          return Stack(
            fit: StackFit.expand,
            children: [
              SliderBackground(
                bgController: bgPageController,
                bands: bands,
              ),
              BlurBackground(),
              TranSlateMusic(
                bands: bands,
                bandPageController: bandPageController,
                songPageController: songPageController,
              ),
            ],
          );
        },
      ),
    );
  }

  void bgListener() {
    bgPageController.jumpTo(lerpDouble(
      0,
      bgPageController.position.maxScrollExtent,
      bandPageController.offset / bandPageController.position.maxScrollExtent,
    ));
    songPageController.jumpTo(lerpDouble(
      0,
      songPageController.position.maxScrollExtent,
      bandPageController.offset / bandPageController.position.maxScrollExtent,
    ));
  }
}
