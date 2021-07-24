import 'dart:convert';

import 'package:app_menh_ly/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({Key? key}) : super(key: key);

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  String? _userName;
  int? _gender;
  DateTime? _birthDay;
  final DateTime now = new DateTime.now();

// build
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context)!;

    // Chọn ngày sinh
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: _birthDay ?? user.birthDay,
          firstDate: DateTime(1960),
          lastDate: DateTime(2022));
      if (pickedDate != null && pickedDate != now)
        setState(() {
          _birthDay = pickedDate;
        });
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/back-ground.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: BackButton(),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('Sửa thông tin người dùng'),
        ),
        body: Container(
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
                initialValue: _userName ?? user.userName,
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
                      color: ((_gender ?? user.gender) == 1)
                          ? Colors.blue
                          : Colors.transparent,
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
                      color: ((_gender ?? user.gender) == 2)
                          ? Colors.blue
                          : Colors.transparent,
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
                        DateFormat('dd/MM/yyyy')
                            .format(_birthDay ?? user.birthDay),
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
                          User user2 = new User(
                            userName: _userName ?? user.userName,
                            birthDay: _birthDay ?? user.birthDay,
                            gender: _gender ?? user.gender,
                          );

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('user', jsonEncode(user2.toJson()));
                          user2.login();
                          Navigator.pop(context);
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
        ),
      ),
    );
  }
}
