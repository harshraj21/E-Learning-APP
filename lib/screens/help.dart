import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/recorded_provider.dart';
// import '../providers/notice_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';

import '../widgets/app_drawer.dart';

class Help extends StatefulWidget {
  static const routeName = '/help';

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  late VideoPlayerController _controller;
  late AudioPlayer audioPlayer = AudioPlayer();
  String vidLink =
      'https://r3---sn-gwpa-pmge.googlevideo.com/videoplayback?expire=1626399736&ei=mI_wYOjTKa37juMPnPOfuAk&ip=165.232.191.182&id=o-AKoTGZ5tccwUujnvw3JyN3HbzUvkLzx0D0epPCrFIsNf&itag=248&aitags=133%2C134%2C135%2C136%2C137%2C160%2C242%2C243%2C244%2C247%2C248%2C271%2C278%2C313%2C394%2C395%2C396%2C397%2C398%2C399%2C400%2C401&source=youtube&requiressl=yes&vprv=1&mime=video%2Fwebm&ns=UNYAluy3AaXDiygrOG0StfYG&gir=yes&clen=55914595&dur=267.600&lmt=1600526794875454&keepalive=yes&fexp=24001373,24007246&c=WEB&txp=5532434&n=fwZjIgGp7wFRKpaWzV&sparams=expire%2Cei%2Cip%2Cid%2Caitags%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Cgir%2Cclen%2Cdur%2Clmt&sig=AOq0QJ8wRgIhAOfZ-c_m5mnRbukdSH2ZycD58vW37J3DvB445OxBoMsVAiEAgpUJj1Jl6hKRpZdIUZgfRxhElzJ_VL-uqj1IGbKOzco%3D&redirect_counter=1&rm=sn-h55ee7s&req_id=40020785abe0a3ee&cms_redirect=yes&ipbypass=yes&mh=bL&mip=2405:201:a408:9012:2a89:624f:2deb:41e3&mm=31&mn=sn-gwpa-pmge&ms=au&mt=1626377126&mv=u&mvi=3&pl=50&lsparams=ipbypass,mh,mip,mm,mn,ms,mv,mvi,pl&lsig=AG3C_xAwRAIgDmALANzajO615zLiCNE9XKrxT-Ej_FnwfGZFAgT_uusCIBGBHBUBZgmsDGSlPz4UejloszV6JJs2b12i0g0nQZ__';
  String audLink =
      'https://r3---sn-gwpa-pmge.googlevideo.com/videoplayback?expire=1626399736&ei=mI_wYOjTKa37juMPnPOfuAk&ip=165.232.191.182&id=o-AKoTGZ5tccwUujnvw3JyN3HbzUvkLzx0D0epPCrFIsNf&itag=251&source=youtube&requiressl=yes&vprv=1&mime=audio%2Fwebm&ns=UNYAluy3AaXDiygrOG0StfYG&gir=yes&clen=4853370&dur=267.621&lmt=1600522185633840&keepalive=yes&fexp=24001373,24007246&c=WEB&txp=5532434&n=fwZjIgGp7wFRKpaWzV&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Cgir%2Cclen%2Cdur%2Clmt&sig=AOq0QJ8wRgIhAL3N3iev8BuTnwNnb9Lpo0p09Ej3aiHtdhF4-ZiWzhPmAiEAwwPsRjjnYK9pWM0uLfUdJrHfxFshzJTJJO3ff13YCrg%3D&redirect_counter=1&rm=sn-h55ee7s&req_id=58f9c8b76686a3ee&cms_redirect=yes&ipbypass=yes&mh=bL&mip=2405:201:a408:9012:2a89:624f:2deb:41e3&mm=31&mn=sn-gwpa-pmge&ms=au&mt=1626377126&mv=u&mvi=3&pl=50&lsparams=ipbypass,mh,mip,mm,mn,ms,mv,mvi,pl&lsig=AG3C_xAwRAIgHb6zASK3wU2vxesGXr4n8_i7JexLUA88s3NF2-mZxYICIGpXExUmy3eexw5t5gsTuHRyXU1h5Oykps1PXw4HW1AW';

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      vidLink,
    )..initialize().then((_) {
        _controller.play();
        setState(() {});
      });
    audioPlayer.play(audLink);
  }

  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<NoticeProvider>(context, listen: false).sendData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      drawer: AppDrawer(),
      body: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : CircularProgressIndicator(),
      //   child: Text(DateTime.now().toString()),
      // ),
    );
  }
}
