import 'package:flutter/material.dart';

class AppDrawerHeader extends StatelessWidget {
  final dtop;

  AppDrawerHeader(this.dtop);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: dtop),
      child: Stack(
        children: [
          Container(
            child: Image.asset(
              './assets/images/background.jpg', //edit
              fit: BoxFit.cover,
              width: double.infinity,
              height: 210,
            ),
          ),
          Positioned(
            top: 75,
            left: 20,
            child: InkWell(
              onTap: () {
                print('Profile pic tapped.');
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.blue,
                  border: Border.all(color: Colors.white),
                ),
                alignment: Alignment.center,
                child: Text(
                  'N', //edit
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 150,
            left: 20,
            child: Text(
              'Name Title', //edit
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          ),
          Positioned(
            top: 175,
            left: 20,
            child: Text(
              'something@something.com', //edit
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          )
        ],
      ),
    );
  }
}
