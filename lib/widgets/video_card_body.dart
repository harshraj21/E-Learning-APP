import 'package:flutter/material.dart';

import '../helpers/cust_colors.dart';

class VideoCardBody extends StatelessWidget {
  final title;
  final description;
  final idx;
  VideoCardBody(this.title, this.description, this.idx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(
            recorded_col[idx % 6]['border'] as int,
          ),
        ),
        // borderRadius: BorderRadius.circular(15),
        color: Color(recorded_col[idx % 6]['background'] as int),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              // widget.classes[id]['title'],
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              // textAlign: TextAlign.center,
            ),
            Text(
              // widget.classes[id]['desc'],
              description,
              style: TextStyle(
                color: Colors.white,
                // fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              // textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
