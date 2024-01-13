import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerManager extends ChangeNotifier {
  late AudioPlayer _audioPlayer;

  AudioPlayerManager() {
    _audioPlayer = AudioPlayer();
  }

  AudioPlayer get audioPlayer => _audioPlayer;
}
