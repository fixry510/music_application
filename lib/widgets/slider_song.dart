import 'package:flutter/material.dart';
import 'package:music_app/models/band.dart';
import 'package:music_app/widgets/songs.dart';

class SliderSong extends StatelessWidget {
  final PageController pageController;
  final Function onSelectMusic;
  final List<Band> bands;
  SliderSong({this.bands, this.pageController, this.onSelectMusic});
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
      children: [
        ...bands.map((band) {
          return Songs(
            band: band,
            onSelectMusic: onSelectMusic,
          );
        }).toList()
      ],
    );
  }
}
