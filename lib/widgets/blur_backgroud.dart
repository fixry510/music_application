import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

class BlurBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const BlurryContainer(
      bgColor: Colors.transparent,
      blur: 13,
      height: double.infinity,
      width: double.infinity,
      child: null,
    );
  }
}
