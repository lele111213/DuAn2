import 'package:app_menh_ly/models/user.dart';
import 'package:app_menh_ly/screens/home/home_screen.dart';
import 'package:app_menh_ly/screens/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user != null) {
      return HomeScreen();
    } else {
      return RegisterScreen();
    }
  }
}
