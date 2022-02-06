import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_app/models/song.dart';
import 'package:music_app/widgets/band_slider.dart';
import 'package:music_app/widgets/music_player.dart';
import 'package:music_app/widgets/slider_song.dart';

class TranSlateMusic extends StatefulWidget {
  final PageController bandPageController;
  final PageController songPageController;
  final List bands;

  TranSlateMusic({
    this.bandPageController,
    this.songPageController,
    this.bands,
  });

  @override
  _TranSlateMusicState createState() => _TranSlateMusicState();
}

class _TranSlateMusicState extends State<TranSlateMusic>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  Song currentSong = Song.empty();

  void onSelectMusic(Song song) {
    currentSong = song;
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                0,
                lerpDouble(
                  0,
                  -size.height,
                  Curves.ease.transform(animationController.value),
                ),
              ),
              child: child,
            );
          },
          child: Column(
            children: [
              BandSlider(
                bands: widget.bands,
                pageController: widget.bandPageController,
              ),
              SizedBox(height: 30),
              Expanded(
                child: SliderSong(
                  onSelectMusic: onSelectMusic,
                  pageController: widget.songPageController,
                  bands: widget.bands,
                ),
              ),
            ],
          ),
        ),
        AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                0,
                lerpDouble(
                  size.height,
                  0,
                  Curves.ease.transform(animationController.value),
                ),
              ),
              child: MusicPlayer(
                currentSong: currentSong,
                animationController: animationController,
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
