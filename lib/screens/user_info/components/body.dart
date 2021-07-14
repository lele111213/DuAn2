import 'package:flutter/material.dart';
import 'package:app_menh_ly/models/user.dart';
import 'package:provider/provider.dart';

import 'gioi_thieu.dart';
import 'user_info.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context)!;
    return Column(
      children: [
        UserInfo(user: user),
        GioiThieu(),
      ],
    );
  }
}
