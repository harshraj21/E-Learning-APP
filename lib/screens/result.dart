import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class Result extends StatelessWidget {
  static const routeName = '/result';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      drawer: AppDrawer(),
      body: Text('Results'),
    );
  }
}
