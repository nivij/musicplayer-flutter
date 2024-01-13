import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:mobile_music_player_lyrics/constants/strings.dart';
import 'package:mobile_music_player_lyrics/models/album.dart';
import 'package:mobile_music_player_lyrics/views/music_player.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:spotify/spotify.dart'; // Import Spotify package

class AlbumsScreen extends StatefulWidget {
  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  late  List<AlbumPlay> albums;
  late  List<TrackPlay> tracks;

  @override
  void initState() {
    super.initState();
    albums = [];
    tracks = [];
    loadAlbums();
  }

  Future<void> loadAlbums() async {
    final spotify = SpotifyApi(SpotifyApiCredentials(CustomStrings.clientId, CustomStrings.clientSecret));

    final albumId = '6tkjU4Umpo79wwkgPMV3nZ';
    final spotifyAlbum = await spotify.albums.get(albumId);
    print('\nAlbum Tracks:');
    var tracksResponse = await spotify.albums.getTracks(albumId).all();
    // List<String?> trackIds = tracksResponse.map((track) => track.id).toList();



    tracks = tracksResponse
        .map(
          (track) => TrackPlay(
        trackId: track.id ?? "",
        artistName: track.artists?.isNotEmpty == true ? track.artists!.first.name : null,
        songName: track.name,
        songImage: spotifyAlbum.images?.isNotEmpty == true ? spotifyAlbum.images!.first.url : null,
      ),
    )
        .toList();

    AlbumPlay album = AlbumPlay(
      albumId: albumId,
      name: spotifyAlbum.name,
      artist: spotifyAlbum.artists?.isNotEmpty == true ? spotifyAlbum.artists!.first.name : null,
      image: spotifyAlbum.images?.isNotEmpty == true ? spotifyAlbum.images!.first.url : null,
    );

// print('trackid');
// print(trackIds);
    setState(() {
      albums = [album];
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,

      ),
      body: Column(

        children: [
          // Album Details
          Container(

            child: Column(
              children: [
                // Album Cover
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: albums.isNotEmpty && albums.first.image != null
                        ? DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(albums.first.image!),
                    )
                        : null,
                  ),
                ),
                SizedBox(height: 8.0),


                Column(

                  children: [
                    Text(
                      albums.isNotEmpty ? albums.first.name ?? '' : '',
                      style: textTheme.titleMedium
                          ?.copyWith(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                      maxLines: 2, // Set the maximum number of lines
                      overflow: TextOverflow.ellipsis, // Specify the overflow behavior

                    ),
                    SizedBox(height: 20),
                    Text(
                      albums.isNotEmpty ? albums.first.artist ?? '' : '',
                      style: textTheme.titleMedium?.copyWith(color: Colors.white60),
                      maxLines: 1, // Set the maximum number of lines
                      overflow: TextOverflow.ellipsis, // Specify the overflow behavior
                    ),
                  ],
                ),
                // Artist Name

              ],
            ),
          ),
          // Album Tracks
          Expanded(
            child: ListView.builder(
              itemCount: tracks.length,
              itemBuilder: (context, index) {
                final track = tracks[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MusicPlayer(trackId: track.trackId),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(track.songName ?? ''  , style: textTheme.titleMedium
                        ?.copyWith(color: Colors.white)),
                    subtitle: Text(track.artistName ?? '',   style: textTheme.titleMedium
                        ?.copyWith(color: Colors.white60)),
                    leading: Text(
                      '${index+1}',
                      style: TextStyle(
                        color: Colors.white,fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}

