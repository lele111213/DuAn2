import 'package:app_menh_ly/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'get_date_range_screen.dart';

class GetInfo extends StatefulWidget {
  const GetInfo({Key? key, required this.selected}) : super(key: key);
  final int selected;
  @override
  _GetInfoState createState() => _GetInfoState(selected);
}

class _GetInfoState extends State<GetInfo> {
  _GetInfoState(this.selected);
  final int selected;
  bool isChecked = false;
  int _gender = 0;
  // ignore: avoid_init_to_null
  dynamic _ngaySinh = null;
  String _gioSinh = '';
  int _valueIndex = 0;
  static List<String> _values = [
    '1-3',
    '4-6',
    '7-9',
    '10-12',
    '13-15',
    '16-18',
    '19-21',
    '22-24',
  ];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context)!;
// chọn giới tính
    List<Widget> buildGender({required int gender}) {
      int gender1 = 0;
      int gender2 = 0;
      if (isChecked) {
        if (_gender == 0) {
          _gender = gender;
          gender1 = 1;
          gender2 = 2;
        } else {
          gender1 = gender;
          gender2 = gender == 1 ? 2 : 1;
        }
        return [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: (_gender == gender1) ? Colors.blue : Colors.transparent,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(50),
            ),
            width: 50,
            height: 50,
            child: IconButton(
              // 1: nam, 2: nu
              icon: Icon(gender1 == 1 ? Icons.male : Icons.female,
                  color: Colors.white),
              onPressed: isChecked
                  ? () {
                      setState(() {
                        _gender = gender1;
                      });
                    }
                  : null,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: (_gender == gender2) ? Colors.blue : Colors.transparent,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(50),
            ),
            width: 50,
            height: 50,
            child: IconButton(
              // 1: nam, 2: nu
              icon: Icon(gender2 == 1 ? Icons.male : Icons.female,
                  color: Colors.white),
              onPressed: isChecked
                  ? () {
                      setState(() {
                        _gender = gender2;
                      });
                    }
                  : null,
            ),
          ),
        ];
      } else {
        if (_gender == 0) {
          _gender = gender;
        }
        gender1 = _gender;
        return [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(50),
            ),
            width: 50,
            height: 50,
            child: IconButton(
              // 1: nam, 2: nu
              icon: Icon(gender1 == 1 ? Icons.male : Icons.female,
                  color: Colors.white),
              onPressed: isChecked
                  ? () {
                      setState(() {
                        _gender = gender1;
                      });
                    }
                  : null,
            ),
          ),
        ];
      }
    }

    // Chọn ngày sinh
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: _ngaySinh != null ? _ngaySinh : DateTime.now(),
          firstDate: DateTime(1960),
          lastDate: DateTime(2022));
      if (pickedDate != null)
        setState(() {
          _ngaySinh = pickedDate;
        });
    }

    // chọn giờ sinh
    List<Widget> modelBuilder<String>(List<String> models,
            Widget Function(int index, String model) builder) =>
        models
            .asMap()
            .map<int, Widget>(
                (index, model) => MapEntry(index, builder(index, model)))
            .values
            .toList();
    Widget builTimePicker() => SizedBox(
          height: 200,
          child: CupertinoPicker(
            itemExtent: 50,
            scrollController:
                FixedExtentScrollController(initialItem: _valueIndex),
            children: modelBuilder<String>(
              _values,
              (index, value) {
                return Center(
                  child: Text(value),
                );
              },
            ),
            onSelectedItemChanged: (index) {
              _valueIndex = index;
            },
          ),
        );

    void showSheet(BuildContext context,
            {required Widget child, required VoidCallback onClicked}) =>
        {
          showCupertinoModalPopup(
            context: context,
            builder: (context) => CupertinoActionSheet(
              actions: [
                child,
              ],
              cancelButton: CupertinoActionSheetAction(
                child: Text('Xác Nhận'),
                onPressed: onClicked,
              ),
            ),
          ),
        };
// build
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/back-ground.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 45,
          title: Text(
            'Trạch Nhật',
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Text(
                  'Thông tin của bạn',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      side: BorderSide(color: Colors.white, width: 1.5),
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Text(
                      'Thay đổi',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                SizedBox(height: 25),
                Text(
                  'GIỚI TÍNH',
                  style: TextStyle(color: Colors.white),
                  textScaleFactor: 1.3,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: buildGender(gender: user.gender),
                ),
                SizedBox(height: 30),
                Text('NGÀY SINH DƯƠNG LỊCH',
                    style: TextStyle(color: Colors.white, height: 1),
                    textScaleFactor: 1.4),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isChecked
                        ? () {
                            _selectDate(context);
                          }
                        : null,
                    child: Row(
                      children: [
                        Spacer(),
                        Text(
                          DateFormat('dd/MM/yyyy').format(_ngaySinh != null
                              ? _ngaySinh
                              : _ngaySinh = user.birthDay),
                          textScaleFactor: 1.4,
                          style: TextStyle(color: Colors.white),
                        ),
                        Spacer(),
                        if (isChecked)
                          Icon(Icons.calendar_today, color: Colors.white),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.grey.withOpacity(0.2)),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Text('GIỜ SINH',
                    style: TextStyle(color: Colors.white, height: 1),
                    textScaleFactor: 1.4),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isChecked
                        ? () {
                            showSheet(
                              context,
                              child: builTimePicker(),
                              onClicked: () {
                                Navigator.pop(context);
                                setState(() {
                                  _gioSinh = _values[_valueIndex];
                                });
                              },
                            );
                          }
                        : null,
                    child: Row(
                      children: [
                        Spacer(),
                        Text(
                          _gioSinh,
                          textScaleFactor: 1.4,
                          style: TextStyle(color: Colors.white),
                        ),
                        Spacer(),
                        if (isChecked) Icon(Icons.timer, color: Colors.white),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.grey.withOpacity(0.2)),
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GetDateRange(
                            selected: selected,
                            gender: _gender,
                            ngaySinh: _ngaySinh,
                            gioSinh: _gioSinh,
                          ),
                        ),
                      );
                    },
                    child: Text('Tiếp Tục'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
