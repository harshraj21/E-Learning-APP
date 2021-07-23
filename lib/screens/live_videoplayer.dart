import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

import '../overlays/live_controls.dart';

class MyLiveVideoPlayer extends StatefulWidget {
  static const routeName = '/livevideoplayer';

  @override
  _MyLiveVideoPlayerState createState() => _MyLiveVideoPlayerState();
}

const url =
    'https://manifest.googlevideo.com/api/manifest/hls_playlist/expire/1625177450/ei/CundYMD9ApX64-EP3Oig6Ac/ip/2405:201:a408:9012:12d2:4e94:11ea:306a/id/ChimHmFaGZA.1/itag/96/source/yt_live_broadcast/requiressl/yes/ratebypass/yes/live/1/sgoap/gir%3Dyes%3Bitag%3D140/sgovp/gir%3Dyes%3Bitag%3D137/hls_chunk_host/r3---sn-gwpa-pmge.googlevideo.com/playlist_duration/30/manifest_duration/30/vprv/1/playlist_type/DVR/initcwndbps/1260/mh/pZ/mm/44/mn/sn-gwpa-pmge/ms/lva/mv/m/mvi/3/pcm2cms/yes/pl/50/dover/11/keepalive/yes/fexp/24001373,24007246/beids/23886220/mt/1625155712/sparams/expire,ei,ip,id,itag,source,requiressl,ratebypass,live,sgoap,sgovp,playlist_duration,manifest_duration,vprv,playlist_type/sig/AOq0QJ8wRgIhAOkIZiyyxdTPkB-Kk13yNFWk4UXdRbr8DHSdnS_tPTa0AiEA3-HDiA6galvAa9FVNYroj2whhk5kIEFgcI1sUSHVQjU%3D/lsparams/hls_chunk_host,initcwndbps,mh,mm,mn,ms,mv,mvi,pcm2cms,pl/lsig/AG3C_xAwRQIgTiwjQDi2SXxaKRQ3YpTrxvFozjOAJd9fkqNgrc0HXgoCIQDnBJSJmKU1K1a45BkN7tcnR2sLEzqpAgR4Xt0ADdKrBA%3D%3D/playlist/index.m3u8';

const url2 = 'http://breezing.me/bbb.mp4';

