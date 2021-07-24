import 'package:app_menh_ly/screens/van_thien/components/van_thien_ket_qua_screen.dart';
import 'package:flutter/material.dart';

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
    required double height,
    required double width,
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
        onPressed: () {
          setState(() {
            _selected = index;
          });
        },
        style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
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

  void showKetQua() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VanThienKetQua(
          selected: _selected,
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20),
        Center(
          child: Text(
            'Bạn cần lời giải cho vấn đề đang gặp phải là gì?',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildButton(
              title: 'Sức Khoẻ',
              index: 1,
              press: () {},
              image: 'assets/images/van-thien-suc-khoe.jpg',
              width: width,
              height: height,
            ),
            buildButton(
              title: 'Tài vận',
              index: 2,
              press: () {},
              image: 'assets/images/van-thien-tai-van.jfif',
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
              title: 'Tình Cảm',
              index: 3,
              press: () {},
              image: 'assets/images/van-thien-tinh-cam.jfif',
              width: width,
              height: height,
            ),
            buildButton(
              title: 'Công việc',
              index: 4,
              press: () {},
              image: 'assets/images/van-thien-cong-viec.jpg',
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
              title: 'Gia đình',
              index: 5,
              press: () {},
              image: 'assets/images/van-thien-gia-dinh.jfif',
              width: width,
              height: height,
            ),
          ],
        ),
        Spacer(),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: ElevatedButton(
            onPressed: _selected != 0 ? showKetQua : null,
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
