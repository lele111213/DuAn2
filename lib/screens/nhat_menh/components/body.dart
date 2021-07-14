import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBarView(children: [
        Text('11111111111'),
        Text('12222222223123'),
        Text('333333333333'),
        Text('444444444444'),
      ]),
    );
  }
}
