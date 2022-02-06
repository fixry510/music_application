import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:music_app/models/band.dart';
import 'package:music_app/models/song.dart';
import 'package:music_app/service/api_service.dart';
import 'package:music_app/widgets/band_detail.dart';

import 'package:music_app/widgets/song_tile.dart';

class Songs extends StatelessWidget {
  final Band band;
  final Function onSelectMusic;
  Songs({this.band, this.onSelectMusic});

  final isShowMusic = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiService().getBandSongs(band.bandId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          List<Song> songs = snapshot.data;
          return Stack(
            fit: StackFit.expand,
            children: [
              ValueListenableBuilder(
                valueListenable: isShowMusic,
                builder: (context, value, child) => AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  switchInCurve: Curves.decelerate,
                  switchOutCurve: Curves.decelerate,
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0, 1),
                        end: Offset(0, 0),
                      ).animate(animation),
                      child: FadeTransition(
                        opacity: Tween<double>(
                          begin: 0,
                          end: 1,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: value
                      ? ListView.separated(
                          key: ValueKey("1"),
                          padding: EdgeInsets.zero,
                          itemCount: songs.length,
                          separatorBuilder: (context, index) {
                            return Container(
                              height: 5,
                            );
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => onSelectMusic(songs[index]),
                              child: SongTile(song: songs[index]),
                            );
                          },
                        )
                      : BandDetail(band: band),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 50),
                  child: GestureDetector(
                    onTap: () {
                      isShowMusic.value = !isShowMusic.value;
                    },
                    child: ValueListenableBuilder(
                      valueListenable: isShowMusic,
                      builder: (context, value, child) {
                        return Text(
                          value ? "More Detail" : "Close",
                          style: GoogleFonts.caveat(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
