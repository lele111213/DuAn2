import 'package:flutter/material.dart';
import 'components/body.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  void initState() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/user-info.jfif'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent.withOpacity(0.7),
            toolbarHeight: 45,
            title: Text(
              'Mệnh Thần',
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.person_outline),
                tooltip: 'Sửa Thông Tin',
              )
            ],
          ),
          body: Body(),
        ),
      ),
    );
  }
}
