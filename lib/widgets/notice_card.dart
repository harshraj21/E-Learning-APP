import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/notice_model.dart';
import '../helpers/cust_colors.dart';

class NoticeCard extends StatelessWidget {
  final int ctr;
  final NoticeModel notice;
  NoticeCard(this.ctr, this.notice);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 10,
          color: Color(cust_colors[ctr % 6]['background'] as int),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  notice.title,
                  style: TextStyle(
                    fontSize: 25,
                    color: Color(cust_colors[ctr % 6]['heading'] as int),
                  ),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
                Text(
                  DateFormat().format(
                    new DateTime.fromMillisecondsSinceEpoch(
                      notice.dateStamp,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 12,
                  ),
                ),
                Text(
                  notice.message,
                  style: TextStyle(
                    fontSize: 17,
                    color: Color(cust_colors[ctr % 6]['heading'] as int),
                    // fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
