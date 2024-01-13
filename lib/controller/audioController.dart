import 'package:audioplayers/audioplayers.dart';

class AudioPlayerSingleton {
  static final AudioPlayerSingleton _singleton = AudioPlayerSingleton._internal();

  factory AudioPlayerSingleton() {
    return _singleton;
  }

  final AudioPlayer _audioPlayer;

  AudioPlayerSingleton._internal() : _audioPlayer = AudioPlayer();

  AudioPlayer get audioPlayer => _audioPlayer;
}
