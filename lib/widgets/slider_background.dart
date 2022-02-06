import 'package:flutter/material.dart';

class SliderBackground extends StatelessWidget {
  PageController bgController;
  List bands;
  SliderBackground({this.bgController, this.bands});
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: bgController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ...bands.map((band) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(band.image),
                fit: BoxFit.cover,
              ),
            ),
          );
        }).toList()
      ],
    );
  }
}
