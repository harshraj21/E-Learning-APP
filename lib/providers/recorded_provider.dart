import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';

import '../models/recorded_model.dart';
import '../global/networksyncedtime.dart';

enum available {
  yes,
  no,
  expired,
}

class RecordedProvider with ChangeNotifier {
  List<RecordedModel> _recorded = [
    // RecordedModel(
    //   date: DateTime.now().millisecondsSinceEpoch - 1000 * 86400,
    //   subject: 'Physics',
    //   title: 'Current Electricity',
    //   description: 'You will learn about various types of cells and batteries',
    //   url: 'https://google.com/',
    //   schedule: DateTime.now().millisecondsSinceEpoch + 1000 * 900,
    //   expire: DateTime.now().millisecondsSinceEpoch + 1000 * 1500,
    // ),
    // RecordedModel(
    //   date: DateTime.now().millisecondsSinceEpoch - 1000 * 86400,
    //   subject: 'Chemistry',
    //   title: 'Chemical Kinetics',
    //   description:
    //       'You will learn about Different types of chemicals and their properties',
    //   url: 'https://google.com/',
    //   schedule: DateTime.now().millisecondsSinceEpoch + 1000 * 1000,
    //   expire: DateTime.now().millisecondsSinceEpoch + 1000 * 1600,
    // ),
    // RecordedModel(
    //   date: DateTime.now().millisecondsSinceEpoch - 1000 * 86400,
    //   subject: 'Biology',
    //   title: 'Plant Cells',
    //   description: 'Various types of plants thier species and their cell types',
    //   url: 'https://google.com/',
    //   schedule: DateTime.now().millisecondsSinceEpoch + 1000 * 800,
    //   expire: DateTime.now().millisecondsSinceEpoch + 1000 * 1400,
    // ),
    // RecordedModel(
    //   date: DateTime.now().millisecondsSinceEpoch - 1000 * (86500 * 2),
    //   subject: 'Chemistry',
    //   title: 'Extra Class 1',
    //   description: 'Extra Classes',
    //   url: 'https://google.com/',
    //   schedule: DateTime.now().millisecondsSinceEpoch + 1000 * 1100,
    //   expire: DateTime.now().millisecondsSinceEpoch + 1000 * 1700,
    // ),
    // RecordedModel(
    //   date: DateTime.now().millisecondsSinceEpoch - 1000 * (86400 * 2),
    //   subject: 'Biology',
    //   title: 'Plant Tissues',
    //   description: 'Type of plant and their tissues',
    //   url: 'https://google.com/',
    //   schedule: DateTime.now().millisecondsSinceEpoch + 1000 * 700,
    //   expire: DateTime.now().millisecondsSinceEpoch + 1000 * 1300,
    // ),
    // RecordedModel(
    //   date: DateTime.now().millisecondsSinceEpoch - 1000,
    //   subject: 'Chemistry2',
    //   title: 'Extra Class 1',
    //   description: 'Extra Classes',
    //   url: 'https://google.com/',
    //   schedule: DateTime.now().millisecondsSinceEpoch + 1000 * 600,
    //   expire: DateTime.now().millisecondsSinceEpoch + 1000 * 1200,
    // )
  ];

  void _sortData() {
    _recorded.sort((a, b) => a.date.compareTo(b.date));
  }

  List<RecordedModel> filteredData(var req) {
    // DateTime datez = new DateTime.fromMillisecondsSinceEpoch(req);
    // final reqd = DateFormat('dd/MM/yyyy').format(datez);
    return _recorded.where((element) {
      DateTime tmpdatez = new DateTime.fromMillisecondsSinceEpoch(element.date);
      final tmpreqd = DateFormat('dd/MM/yyyy').format(tmpdatez);
      return req == tmpreqd;
    }).toList();
  }

  List getUnique() {
    _sortData();
    var unique = [];
    for (int i = 0; i < _recorded.length; i++) {
      DateTime datez =
          new DateTime.fromMillisecondsSinceEpoch(_recorded[i].date);
      final reqd = DateFormat('dd/MM/yyyy').format(datez);
      unique.add(reqd);
    }
    return List.from(unique.toSet().toList().reversed);
  }

  // List<RecordedModel> get recorded {
  //   // _sortData();
  //   return [..._recorded];
  // }

  static Map heavycalc(int schedule, int expire) {
    Map returndata;
    final devicestamp = DateTime.now();
    final syncedstamp =
        devicestamp.add(Duration(milliseconds: NetworkSyncedTime.offset));
    final currentstamp = syncedstamp.millisecondsSinceEpoch + 1000;
    // print('current $devicestamp');
    // print('network $currentstamp');
    if (schedule > currentstamp && expire > currentstamp) {
      returndata = {
        'available': available.no,
        'time': schedule,
      };
    } else if (schedule < currentstamp && expire > currentstamp) {
      returndata = {
        'available': available.yes,
        'time': expire,
      };
    } else if (schedule < currentstamp && expire < currentstamp) {
      returndata = {
        'available': available.expired,
        'time': expire, //anything will work here
      };
    } else {
      //just a failsafe as this will never happen
      returndata = {
        'available': available.expired,
        'time': expire, //anytime will work here
      };
    }
    return returndata;
  }

  // void sendData() {
  //   final url = Uri.https(
  //       'test-77907-default-rtdb.asia-southeast1.firebasedatabase.app',
  //       'recorded.json');
  //   // int i = 0;
  //   for (int i = 0; i < _recorded.length; i++) {
  //     http.post(
  //       url,
  //       body: json.encode({
  //         'date': _recorded[i].date,
  //         'subject': _recorded[i].subject,
  //         'title': _recorded[i].title,
  //         'description': _recorded[i].description,
  //         'url': _recorded[i].url,
  //         'schedule': _recorded[i].schedule,
  //         'expire': _recorded[i].expire,
  //       }),
  //     );
  //   }
  // }

  Future<void> getData() async {
    final url = Uri.https(
        'test-77907-default-rtdb.asia-southeast1.firebasedatabase.app',
        'recorded.json');
    try {
      final resp = await http.get(url);
      final decodedResp = json.decode(resp.body) as Map<String, dynamic>;
      List<RecordedModel> retrived = [];
      decodedResp.forEach((key, value) {
        retrived.add(RecordedModel(
          id: key,
          date: value['date'],
          subject: value['subject'],
          title: value['title'],
          description: value['description'],
          url: value['url'],
          schedule: value['schedule'],
          expire: value['expire'],
        ));
      });
      _recorded = retrived;
      notifyListeners();
    } catch (e) {
      throw 'error occured';
    }
  }
}
