import 'package:app_menh_ly/constants.dart';
import 'package:flutter/material.dart';

class TraDaoHoa extends StatelessWidget {
  const TraDaoHoa({Key? key, required this.size, required this.press})
      : super(key: key);
  final Size size;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: EdgeInsets.fromLTRB(kDefaultPadding / 2, kDefaultPadding,
          kDefaultPadding / 2, kDefaultPadding),
      margin: EdgeInsets.all(kDefaultPadding / 2),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/tra-dao-hoa.jpg'),
          fit: BoxFit.cover,
        ),
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 3,
            color: Colors.white,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nhớ thương một người?\nHãy kiểm tra xem bạn và\nngười ấy có hợp nhau!',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomLeft,
            child: TextButton(
              onPressed: press,
              child: Text(
                'TRA ĐÀO HOA',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.pink[300]),
                padding: MaterialStateProperty.all(
                  EdgeInsets.all(kDefaultPadding / 3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
