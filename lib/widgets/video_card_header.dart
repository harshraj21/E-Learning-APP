import 'package:flutter/material.dart';

import '../helpers/cust_colors.dart';

class VideoCardHeader extends StatelessWidget {
  final subject;
  final idx;
  VideoCardHeader(this.subject, this.idx);
  @override
  Widget build(BuildContext context) {
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
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: Color(recorded_col[idx % 6]['heading'] as int),
      ),
      child: Text(
        subject,
        // widget.classes[id]['subject'],
        style: TextStyle(
          color: Colors.white,
          // fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// ClipRRect(
//   borderRadius: BorderRadius.circular(15),
//   child: Image.asset(
//     './assets/images/optimus.jpg',
//     fit: BoxFit.cover,
//     width: double.infinity,
//     height: 210,
//   ),
// ),
