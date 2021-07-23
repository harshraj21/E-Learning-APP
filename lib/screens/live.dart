import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';

import '../widgets/app_drawer.dart';
import './live_videoplayer.dart';

class Live extends StatelessWidget {
  static const routeName = '/live';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              MyLiveVideoPlayer.routeName,
            );
            SystemChrome.setPreferredOrientations(
              [
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
              ],
            );
          },
          child: Text('Play Video'),
        ),
      ),
    );
  }
}
