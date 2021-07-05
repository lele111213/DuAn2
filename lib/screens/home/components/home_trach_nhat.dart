import 'package:app_menh_ly/constants.dart';
import 'package:flutter/material.dart';

import 'home_header.dart';

class HomeTrachNhat extends StatelessWidget {
  const HomeTrachNhat({Key? key, required this.size, required this.press})
      : super(key: key);
  final Size size;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeader(title: 'TRẠCH NHẬT'),
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
              TextButton(
                onPressed: press,
                child: Text(
                  'TRẠCH NHẬT',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.all(kDefaultPadding),
                  ),
                ),
              ),
              Spacer(),
              Text(
                'Chọn ngày đại cát\nVận may bát ngát',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
