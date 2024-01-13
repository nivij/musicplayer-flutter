class AlbumPlay {
  String? name;
  String? artist;
  String? image;
  String albumId;

  AlbumPlay({
    required this.albumId,
    this.name,
    this.artist,
    this.image,
  });
}

class TrackPlay {
  String trackId;
  String? artistName;
  String? songName;
  String? songImage;

  TrackPlay({
    required this.trackId,
    this.artistName,
    this.songName,
    this.songImage,
  });
}
