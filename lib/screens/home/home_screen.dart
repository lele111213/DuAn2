// import 'package:app_menh_ly/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'components/home_nhat_menh.dart';
import 'components/home_trach_nhat.dart';
import 'components/home_user_info.dart';
import 'components/home_van_thien.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime now = new DateTime.now();
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   title: Text('App Menh ly'),
      // ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/back-ground.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HomeInfoUser(size: size, born: DateTime(1998, 4, 22)),
              HomeNhatMenh(size: size, now: now),
              HomeVanThien(size: size),
              HomeTrachNhat(size: size),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
