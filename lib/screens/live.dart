import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';

import '../widgets/app_drawer.dart';
import './live_videoplayer.dart';
import '../helpers/cust_colors.dart';

class Live extends StatelessWidget {
  static const routeName = '/live';

  @override
  Widget build(BuildContext context) {
    int cHeading = cust_colors[0 % cust_colors.length]['heading'] as int;
    int cBody = cust_colors[0 % cust_colors.length]['background'] as int;
    return Scaffold(
      appBar: AppBar(
        title: Text('Live'),
      ),
      drawer: AppDrawer(),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Material(
          borderRadius: BorderRadius.circular(30),
          color: Colors.transparent,
          child: InkWell(
            splashColor: Color(cHeading),
            borderRadius: BorderRadius.circular(30),
            onTap: () {
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
            child: Container(
              margin: EdgeInsets.all(4),
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(cBody),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  width: 3,
                  color: Color(cHeading),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Chemistry',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(cHeading),
                      ),
                    ),
                    Text(
                      'Electrochemistry',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 25,
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 26,
                        color: Colors.grey[600],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '7:30pm - 9:00pm',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.pushNamed(
//               context,
//               MyLiveVideoPlayer.routeName,
//             );
//             SystemChrome.setPreferredOrientations(
//               [
//                 DeviceOrientation.portraitUp,
//                 DeviceOrientation.portraitDown,
//               ],
//             );
//           },
//           child: Text('Play Video'),
//         ),
//       )