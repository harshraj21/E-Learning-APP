import 'dart:async';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/recorded_card.dart';
import '../providers/recorded_provider.dart';
// import '../models/recorded_model.dart';

class Recorded extends StatefulWidget {
  static const routeName = '/recorded';
  @override
  _RecordedState createState() => _RecordedState();
}

class _RecordedState extends State<Recorded> {
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
      print('recorded snackbar context not found');
    }
  }

  Future<void> _refresh() async {
    try {
      this.setState(() {
        _loaded = false;
        _error = false;
      });

      try {
        await Provider.of<RecordedProvider>(context, listen: false).getData();
        snackBar('Updated successfully', 1);
        this.setState(() {
          _loaded = true;
        });
      } catch (e) {
        snackBar('Error occured while fetching', 10);
        this.setState(() {
          _error = true;
        });
      }
    } catch (e) {
      print('error while setting state in recorded');
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
    // print(Provider.of<RecordedProvider>(context, listen: false).getUnique());
    final recordedhandle = Provider.of<RecordedProvider>(context);
    final unique = recordedhandle.getUnique();
    // print('called2');
    return Scaffold(
      appBar: AppBar(
        title: Text('Recorded'),
      ),
      drawer: AppDrawer(),
      backgroundColor: Color(0xedededed), //slight gray
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: unique.length > 0
            ? ListView.builder(
                itemBuilder: (_, id) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 20,
                      child: Column(
                        children: [
                          Text(
                            unique[id],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 25,
                            ),
                          ),
                          RecordedCard(
                            recordedhandle.filteredData(unique[id]),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: unique.length,
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
      // : Container(
      //     width: double.infinity,
      //     margin: EdgeInsets.only(
      //         top: MediaQuery.of(context).size.height * 0.35),
      //     child:
      //   ),
      // body: RecordedCard(recorded[0]['content']),
    );
  }
}
