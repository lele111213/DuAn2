import 'dart:convert';

import 'package:app_menh_ly/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _userName = "";
  int _gender = 0;
  DateTime _birthDay = new DateTime(1990);
  final DateTime now = new DateTime.now();
  // Chọn ngày sinh
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(1960),
        lastDate: DateTime(2022));
    if (pickedDate != null && pickedDate != now)
      setState(() {
        _birthDay = pickedDate;
      });
  }

// build
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Column(
        children: [
          Spacer(),
          Text('HỌ VÀ TÊN',
              style: TextStyle(color: Colors.white, height: 1),
              textScaleFactor: 1.4),
          SizedBox(height: 10),
          TextFormField(
            maxLength: 30,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              hintText: 'Họ và tên',
              hintStyle: TextStyle(color: Colors.white),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.4),
              focusedBorder: InputBorder.none,
            ),
            style: TextStyle(color: Colors.white),
            onChanged: (input) {
              setState(() {
                _userName = input;
              });
            },
          ),
          Spacer(),
          Text('GIỚI TÍNH',
              style: TextStyle(color: Colors.white, height: 1),
              textScaleFactor: 1.4),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: (_gender == 1) ? Colors.blue : Colors.transparent,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(50),
                ),
                width: 50,
                height: 50,
                child: IconButton(
                    icon: Icon(Icons.male, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _gender = 1;
                      });
                    }),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: (_gender == 2) ? Colors.blue : Colors.transparent,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(50),
                ),
                width: 50,
                height: 50,
                child: IconButton(
                    icon: Icon(Icons.female, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _gender = 2;
                      });
                    }),
              ),
            ],
          ),
          Spacer(),
          Text('NGÀY SINH DƯƠNG LỊCH',
              style: TextStyle(color: Colors.white, height: 1),
              textScaleFactor: 1.4),
          SizedBox(height: 10),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _selectDate(context);
              },
              child: Row(
                children: [
                  Spacer(),
                  Text(
                    DateFormat('dd/MM/yyyy').format(_birthDay),
                    textScaleFactor: 1.4,
                    style: TextStyle(color: Colors.white),
                  ),
                  Spacer(),
                  Icon(Icons.calendar_today, color: Colors.white),
                ],
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Colors.grey.withOpacity(0.4)),
              ),
            ),
          ),
          Spacer(),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (_userName != '' && _gender != 0)
                  ? () async {
                      User user = new User(
                        userName: _userName,
                        birthDay: _birthDay,
                        gender: _gender,
                      );
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString('user', jsonEncode(user.toJson()));
                      user.login();
                      // User ur =
                      //     User.fromJson(jsonDecode(prefs.getString('user')!));
                      // print(ur.birthDay);
                    }
                  : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    (_userName != '' && _gender != 0)
                        ? Colors.green
                        : Colors.grey),
              ),
              child: Text('Xác Nhận'),
            ),
          ),
        ],
      ),
    );
  }
}
