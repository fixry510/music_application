import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/models/band.dart';

class BandSlider extends StatefulWidget {
  final PageController pageController;
  final List<Band> bands;
  BandSlider({this.bands, this.pageController});
  @override
  _BandSliderState createState() => _BandSliderState();
}

class _BandSliderState extends State<BandSlider> {
  double currentPage = 0.0;

  @override
  void initState() {
    widget.pageController.addListener(() {
      setState(() {
        currentPage = widget.pageController.page;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390,
      margin: const EdgeInsets.only(top: 60),
      child: PageView.builder(
        physics: const ClampingScrollPhysics(),
        itemCount: widget.bands.length,
        controller: widget.pageController,
        itemBuilder: (context, index) {
          final val = (currentPage - index);
          return Container(
            child: Transform.scale(
              scale: lerpDouble(1, 0.85, val.abs()),
              child: Transform.rotate(
                angle: lerpDouble(0, -6, val) * (pi / 180),
                child: Transform.translate(
                  offset: Offset(0, (val.abs() * 60).toDouble()),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${widget.bands[index].bandName}',
                          style: GoogleFonts.caveat(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 320,
                        height: 300,
                        decoration: BoxDecoration(
                          boxShadow: [
                            const BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 20,
                              spreadRadius: -5,
                              color: Colors.black,
                            )
                          ],
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(widget.bands[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
