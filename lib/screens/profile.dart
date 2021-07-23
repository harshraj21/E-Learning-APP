import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class Profile extends StatefulWidget {
  static const routeName = '/profile';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late double height, width;
  int _selected = 0;
  void _handlePage(int index) {
    this.setState(() {
      _selected = index;
    });
  }

  Widget _inputBox(String hint, String label, IconData icon) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hint,
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget _pageGenerator() {
    if (_selected == 0) {
      return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  border: Border.all(color: Colors.white),
                ),
                alignment: Alignment.center,
                child: Text(
                  'N', //edit
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _inputBox(
              'Your name',
              'Name',
              Icons.person,
            ),
            _inputBox(
              'Your email id',
              'Email id',
              Icons.person,
            ),
            _inputBox(
              'Your mobile number',
              'Mobile number',
              Icons.person,
            ),
            _inputBox(
              'Your date of birth',
              'Date of birth',
              Icons.person,
            ),
          ],
        ),
      );
    } else if (_selected == 1) {
      return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
                hintText: 'Please enter your password',
                labelText: 'Old password',
                prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.green,
                ),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
                hintText: 'Please enter your password',
                labelText: 'New password',
                prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.green,
                ),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
                hintText: 'Please enter your password',
                labelText: 'Confirm password',
                prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Card(
        child: Text('Hello'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    height = mq.height;
    width = mq.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      drawer: AppDrawer(),
      body: _pageGenerator(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        onTap: _handlePage,
        backgroundColor: Colors.orange,
        fixedColor: Colors.white,
        currentIndex: _selected,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock),
            label: 'Password',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later),
            label: 'Details',
          ),
        ],
      ),
    );
  }
}











////////////////////////////////////
            // TextFormField(
            //   decoration: InputDecoration(
            //     border: new OutlineInputBorder(
            //         borderSide: new BorderSide(color: Colors.teal)),
            //     hintText: 'Your name',
            //     // helperText: 'Keep it short, this is just a demo.',
            //     labelText: 'Name',
            //     prefixIcon: const Icon(
            //       Icons.person,
            //       color: Colors.green,
            //     ),
            //     // prefixText: ' ',
            //     // suffixText: ' ',
            //     // suffixStyle: const TextStyle(color: Colors.green),
            //   ),
            // ),
////////////////////////////////////