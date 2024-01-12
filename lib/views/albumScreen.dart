import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:mobile_music_player_lyrics/constants/strings.dart';
import 'package:mobile_music_player_lyrics/views/music_player.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:spotify/spotify.dart'; // Import Spotify package

class AlbumsScreen extends StatefulWidget {
  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  late  List<Album> albums;
  late  List<Track> tracks;

  @override
  void initState() {
    super.initState();
    albums = [];
    tracks = [];
    loadAlbums();
  }

  Future<void> loadAlbums() async {
    final spotify = SpotifyApi(SpotifyApiCredentials(CustomStrings.clientId, CustomStrings.clientSecret));

    final albumId = '18NOKLkZETa4sWwLMIm0UZ';
    final spotifyAlbum = await spotify.albums.get(albumId);
    print('\nAlbum Tracks:');
    var tracksResponse = await spotify.albums.getTracks(albumId).all();
    // List<String?> trackIds = tracksResponse.map((track) => track.id).toList();
    tracks = tracksResponse
        .map(
          (track) => Track(
        trackId: track.id ?? "",
        artistName: track.artists?.isNotEmpty == true ? track.artists!.first.name : null,
        songName: track.name,
        songImage: spotifyAlbum.images?.isNotEmpty == true ? spotifyAlbum.images!.first.url : null,
      ),
    )
        .toList();

    Album album = Album(
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
        title: Text('Albums'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Album Details
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    Text(albums.isNotEmpty ? albums.first.name ?? '' : '',   style: textTheme.titleMedium
                        ?.copyWith(color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold,)),
                    SizedBox(height: 20,),
                    Text(albums.isNotEmpty ? albums.first.artist ?? '' : '',   style: textTheme.titleMedium
                        ?.copyWith(color: Colors.white60)),
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

class Album {
  String? name;
  String? artist;
  String? image;
  String albumId;

  Album({
    required this.albumId,
    this.name,
    this.artist,
    this.image,
  });
}

class Track {
  String trackId;
  String? artistName;
  String? songName;
  String? songImage;

  Track({
    required this.trackId,
    this.artistName,
    this.songName,
    this.songImage,
  });
}
