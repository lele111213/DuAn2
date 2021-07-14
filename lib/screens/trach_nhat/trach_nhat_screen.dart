import 'package:flutter/material.dart';
import 'components/body.dart';

class TrachNhatScreen extends StatelessWidget {
  const TrachNhatScreen({Key? key}) : super(key: key);

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
            backgroundColor: Colors.transparent,
            toolbarHeight: 45,
            title: Text(
              'Trạch Nhật',
            ),
          ),
          body: Body(),
        ),
      ),
    );
  }
}
