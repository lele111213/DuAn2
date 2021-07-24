import 'dart:convert';

import 'package:app_menh_ly/models/user.dart';
import 'package:app_menh_ly/screens/home/home_screen.dart';
import 'package:app_menh_ly/screens/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  // _getUser: lấy user đã được lưu từ trước => User(đã đăng nhập trước đó) || null(chưa đăng nhập bao giờ) => null khi lần đầu vào ứng dụng
  _getUser(User? user) async {
    final prefs = await SharedPreferences.getInstance();
    String userJsonString = prefs.getString('user') ?? '';
    if (userJsonString != '') {
      user = User.fromJson(jsonDecode(userJsonString));
      user.login();
    }
  }

  @override
  Widget build(BuildContext context) {
    // loggedIn = User (đã đăng nhập)|| null (chưa đăng nhập) => null khi vừa vào ứng dụng.
    final loggedIn = Provider.of<User?>(context);
    User? user;
    if (loggedIn == null) {
      _getUser(user);
      if (user != null) {
        return HomeScreen();
      } else {
        return RegisterScreen();
      }
    } else if (loggedIn != null) {
      return HomeScreen();
    } else {
      return RegisterScreen();
    }
  }
}
