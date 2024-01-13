// now_playing_model.dart

import 'package:flutter/material.dart';

class NowPlayingModel extends ChangeNotifier {
  late String title;
  late String image;

  late String artists;
  late Color color;

  void updateNowPlaying({
    required String title,
    required String image,
    required String artists,
    required Color color,
  }) {
    this.title = title;
    this.image = image;
    this.artists = artists;
    this.color = color;
    notifyListeners();
  }
}
