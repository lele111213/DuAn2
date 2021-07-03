import 'package:app_menh_ly/constants.dart';
import 'package:flutter/material.dart';
import 'home_header.dart';

class HomeVanThien extends StatelessWidget {
  const HomeVanThien({Key? key, required this.size}) : super(key: key);
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeader(title: 'VẤN THIÊN'),
        Container(
          height: 150,
          padding: EdgeInsets.fromLTRB(kDefaultPadding / 2, kDefaultPadding,
              kDefaultPadding / 2, kDefaultPadding),
          margin: EdgeInsets.all(kDefaultPadding / 2),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/back-ground-home.jpg'),
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
                    'Có việc cần hỏi\nVấn Thiên trả lời',
                    style: TextStyle(color: Colors.white),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'VẤN THIÊN',
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
                width: size.width * 0.5,
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  'images/ong-lac.png',
                  width: size.width * 0.3,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
