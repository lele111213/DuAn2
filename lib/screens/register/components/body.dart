import 'package:app_menh_ly/models/user.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _userName = "";
  DateTime _birthDay = new DateTime.now();
  final DateTime now = new DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(1960),
        lastDate: DateTime(2022));
    if (pickedDate != null && pickedDate != now)
      setState(() {
        _birthDay = pickedDate;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Column(
        children: [
          Text(_birthDay.toString()),
          ElevatedButton(
              onPressed: () => _selectDate(context), child: Text('Chọn ngày')),
          ElevatedButton(
            onPressed: () {
              User user = new User(userName: 'Văn Sửu', birthDay: _birthDay);
              user.login();
            },
            child: Text('Click Here!'),
          ),
        ],
      ),
    );
  }
}

// class Body extends StatelessWidget {
//   const Body({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     String _userName;
//     DateTime _birthDay;
//     final DateTime now = new DateTime.now();
//     Future<void> _selectDate(BuildContext context) async {
//       final DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate: now,
//           firstDate: DateTime(1960),
//           lastDate: DateTime(2022));
//       if (pickedDate != null && pickedDate != now)
//         setState(() {
//           _birthDay = pickedDate;
//         });
//     }

//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//       child: Column(
//         children: [
//           InputDatePickerFormField(
//               firstDate: DateTime.now(), lastDate: DateTime.now()),
//           ElevatedButton(
//             onPressed: () {
//               User user = new User(
//                   userName: 'Văn Sửu', birthDay: DateTime(1977, 1, 11));
//               user.login();
//             },
//             child: Text('Click Here!'),
//           ),
//         ],
//       ),
//     );
//   }
// }
