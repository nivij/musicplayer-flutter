import 'package:flutter/material.dart';
import 'package:mobile_music_player_lyrics/views/albumScreen.dart';
import 'package:provider/provider.dart';

import 'common_widget/bottomNav.dart';
import 'controller/audioController.dart';
import 'controller/player.dart';
import 'views/music_player.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AudioPlayerManager(),
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Music Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  AlbumsScreen(),
    );
  }
}
