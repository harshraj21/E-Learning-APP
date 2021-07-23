import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

import '../models/recorded_model.dart';
import './video_card_header.dart';
import './video_card_body.dart';
import './video_card_footer.dart';
import '../screens/recorded_videoplayer.dart';
import '../providers/recorded_provider.dart';
import '../global/networksyncedtime.dart';
// import '../helpers/cust_colors.dart';

class RecordedCard extends StatelessWidget {
  final List<RecordedModel> classes;
  RecordedCard(this.classes);
  void callSnackBar(BuildContext context, String msg) {
    try {
      final snackBar = SnackBar(
        duration: Duration(seconds: 5),
        content: Text(
          msg,
          style: TextStyle(fontSize: 15),
          // textAlign: TextAlign.center,
        ),
        action: SnackBarAction(
          label: 'Hide',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      );
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        snackBar,
      );
    } catch (e) {
      print('error occured in recorded card snackbar');
    }
  }

  @override
  Widget build(BuildContext context) {
    final devicestamp = DateTime.now();
    final stamp =
        devicestamp.add(Duration(milliseconds: NetworkSyncedTime.offset));
    // print('called');
    // print(classes[0].description);
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (ctx, idx) {
        // print(classes[idx].schedule);
        // print(classes[idx].expire);
        if (classes[idx].expire <= stamp.millisecondsSinceEpoch + 1000) {
          return Container();
        }
        // print(widget.classes[id]['subject']);
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  // print('data sent to server');
                  try {
                    NetworkSyncedTime.initNetworkTime().then((_) {
                      Map ret = RecordedProvider.heavycalc(
                        classes[idx].schedule,
                        classes[idx].expire,
                      );
                      if (ret['available'] == available.yes) {
                        Navigator.pushNamed(
                          context,
                          MyRecordedVideoPlayer.routeName,
                        );
                      } else {
                        callSnackBar(context, 'currently not available');
                      }
                    }, onError: (__) {
                      callSnackBar(context, 'error occured try later');
                    });
                  } catch (e) {
                    print('error occured in recorded card f');
                  }
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 15,
                  child: Column(
                    children: [
                      VideoCardHeader(
                        classes[idx].subject,
                        idx,
                      ),
                      VideoCardBody(
                        classes[idx].title,
                        classes[idx].description,
                        idx,
                      ),
                      VideoCardFooter(
                        idx: idx,
                        schedule: classes[idx].schedule,
                        expire: classes[idx].expire,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: classes.length,
    );
  }
}
