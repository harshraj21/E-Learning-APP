import 'package:flutter/material.dart';
// import 'package:omc/widgets/recorded_card.dart';
// import 'package:flutter_countdown_timer/index.dart';

import '../helpers/custom_timekeeper.dart';
import '../helpers/cust_colors.dart';

class VideoCardFooter extends StatelessWidget {
  final idx;
  final schedule;
  final expire;
  VideoCardFooter({
    @required this.idx,
    @required this.schedule,
    @required this.expire,
  });
//   @override
//   _VideoCardFooterState createState() => _VideoCardFooterState();
// }

// class _VideoCardFooterState extends State<VideoCardFooter> {
  @override
  Widget build(BuildContext context) {
    // controller = CountdownTimerController(endTime: ret['time'], onEnd: () {});
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(
            recorded_col[idx % 6]['border'] as int,
          ),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        color: Color(recorded_col[idx % 6]['heading'] as int),
      ),
      child: CustomTimeKeeper(
        schedule: schedule,
        expire: expire,
      ),
    );
  }
}
