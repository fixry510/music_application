class Song {
  final int songId;
  final int bandId;
  final String name;
  final String songType;
  final String playTime;
  final String songWriter;
  final String playerUrl;
  final String songImage;

  Song({
    this.songId,
    this.bandId,
    this.name,
    this.playTime,
    this.playerUrl,
    this.songImage,
    this.songType,
    this.songWriter,
  });

  Song.empty({
    this.songId = 0,
    this.bandId = 0,
    this.name = '',
    this.songType = '',
    this.playTime = '',
    this.songWriter = '',
    this.playerUrl = '',
    this.songImage = '',
  });

  factory Song.fromJson(Map song) {
    return Song(
      songId: song['song_id'],
      bandId: song['band_id'],
      name: song['name'],
      playTime: song['playtime'],
      songImage: song['song_image'],
      playerUrl: song['playerUrl'],
      songType: song['song_type'],
      songWriter: song['song_writer'],
    );
  }
}
