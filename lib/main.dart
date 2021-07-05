import 'package:app_menh_ly/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: UserStream.stream,
      initialData: UserStream.onStateChaned,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Menh Ly',
        // theme: ThemeData(
        //   scaffoldBackgroundColor: kBackgroundColor,
        //   primaryColor: kPrimaryColor,
        //   textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        //   visualDensity: VisualDensity.adaptivePlatformDensity,
        // ),
        home: Wrapper(),
      ),
    );
  }
}