class _MyLiveVideoPlayerState extends State<MyLiveVideoPlayer> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 62,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('video stream was ended by the tutor.'),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'ok',
                      style: TextStyle(fontSize: 20, color: Colors.orange),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      url2,
    )..initialize().then((_) {
        setState(() {});
      });
    _controller.setVolume(100);
    _controller.play();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
    );
    Wakelock.enable();
    _controller.addListener(() {
      if (_controller.value.hasError) {
        _showMyDialog().then((value) => Navigator.of(context).pop());
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(() {
      if (_controller.value.hasError) {
        print(_controller.value.errorDescription);
      }
    });
    _controller.dispose();

    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    Wakelock.disable();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  void exitPageHandler() {
    Wakelock.disable();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: _controller.value.isInitialized
            ? Padding(
                padding: const EdgeInsets.all(0), //retundant //previous 1
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    VideoPlayer(_controller),
                    ControlsOverlay(
                      exitpage: exitPageHandler,
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}





































// import 'package:chewie/chewie.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';








// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';
// // import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// // import 'package:measured_size/measured_size.dart';

// class MyLiveVideoPlayer extends StatefulWidget {
//   static const routeName = '/livevideoplayer';

//   @override
//   _MyLiveVideoPlayerState createState() => _MyLiveVideoPlayerState();
// }

// const url =
//     'https://manifest.googlevideo.com/api/manifest/hls_playlist/expire/1625153639/ei/B4zdYObKHtT_4-EPv5eAuAw/ip/2405:201:a408:9012:12d2:4e94:11ea:306a/id/odmHZVWb7ws.1/itag/96/source/yt_live_broadcast/requiressl/yes/ratebypass/yes/live/1/sgoap/gir%3Dyes%3Bitag%3D140/sgovp/gir%3Dyes%3Bitag%3D137/hls_chunk_host/r4---sn-gwpa-pmge.googlevideo.com/playlist_duration/30/manifest_duration/30/vprv/1/playlist_type/DVR/initcwndbps/2050/mh/IQ/mm/44/mn/sn-gwpa-pmge/ms/lva/mv/m/mvi/4/pl/50/dover/11/keepalive/yes/fexp/24001373,24007246/beids/9466585/mt/1625131708/sparams/expire,ei,ip,id,itag,source,requiressl,ratebypass,live,sgoap,sgovp,playlist_duration,manifest_duration,vprv,playlist_type/sig/AOq0QJ8wRgIhAIAKkBdf0d03yP1wZlp4YaxT41Y7RXXTwbbXGmzInIgAAiEA_W3EUIwXpgmOWkDOUtCv8GN6ZH3t6-eriOBVWXmdxQU%3D/lsparams/hls_chunk_host,initcwndbps,mh,mm,mn,ms,mv,mvi,pl/lsig/AG3C_xAwRQIhAMITwnmJArShYrASihkG7z0o9BFcXC6Cb28MAFRy8HxWAiBHVKzUe2S4NW53TKXy17HXWvNIhfXYd7OF0dNYRpsm1Q%3D%3D/playlist/index.m3u8';

// class _MyLiveVideoPlayerState extends State<MyLiveVideoPlayer> {
//   late VideoPlayerController _videoPlayerController;
//   late ChewieController _chewieController;
//   double _aspectRatio = 16 / 9;
//   @override
//   initState() {
//     super.initState();
//     print(url);
//     _videoPlayerController = VideoPlayerController.network(url);
//     _chewieController = ChewieController(
//       allowedScreenSleep: false,
//       allowFullScreen: true,
//       deviceOrientationsAfterFullScreen: [
//         // DeviceOrientation.landscapeRight,
//         // DeviceOrientation.landscapeLeft,
//         DeviceOrientation.portraitUp,
//         DeviceOrientation.portraitDown,
//       ],
//       videoPlayerController: _videoPlayerController,
//       aspectRatio: _aspectRatio,
//       autoInitialize: true,
//       autoPlay: true,
//       // showControls: false,
//       // isLive: true,
//       showOptions: false,
//       allowPlaybackSpeedChanging: false,
//       // fullScreenByDefault: true,
//       // placeholder: CircularProgressIndicator(),
//       // showControlsOnInitialize: false,
//       errorBuilder: (ctx, err) {
//         print('error occured');
//         throw ('error');
//       },
//       // overlay: GestureDetector(
//       //   onTap: () {

//       //   },
//       //   child: ,
//       // ),
//     );
//     _chewieController.addListener(() {
//       // if (!_chewieController.isFullScreen) {
//       //   _chewieController.enterFullScreen();
//       // }
//       if (_chewieController.isFullScreen) {
//         SystemChrome.setPreferredOrientations([
//           DeviceOrientation.landscapeRight,
//           DeviceOrientation.landscapeLeft,
//         ]);
//       } else {
//         SystemChrome.setPreferredOrientations([
//           DeviceOrientation.portraitUp,
//           DeviceOrientation.portraitDown,
//         ]);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     _chewieController.dispose();
//     SystemChrome.setPreferredOrientations([
//       // DeviceOrientation.landscapeRight,
//       // DeviceOrientation.landscapeLeft,
//       DeviceOrientation.portraitDown,
//       DeviceOrientation.portraitUp,
//     ]);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Videoplayer'),
//       ),
//       body: SafeArea(
//         child: Center(
//           child: Container(
//             // height: MediaQuery.of(context).size.height * (2.04 - _aspectRatio),
//             child: Chewie(
//               controller: _chewieController,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // class _ControlsOverlay extends StatefulWidget {
// //   const _ControlsOverlay({Key? key, required this.controller})
// //       : super(key: key);

// //   final VideoPlayerController controller;

// //   @override
// //   __ControlsOverlayState createState() => __ControlsOverlayState();
// // }

// // class __ControlsOverlayState extends State<_ControlsOverlay> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Stack(
// //       children: <Widget>[
// //         AnimatedSwitcher(
// //           duration: Duration(milliseconds: 50),
// //           reverseDuration: Duration(milliseconds: 200),
// //           child: widget.controller.value.isPlaying
// //               ? SizedBox.shrink()
// //               : Container(
// //                   color: Colors.black26,
// //                 ),
// //         ),
// //         GestureDetector(
// //           onTap: () {},
// //         ),
// //       ],
// //     );
// //   }
// // }























// import 'package:flutter_socket_io/flutter_socket_io.dart';
// import 'package:flutter_socket_io/socket_io_manager.dart';

// const _ControlsOverlay({Key? key, required this.controller})
//     : super(key: key);

// final VideoPlayerController controller;



//here was the controls originally




  // late Socket socketIO;
  // late List<String> messages;
  // late TextEditingController textController;
  // late ScrollController scrollController;

  // @override
  // void initState() {
  //   //Initializing the message list
  //   messages = [];
  //   //Initializing the TextEditingController and ScrollController
  //   textController = TextEditingController();
  //   scrollController = ScrollController();
  //   //Creating the socket
  //   socketIO = io(
  //     '<ENTER THE URL OF YOUR DEPLOYED APP>',
  //     '/',
  //   );
  //   //Call init before doing anything with socket
  //   //Subscribe to an event to listen to
  //   socketIO.connect();
  //   socketIO.on('message', (jsonData) {
  //     //Convert the JSON data received into a Map
  //     Map<String, dynamic> data = json.decode(jsonData);
  //     this.setState(() => messages.add(data['message']));
  //     scrollController.animateTo(
  //       scrollController.position.maxScrollExtent,
  //       duration: Duration(milliseconds: 600),
  //       curve: Curves.ease,
  //     );
  //   });
  //   //Connect to the socket
  //   super.initState();
  // }

  // Widget buildSingleMessage(int index) {
  //   return Container(
  //     alignment: Alignment.centerLeft,
  //     child: Container(
  //       padding: const EdgeInsets.all(20.0),
  //       margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
  //       decoration: BoxDecoration(
  //         color: Colors.deepPurple,
  //         borderRadius: BorderRadius.circular(20.0),
  //       ),
  //       child: Text(
  //         messages[index],
  //         style: TextStyle(color: Colors.white, fontSize: 15.0),
  //       ),
  //     ),
  //   );
  // }

  // Widget buildMessageList() {
  //   return Container(
  //     height: height * 0.8,
  //     width: width,
  //     child: ListView.builder(
  //       controller: scrollController,
  //       itemCount: messages.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         return buildSingleMessage(index);
  //       },
  //     ),
  //   );
  // }

  // Widget buildChatInput() {
  //   return Container(
  //     width: width * 0.7,
  //     padding: const EdgeInsets.all(2.0),
  //     margin: const EdgeInsets.only(left: 40.0),
  //     child: TextField(
  //       decoration: InputDecoration.collapsed(
  //         hintText: 'Send a message...',
  //       ),
  //       controller: textController,
  //     ),
  //   );
  // }

  // Widget buildSendButton() {
  //   return FloatingActionButton(
  //     backgroundColor: Colors.deepPurple,
  //     onPressed: () {
  //       //Check if the textfield has text or not
  //       if (textController.text.isNotEmpty) {
  //         //Send the message as JSON data to send_message event
  //         socketIO.emit(
  //             'message', json.encode({'message': textController.text}));
  //         //Add the message to the list
  //         this.setState(() => messages.add(textController.text));
  //         textController.text = '';
  //         //Scrolldown the list to show the latest message
  //         scrollController.animateTo(
  //           scrollController.position.maxScrollExtent,
  //           duration: Duration(milliseconds: 600),
  //           curve: Curves.ease,
  //         );
  //       }
  //     },
  //     child: Icon(
  //       Icons.send,
  //       size: 30,
  //     ),
  //   );
  // }

  // Widget buildInputArea() {
  //   return Container(
  //     height: height * 0.1,
  //     width: width,
  //     child: Row(
  //       children: <Widget>[
  //         buildChatInput(),
  //         buildSendButton(),
  //       ],
  //     ),
  //   );
  // }





// AnimatedSwitcher(
//   duration: Duration(milliseconds: 50),
//   reverseDuration: Duration(milliseconds: 200),
//   child:
// ),

// void pushFullScreenVideo() {
//   SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
//   SystemChrome.setEnabledSystemUIOverlays([]);
//   SystemChrome.setPreferredOrientations(
//     [
//       // DeviceOrientation.portraitUp,
//       // DeviceOrientation.portraitDown,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ],
//   );
//   Navigator.of(context)
//       .push(
//     PageRouteBuilder(
//       opaque: false,
//       settings: RouteSettings(),
//       pageBuilder: (
//         BuildContext context,
//         Animation<double> animation,
//         Animation<double> secondaryAnimation,
//       ) {
//         return Scaffold(
//           backgroundColor: Colors.transparent,
//           resizeToAvoidBottomInset: false,
//           body: Dismissible(
//             key: const Key('key'),
//             direction: DismissDirection.vertical,
//             onDismissed: (_) => Navigator.of(context).pop(),
//             child: OrientationBuilder(
//               builder: (context, orientation) {
//                 var isPortrait = orientation == Orientation.portrait;
//                 return Center(
//                   child: Stack(
//                     fit: isPortrait ? StackFit.loose : StackFit.expand,
//                     children: [
//                       AspectRatio(
//                         aspectRatio: widget.controller.value.aspectRatio,
//                         child: VideoPlayer(widget.controller),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     ),
//   )
//       .then(
//     (value) {
//       SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
//       SystemChrome.setPreferredOrientations(
//         [
//           DeviceOrientation.portraitUp,
//           DeviceOrientation.portraitDown,
//         ],
//       );
//     },
//   );
// }
