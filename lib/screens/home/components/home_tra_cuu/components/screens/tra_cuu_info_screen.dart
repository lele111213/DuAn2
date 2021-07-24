import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'tra_cuu_ket_qua_screen.dart';

class TraCuuInfo extends StatefulWidget {
  const TraCuuInfo({Key? key, required this.selected}) : super(key: key);
  final int selected;
  @override
  _TraCuuInfoState createState() => _TraCuuInfoState(selected);
}

class _TraCuuInfoState extends State<TraCuuInfo> {
  _TraCuuInfoState(this.selected);
  final int selected;
  int _gender = 0;
  // ignore: avoid_init_to_null
  DateTime _ngaySinh = DateTime(1990);
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
  static const Map<int, String> selects = {
    1: 'Tra Cát Nhân',
    2: 'Tra Đào Hoa',
    3: 'Tra Mệnh Thần',
    4: 'Tra Quý Nhân',
    5: 'Sim Ứng Mệnh',
  };
  @override
  Widget build(BuildContext context) {
// chọn giới tính
    List<Widget> buildGender() {
      return [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: (_gender == 1) ? Colors.blue : Colors.transparent,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(50),
          ),
          width: 50,
          height: 50,
          child: IconButton(
              icon: Icon(Icons.male, color: Colors.white),
              onPressed: () {
                setState(() {
                  _gender = 1;
                });
              }),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: (_gender == 2) ? Colors.blue : Colors.transparent,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(50),
          ),
          width: 50,
          height: 50,
          child: IconButton(
              icon: Icon(Icons.female, color: Colors.white),
              onPressed: () {
                setState(() {
                  _gender = 2;
                });
              }),
        ),
      ];
    }

// Chọn ngày sinh
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: _ngaySinh,
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
            selects[selected]!,
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
                  'Thông tin của đối phương',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 15),
                SizedBox(height: 25),
                Text(
                  'GIỚI TÍNH',
                  style: TextStyle(color: Colors.white),
                  textScaleFactor: 1.3,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: buildGender(),
                ),
                SizedBox(height: 30),
                Text('NGÀY SINH DƯƠNG LỊCH',
                    style: TextStyle(color: Colors.white, height: 1),
                    textScaleFactor: 1.4),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Row(
                      children: [
                        Spacer(),
                        Text(
                          DateFormat('dd/MM/yyyy').format(_ngaySinh),
                          textScaleFactor: 1.4,
                          style: TextStyle(color: Colors.white),
                        ),
                        Spacer(),
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
                    onPressed: () {
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
                    },
                    child: Row(
                      children: [
                        Spacer(),
                        Text(
                          _gioSinh,
                          textScaleFactor: 1.4,
                          style: TextStyle(color: Colors.white),
                        ),
                        Spacer(),
                        Icon(Icons.timer, color: Colors.white),
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
                    onPressed: _gender != 0
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TraCuuKetQua(
                                  gender: _gender,
                                  gioSinh: _gioSinh,
                                  ngaySinh: _ngaySinh,
                                  selected: selected,
                                ),
                              ),
                            );
                          }
                        : null,
                    child: Text('Tiếp Tục'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          _gender != 0 ? Colors.green : Colors.grey),
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
