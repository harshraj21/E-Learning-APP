import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/notice_model.dart';
import '../widgets/app_drawer.dart';
import '../widgets/notice_card.dart';
import '../providers/notice_provider.dart';

class Notice extends StatefulWidget {
  static const routeName = '/notice';

  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  bool _loaded = false;
  bool _error = false;

  void snackBar(String msg, int seconds) {
    try {
      final snackBar = SnackBar(
        duration: Duration(seconds: seconds),
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
      print('notice snackbar context not found');
    }
  }

  Future<void> _refresh() async {
    try {
      this.setState(() {
        _loaded = false;
        _error = false;
      });
      try {
        await Provider.of<NoticeProvider>(context, listen: false).getData();
        snackBar('Updated successfully', 1);
        this.setState(() {
          _loaded = true;
        });
      } catch (e) {
        snackBar('Error occured while fetching', 10);
        print('error catched while refreshing notices');
        this.setState(() {
          _error = true;
        });
      }
    } catch (e) {
      print('error while setting state in notice');
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      _refresh();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final noticehandle = Provider.of<NoticeProvider>(context);
    final List<NoticeModel> notices = noticehandle.items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Notice'),
      ),
      drawer: AppDrawer(),
      backgroundColor: Color(0xedededed), //slight gray
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: notices.length > 0
            ? ListView.builder(
                itemBuilder: (ctx, id) {
                  return NoticeCard(id, notices[id]);
                },
                itemCount: notices.length,
              )
            : Center(
                child: _loaded
                    ? ListView(
                        children: [
                          Text(
                            'No content available pull to refresh',
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                                fontSize: 35),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    : _error
                        ? ListView(
                            children: [
                              Text(
                                'Error occured pull to refresh',
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        : CircularProgressIndicator(),
              ),
      ),
    );
  }
}
