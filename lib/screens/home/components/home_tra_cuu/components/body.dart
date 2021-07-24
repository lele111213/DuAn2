import 'package:flutter/material.dart';
import 'screens/tra_cuu_info_screen.dart';

import 'sim_ung_menh.dart';
import 'tra_cat_nhan.dart';
import 'tra_dao_hoa.dart';
import 'tra_menh_than.dart';
import 'tra_quy_nhan.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            TraCatNhan(
              size: size,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TraCuuInfo(selected: 1),
                  ),
                );
              },
            ),
            TraDaoHoa(
              size: size,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TraCuuInfo(selected: 2),
                  ),
                );
              },
            ),
            TraMenhThan(
              size: size,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TraCuuInfo(selected: 3),
                  ),
                );
              },
            ),
            TraQuyNhan(
              size: size,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TraCuuInfo(selected: 4),
                  ),
                );
              },
            ),
            SimUngMenh(
              size: size,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TraCuuInfo(selected: 5),
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
