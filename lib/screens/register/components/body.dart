import 'package:app_menh_ly/models/user.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        title: Text('Nhập thông tin người dùng'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: ElevatedButton(
          onPressed: () {
            User user =
                new User(userName: 'Văn Sửu', birthDay: DateTime(1977, 1, 11));
            user.login();
          },
          child: Text('Click Here!'),
        ),
      ),
    );
  }
}
