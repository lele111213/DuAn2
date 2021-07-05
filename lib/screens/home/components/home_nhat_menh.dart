import 'package:app_menh_ly/components/tinh_ngay.dart';
import 'package:app_menh_ly/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'home_header.dart';

class HomeNhatMenh extends StatelessWidget {
  HomeNhatMenh(
      {Key? key, required this.size, required this.now, required this.press})
      : super(key: key);
  final Size size;
  final DateTime now;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeader(title: 'NHẬT MỆNH'),
        Container(
          height: 150,
          padding: EdgeInsets.fromLTRB(kDefaultPadding / 2, kDefaultPadding,
              kDefaultPadding / 2, kDefaultPadding),
          margin: EdgeInsets.all(kDefaultPadding / 2),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/back-ground-home.jpg'),
              fit: BoxFit.cover,
            ),
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    '${TinhCanChi.tinhThu(now.weekday).toUpperCase()}\nNGÀY ${TinhCanChi.tinhNgayCanChi(now).toUpperCase()}\n${DateFormat('dd-MM-yyyy').format(now)}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: press,
                    child: Text(
                      'KHÁM PHÁ',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.all(kDefaultPadding),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(left: kDefaultPadding),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/lucky-4-leaf.png',
                      width: size.width * 0.078,
                    ),
                    Image.asset(
                      'assets/icons/lucky-4-leaf.png',
                      width: size.width * 0.078,
                    ),
                    Image.asset(
                      'assets/icons/lucky-4-leaf.png',
                      width: size.width * 0.078,
                    ),
                    Image.asset(
                      'assets/icons/lucky-4-leaf.png',
                      width: size.width * 0.078,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
