import 'package:flutter/material.dart';

import 'package:flutter_countdown_timer/index.dart';
import 'package:provider/provider.dart';

import '../providers/recorded_provider.dart';

class CustomTimeKeeper extends StatefulWidget {
  final int schedule;
  final int expire;
  CustomTimeKeeper({
    required this.schedule,
    required this.expire,
  });

  @override
  _CustomTimeKeeperState createState() => _CustomTimeKeeperState();
}

class _CustomTimeKeeperState extends State<CustomTimeKeeper> {
  late CountdownTimerController controller;
  late Map ret;
  bool _isInit = false;
  @override
  void initState() {
    ret = RecordedProvider.heavycalc(
      widget.schedule,
      widget.expire,
    );
    controller = CountdownTimerController(
      endTime: ret['time'],
      onEnd: () {
        // print('end');
        // controller.disposeTimer();
        try {
          Provider.of<RecordedProvider>(context, listen: false).getData();
        } catch (e) {
          print('error while refreshing timer');
        }
      },
    );
    _isInit = true;
    super.initState();
    // print('init called');
  }

  @override
  void dispose() {
    // print('dispose called');
    // CountdownTimerController.dispose();
    // this.dispose();
    _isInit = false;
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('called');
    if (_isInit) {
      ret = RecordedProvider.heavycalc(
        widget.schedule,
        widget.expire,
      );
      controller = CountdownTimerController(
        endTime: ret['time'],
        onEnd: () {
          // controller.disposeTimer();
          // print('end f');
          try {
            Provider.of<RecordedProvider>(context, listen: false).getData();
          } catch (e) {
            print('error while refreshing timer');
          }
        },
      );
    }
    // print('build called');
    // Map ret = RecordedProvider.heavycalc(
    //   schedule,
    //   expire,
    // );
    // late CountdownTimerController controller =
    //     CountdownTimerController(endTime: ret['time'], onEnd: () {});
    return CountdownTimer(
      controller: controller,
      key: UniqueKey(),
      // endTime: ret['time'],
      endTime: ret['time'],
      onEnd: () {
        // controller.disposeTimer();
        // _toggle();
        // controller.dispose();
      },
      widgetBuilder: (_, CurrentRemainingTime? time) {
        // if (time == null &&
        //     (ret['available'] == available.yes ||
        //         ret['available'] == available.no)) {
        if (time == null &&
            (ret['available'] == available.yes || ret[''] == available.no)) {
          // print('first text');
          return Text(
            'Expired',
            style: TextStyle(
              color: Colors.red,
              // fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          );
        } else if (ret['available'] == available.yes && time != null) {
          return Text(
            'Expires In: ${time.days == null ? 0 : time.days}hour ${time.min == null ? 0 : time.min}min ${time.sec == null ? 0 : time.sec}sec',
            style: TextStyle(
              color: Colors.white,
              // fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          );
        } else if (ret['available'] == available.no && time != null) {
          return Text(
            'Available In: ${time.days == null ? 0 : time.days}hour ${time.min == null ? 0 : time.min}min ${time.sec == null ? 0 : time.sec}sec',
            style: TextStyle(
              color: Colors.white,
              // fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          );
        } else {
          // just a failsafe
          // print('last text');
          return Text(
            'Expired',
            style: TextStyle(
              color: Colors.red,
              // fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
}
