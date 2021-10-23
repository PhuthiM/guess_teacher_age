import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageAge extends StatefulWidget {
  static const routeName = '/pageage';
  const PageAge({Key? key}) : super(key: key);

  @override
  _PageAgeState createState() => _PageAgeState();
}

class _PageAgeState extends State<PageAge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GUESS TEACHER\'S AGE'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'อายุอาจารย์',
                  style: TextStyle(fontSize: 35.0),
                ),
                Text(
                  '46 ปี 10 เดือน',
                  style: TextStyle(fontSize: 30.0,color: Colors.black26),
                ),
                Icon(
                  Icons.check,
                  size: 30.0,
                  color: Colors.green,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: const Text(
              'ตัวอย่างนี้กำหนดอายุเป็น 46 ปี 10 เดือน',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }
}
