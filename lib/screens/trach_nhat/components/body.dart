import 'package:flutter/material.dart';

import 'get_info_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _selected = 0;
  Widget buildButton({
    required String title,
    required Function press,
    required String image,
    required double width,
    required double height,
    required int index,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: _selected == index ? Colors.blue : Colors.transparent,
        ),
      ),
      child: ElevatedButton(
        style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
        onPressed: () {
          setState(() {
            _selected = index;
          });
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(
              image,
              height: height,
              width: width,
              fit: BoxFit.fill,
            ),
            Text(
              title.toUpperCase(),
              style: TextStyle(shadows: [
                Shadow(
                  offset: Offset(0, 0),
                  blurRadius: 2.0,
                  color: Colors.black,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width * 0.45;
    double height = size.height * 0.12;
    return Column(
      children: [
        SizedBox(height: 20),
        Center(
          child: Text(
            'Bạn cần tìm ngày tốt để thực hiện việc gì?',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildButton(
              title: 'ký hợp đồng',
              index: 1,
              press: () {},
              image: 'assets/images/trach-nhat-ky-hd.jpg',
              width: width,
              height: height,
            ),
            buildButton(
              title: 'khai trương',
              index: 2,
              press: () {},
              image: 'assets/images/trach-nhat-khai-truong.jpg',
              width: width,
              height: height,
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildButton(
              title: 'hẹn hò',
              index: 3,
              press: () {},
              image: 'assets/images/trach-nhat-hen-ho.webp',
              width: width,
              height: height,
            ),
            buildButton(
              title: 'động thổ',
              index: 4,
              press: () {},
              image: 'assets/images/trach-nhat-dong-tho.jpg',
              width: width,
              height: height,
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildButton(
              title: 'đính hôn',
              index: 5,
              press: () {},
              image: 'assets/images/trach-nhat-dinh-hon.jfif',
              width: width,
              height: height,
            ),
            buildButton(
              title: 'dọn nhà',
              index: 6,
              press: () {},
              image: 'assets/images/trach-nhat-don-nha.jfif',
              width: width,
              height: height,
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildButton(
              title: 'Đám cưới',
              index: 7,
              press: () {},
              image: 'assets/images/trach-nhat-dam-cuoi.jpg',
              width: width,
              height: height,
            ),
            buildButton(
              title: 'thu tài sản',
              index: 8,
              press: () {},
              image: 'assets/images/trach-nhat-thu-tai-san.jpg',
              width: width,
              height: height,
            ),
          ],
        ),
        Spacer(),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: ElevatedButton(
            onPressed: _selected != 0
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GetInfo(
                          selected: _selected,
                        ),
                      ),
                    );
                  }
                : null,
            child: Text('Tiếp Tục'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  _selected != 0 ? Colors.green : Colors.grey),
            ),
          ),
        )
      ],
    );
  }
}
