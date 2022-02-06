class Band {
  final int bandId;
  final String bandName;
  final String description;
  final int memberAmout;
  final String image;
  final String recordLabel;

  Band({
    this.bandId,
    this.bandName,
    this.description,
    this.image,
    this.memberAmout,
    this.recordLabel,
  });

  factory Band.fromJson(Map band) {
    return Band(
      bandId: band['band_id'],
      bandName: band['band_name'],
      description: band['description'],
      image: band['imageUrl'],
      memberAmout: band['member_amount'],
      recordLabel: band['record_label'],
    );
  }
}
