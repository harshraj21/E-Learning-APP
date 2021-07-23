import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/notice_model.dart';

class NoticeProvider with ChangeNotifier {
  List<NoticeModel> _notices = [
    // NoticeModel(
    //   dateStamp: new DateTime.now().millisecondsSinceEpoch + 1000 * 900,
    //   title: 'Good Morning',
    //   message:
    //       'WelcometothenewappWelcometothenewappWelcometothenewappWelcometothenewappWelcometothenewappWelcometothenewapp',
    // ),
    // NoticeModel(
    //   dateStamp: new DateTime.now().millisecondsSinceEpoch + 1000 * 200,
    //   title: 'Bad Morning',
    //   message:
    //       'WelcometothenewappWelcometothenewappWelcometothenewappWelcometothenewappWelcometothenewappWelcometothenewapp',
    // ),
    // NoticeModel(
    //   dateStamp: new DateTime.now().millisecondsSinceEpoch + 1000 * 1200,
    //   title: 'Get lost',
    //   message:
    //       'WelcometothenewappWelcometothenewappWelcometothenewappWelcometothenewappWelcometothenewappWelcometothenewapp',
    // ),
    // NoticeModel(
    //   dateStamp: new DateTime.now().millisecondsSinceEpoch + 1000 * 100,
    //   title: 'oahfioahfiohaiofioahfoi',
    //   message:
    //       'WelcometothenewappWelcometothenewappWelcometothenewappWelcometothenewappWelcometothenewappWelcometothenewapp',
    // ),
    // NoticeModel(
    //   dateStamp: new DateTime.now().millisecondsSinceEpoch + 1000 * 678,
    //   title: 'iowhinfafuiafbnauiofn',
    //   message:
    //       'WelcometothenewappWelcometothenewappWelcometothenewappWelcometothenewappWelcometothenewappWelcometothenewapp',
    // ),
    // NoticeModel(
    //   dateStamp: new DateTime.now().millisecondsSinceEpoch + 1000 * 3654,
    //   title: 'ohegiohsniognuseihgn',
    //   message:
    //       'WelcometothenewappWelcometothenewappWelcometothenewappWelcometothenewappWelcometothenewappWelcometothenewapp',
    // ),
  ];

  void _sortData() {
    _notices.sort((a, b) => a.dateStamp.compareTo(b.dateStamp));
  }

  List<NoticeModel> get items {
    _sortData();
    return List.from([..._notices].reversed);
  }

  // void sendData() {
  //   final url = Uri.https(
  //       'test-77907-default-rtdb.asia-southeast1.firebasedatabase.app',
  //       'notices.json');
  //   for (int i = 0; i < _notices.length; i++) {
  //     http.post(
  //       url,
  //       body: json.encode({
  //         'datestamp': _notices[i].dateStamp,
  //         'title': _notices[i].title,
  //         'message': _notices[i].message,
  //       }),
  //     );
  //   }
  // }

  Future<void> getData() async {
    final url = Uri.https(
        'test-77907-default-rtdb.asia-southeast1.firebasedatabase.app',
        'notices.json');
    try {
      final resp = await http.get(url);
      final decodedResp = json.decode(resp.body) as Map<String, dynamic>;
      List<NoticeModel> retrived = [];
      decodedResp.forEach((key, value) {
        retrived.add(NoticeModel(
          id: key,
          dateStamp: value['datestamp'],
          title: value['title'],
          message: value['message'],
        ));
      });
      _notices = retrived;
      notifyListeners();
    } catch (e) {
      throw 'error occured';
    }
  }
}
