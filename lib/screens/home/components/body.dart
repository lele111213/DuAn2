import 'package:app_menh_ly/screens/nhat_menh/nhat_menh_screen.dart';
import 'package:app_menh_ly/screens/trach_nhat/trach_nhat_screen.dart';
import 'package:app_menh_ly/screens/user_info/user_info_screen.dart';
import 'package:app_menh_ly/screens/van_thien/van_thien_screen.dart';
import 'package:flutter/material.dart';

import 'home_nhat_menh.dart';
import 'home_trach_nhat.dart';
import 'home_user_info.dart';
import 'home_van_thien.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime now = new DateTime.now();
    return SingleChildScrollView(
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
            HomeInfoUser(
              size: size,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInfoScreen(),
                  ),
                );
              },
            ),
            HomeNhatMenh(
              size: size,
              now: now,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NhatMenhScreen(),
                  ),
                );
              },
            ),
            HomeVanThien(
              size: size,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VanThienScreen(),
                  ),
                );
              },
            ),
            HomeTrachNhat(
              size: size,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrachNhatScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
