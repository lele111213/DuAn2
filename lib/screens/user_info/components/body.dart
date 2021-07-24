import 'package:flutter/material.dart';

import 'gioi_thieu.dart';
import 'user_info.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserInfo(),
        GioiThieu(),
      ],
    );
  }
}
