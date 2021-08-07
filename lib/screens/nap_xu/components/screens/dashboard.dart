import 'package:app_menh_ly/screens/nap_xu/components/screens/momo_screen.dart';

import 'zalo_pay_screen.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
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
    Widget show = Container();
    switch (_selected) {
      case 1:
        show = MomoScreen();
        break;
      case 2:
        show = ZaloPayScreen();
        break;
      case 3:
        show = Container();
        break;
      default:
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => show,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width * 0.45;
    double height = width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20),
        Center(
          child: Text(
            'Nạp xu',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildButton(
              title: 'Dùng app Momo',
              index: 1,
              press: () {},
              image: 'assets/icons/logo-momo.png',
              width: width,
              height: height,
            ),
            buildButton(
              title: 'Dùng app ZaloPay',
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
              title: 'ATM/VISA/MASTERCARD',
              index: 3,
              press: () {},
              image: 'assets/images/van-thien-tinh-cam.jfif',
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
