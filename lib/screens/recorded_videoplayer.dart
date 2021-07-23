import 'package:flutter/material.dart';

// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyRecordedVideoPlayer extends StatelessWidget {
  static const routeName = '/recordedvideoplayer';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videoplayer'),
      ),
      body: Text('Recorded videoplayer'),
    );
  }
}
