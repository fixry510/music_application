import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/models/song.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPlayer extends StatefulWidget {
  final AnimationController animationController;
  final Song currentSong;

  MusicPlayer({this.animationController, this.currentSong});

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  AudioPlayer player;

  Duration currentTime = Duration();
  Duration fullTime = Duration();

  bool isDrag = false;
  double valume = 1;
  @override
  void initState() {
    player = AudioPlayer();
    player.onAudioPositionChanged.listen((event) {
      setState(() {
        if (isDrag == false) {
          currentTime = event;
        }
      });
    });
    player.onDurationChanged.listen((event) {
      setState(() {
        fullTime = event;
      });
    });
    player.onPlayerCompletion.listen((event) {
      setState(() {
        player.stop();
        isPause = false;
      });
    });

    super.initState();
  }

  bool isPause = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.black.withOpacity(0.4),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment(-0.8, 0.1),
                child: GestureDetector(
                  onTap: () {
                    if (player.state == PlayerState.PLAYING ||
                        player.state == PlayerState.PAUSED) {
                      player.stop();
                      isPause = false;
                    }
                    widget.animationController.reverse();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 300,
                height: 300,
                decoration: widget.currentSong.songImage == ''
                    ? null
                    : BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(widget.currentSong.songImage),
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              SizedBox(height: 30),
              Text(
                widget.currentSong.name,
                style: GoogleFonts.quicksand(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "${widget.currentSong.songType} / ${widget.currentSong.playTime} / ${widget.currentSong.songWriter}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                height: 100,
                child: player.state == PlayerState.PLAYING
                    ? Lottie.asset(
                        'assets/lottie/voice_effect.json',
                        width: 250,
                      )
                    : null,
              ),
              Column(
                children: [
                  Container(
                    height: 25,
                    child: Slider(
                      min: 0,
                      max: fullTime.inSeconds.toDouble(),
                      value: currentTime.inSeconds.toDouble(),
                      activeColor: Colors.red,
                      onChanged: (value) async {
                        isDrag = true;
                        await player.seek(Duration(seconds: value.toInt()));
                        isDrag = false;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 28),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${currentTime.toString().substring(2, 7)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${widget.currentSong.playTime}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      player.seek(
                        Duration(seconds: currentTime.inSeconds.toInt() - 10),
                      );
                    },
                    child: Icon(
                      Icons.replay_10_rounded,
                      size: 30,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(width: 30),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        if (player.state == PlayerState.STOPPED) {
                          player.play(widget.currentSong.playerUrl);
                        } else {
                          if (player.state == PlayerState.PLAYING) {
                            player.pause();
                          } else {
                            player.resume();
                          }
                        }
                        isPause = !isPause;
                      });
                    },
                    child: Icon(
                      isPause ? Icons.pause : Icons.play_arrow,
                      size: 60,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(width: 30),
                  GestureDetector(
                    onTap: () {
                      player.seek(
                        Duration(seconds: currentTime.inSeconds.toInt() + 10),
                      );
                    },
                    child: Icon(
                      Icons.forward_10_rounded,
                      size: 30,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              Container(
                width: 250,
                child: Column(
                  children: [
                    Container(
                      height: 30,
                      child: Slider(
                        value: valume,
                        activeColor: Colors.red,
                        min: 0,
                        max: 1,
                        onChanged: (value) {
                          setState(() {
                            valume = value;
                            player.setVolume(value);
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.volume_down_rounded,
                            color: Colors.red,
                          ),
                          Icon(
                            Icons.volume_up_rounded,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    player.stop();
    player.dispose();
    super.dispose();
  }
}
