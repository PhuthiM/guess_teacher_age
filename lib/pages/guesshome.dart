import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:guess_teacher_age/pages/agesuccess.dart';
import 'package:guess_teacher_age/services/api.dart';

class GuessHome extends StatefulWidget {
  static const routeName = '/guesshome';
  const GuessHome({Key? key}) : super(key: key);

  @override
  _GuessHomeState createState() => _GuessHomeState();
}

class _GuessHomeState extends State<GuessHome> {
  int _month = 0;
  int _year = 0;
  var _isLoading = false;
  bool _guessAge = false;
  void guessClickButton(int year, int month) async {
    print("${year} ${month} ");
    var data = await check();

    if (data == null) return;

    String text = data["text"];
    bool value = data["value"];

    if (value) {
      setState(() {
        Navigator.pushReplacementNamed(context, PageAge.routeName);

      });
    } else {
      _showMaterialDialog('ผลการทาย', text);
    }
  }

  Future<Map<String, dynamic>?> check() async {
    try {
      setState(() {
        _isLoading = true;
      });
      var data = (await Api()
              .submit('guess_teacher_age', {'year': _year, 'month': _month}))as Map<String, dynamic>;
      return data;
    } catch (e) {
      print(e.toString());
      _showMaterialDialog('ERROR', e.toString());
      return null;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg, style: Theme.of(context).textTheme.bodyText2),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
              children: [
                const Text(
                  'อายุอาจารย์',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35.0),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                        width: 4.0,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(
                              10.0) //                 <--- border radius here
                          ),
                      color: Colors.yellow,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SpinBox(
                              textStyle: TextStyle(fontSize: 20.0),
                              min: 0,
                              max: 100,
                              value: 0,
                              onChanged: (value) {
                                _year = value as int;
                              },
                              decoration: const InputDecoration(
                                labelText: "ปี",
                                labelStyle: TextStyle(fontSize: 30.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SpinBox(
                              textStyle: TextStyle(fontSize: 20.0),
                              min: 0,
                              max: 11,
                              value: 0,
                              onChanged: (value) {
                                _month = value as int;
                              },
                              decoration: const InputDecoration(
                                labelText: "เดือน",
                                labelStyle: TextStyle(fontSize: 30.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () {
                                  //  print('$year  $month');
                                  guessClickButton(_year, _month);
                                },
                                child: const Text(
                                  'ทาย',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Text(
            'ตัวอย่างนี้กำหนดอายุเป็น 46 ปี 10 เดือน',
            style: TextStyle(fontSize: 20.0),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
