import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/models/band.dart';
import 'package:music_app/service/api_service.dart';

class BandDetail extends StatelessWidget {
  final Band band;
  BandDetail({this.band});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey("2"),
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(15),
      ),
      child: FutureBuilder(
        future: ApiService().getBandImage(band.bandId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List imageList = snapshot.data;
          return Container(
            padding: EdgeInsets.only(left: 15, top: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${band.bandName}",
                    style: GoogleFonts.caveat(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  FittedBox(
                    child: Text(
                      "Labels : ${band.recordLabel}  |  Members : ${band.memberAmout}",
                      style: GoogleFonts.quicksand(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 88,
                    child: SingleChildScrollView(
                      child: Text(
                        "${band.description}" * 2,
                        style: GoogleFonts.quicksand(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 80,
                    child: ListView.builder(
                      itemCount: imageList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 80,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: NetworkImage(imageList[index]['image']),
                                fit: BoxFit.cover,
                              )),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
