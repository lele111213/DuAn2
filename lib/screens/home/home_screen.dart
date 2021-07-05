import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/body.dart';
import 'package:app_menh_ly/models/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
      body: Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          user!.logout();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
