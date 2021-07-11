import 'package:flutter/material.dart';
import 'components/body.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  void initState() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0),
          toolbarHeight: 45,
          leading: BackButton(color: Colors.black),
          title: Text(
            'Mệnh Thần',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.person_outline, color: Colors.black),
              tooltip: 'Sửa Thông Tin',
            )
          ],
        ),
        body: Body(),
      ),
    );
  }
}
