import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicControls extends StatelessWidget {
  final AudioPlayer player;

  MusicControls({required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              // Implement skip previous logic
            },
            icon: Icon(
              Icons.skip_previous,
              color: Colors.white,
              size: 36,
            ),
          ),
          IconButton(
            onPressed: () async {
              if (player.state == PlayerState.playing) {
                await player.pause();
              } else {
                await player.resume();
              }
            },
            icon: Icon(
              player.state == PlayerState.playing
                  ? Icons.pause
                  : Icons.play_circle,
              color: Colors.white,
              size: 60,
            ),
          ),
          IconButton(
            onPressed: () {
              // Implement skip next logic
            },
            icon: Icon(
              Icons.skip_next,
              color: Colors.white,
              size: 36,
            ),
          ),
        ],
      ),
    );
  }
}
