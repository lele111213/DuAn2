import 'package:flutter/material.dart';
import 'components/body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        title: Text('Nhập thông tin người dùng'),
      ),
      body: Body(),
    );
  }
}
