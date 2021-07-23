import 'package:flutter/material.dart';

import './drawer_header.dart';
import '../models/custom_icons_icons.dart';
import '../screens/help.dart';
import '../screens/live.dart';
import '../screens/notice.dart';
import '../screens/profile.dart';
import '../screens/recorded.dart';
// import '../screens/result.dart';

class AppDrawer extends StatelessWidget {
  Widget listtile(IconData i, String s, Function f) {
    return ListTile(
      leading: Icon(
        i,
        size: 30, //35 or 30 -- preffered
      ),
      title: Text(s),
      onTap: () => f(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Container(
      width: 250,
      child: Drawer(
        child: Column(
          children: [
            AppDrawerHeader(mq.padding.top),
            listtile(
              CustomIcons.clipboard,
              'Notice Board',
              () {
                Navigator.pushReplacementNamed(context, Notice.routeName);
              },
            ),
            listtile(
              CustomIcons.live_tv,
              'Live Class',
              () {
                Navigator.pushReplacementNamed(context, Live.routeName);
              },
            ),
            listtile(
              CustomIcons.television,
              'Recorded Class',
              () {
                Navigator.pushReplacementNamed(context, Recorded.routeName);
              },
            ),
            // listtile(
            //   CustomIcons.graph,
            //   'Results',
            //   () {
            //     Navigator.pushReplacementNamed(context, Result.routeName);
            //   },
            // ),
            listtile(
              CustomIcons.user,
              'Profile',
              () {
                Navigator.pushReplacementNamed(context, Profile.routeName);
              },
            ),
            listtile(
              CustomIcons.help_circled,
              'Help',
              () {
                Navigator.pushReplacementNamed(context, Help.routeName);
              },
            ),
            // listtile(
            //   CustomIcons.,
            //   'About',
            //   mq.size.width,
            //   () {},
            // ),
          ],
        ),
      ),
    );
  }
}
