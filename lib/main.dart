import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:page_transition/page_transition.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:provider/provider.dart';

import './screens/notice.dart';
import './screens/live.dart';
import './screens/recorded.dart';
// import './screens/result.dart';
import './screens/help.dart';
import './screens/profile.dart';
import './screens/live_videoplayer.dart';
import './screens/recorded_videoplayer.dart';
import './providers/recorded_provider.dart';
import './global/networksyncedtime.dart';
import './providers/notice_provider.dart';

Future<void> secureScreen() async {
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.orange,
  ));
  if (!kIsWeb) {
    secureScreen();
  }
  NetworkSyncedTime.initNetworkTime().then(
    (value) => runApp(MyApp()),
    onError: (_) => SystemNavigator.pop(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => NoticeProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => RecordedProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Optimus',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.orange,
          fontFamily: 'Oswald',
          // accentColor: Colors.orangeAccent,
        ),
        home: Notice(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case Notice.routeName:
              return PageTransition(
                child: Notice(),
                type: PageTransitionType.topToBottom,
              );
            case Help.routeName:
              return PageTransition(
                child: Help(),
                type: PageTransitionType.topToBottom,
              );
            case Live.routeName:
              return PageTransition(
                child: Live(),
                type: PageTransitionType.topToBottom,
              );
            case Profile.routeName:
              return PageTransition(
                child: Profile(),
                type: PageTransitionType.topToBottom,
              );
            case Recorded.routeName:
              return PageTransition(
                child: Recorded(),
                type: PageTransitionType.topToBottom,
              );
            // case Result.routeName:
            //   return PageTransition(
            //     child: Result(),
            //     type: PageTransitionType.topToBottom,
            //   );
            case MyLiveVideoPlayer.routeName:
              return PageTransition(
                child: MyLiveVideoPlayer(),
                type: PageTransitionType.rightToLeftWithFade,
              );
            case MyRecordedVideoPlayer.routeName:
              return PageTransition(
                child: MyRecordedVideoPlayer(),
                type: PageTransitionType.rightToLeftWithFade,
              );
            default:
              return null;
          }
        },
        // routes: {
        //   Notice.routeName: (ctx) => Notice(),
        //   Help.routeName: (ctx) => Help(),
        //   // Live.routeName: (ctx) => Live(),
        //   Profile.routeName: (ctx) => Profile(),
        //   Recorded.routeName: (ctx) => Recorded(),
        //   Result.routeName: (ctx) => Result(),
        // },
      ),
    );
  }
}
