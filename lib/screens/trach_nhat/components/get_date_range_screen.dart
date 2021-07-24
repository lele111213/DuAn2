import 'package:app_menh_ly/screens/trach_nhat/components/trach_nhat_ket_qua_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GetDateRange extends StatefulWidget {
  const GetDateRange(
      {Key? key,
      required this.selected,
      required this.gender,
      required this.ngaySinh,
      required this.gioSinh})
      : super(key: key);
  final int selected;
  final int gender;
  final dynamic ngaySinh;
  final String gioSinh;
  @override
  _GetDateRangeState createState() => _GetDateRangeState(
      gender: gender, ngaySinh: ngaySinh, gioSinh: gioSinh, selected: selected);
}

class _GetDateRangeState extends State<GetDateRange> {
  _GetDateRangeState(
      {required this.gender,
      required this.ngaySinh,
      required this.gioSinh,
      required this.selected});
  final int selected;
  final int gender;
  final dynamic ngaySinh;
  final String gioSinh;
  DateTime now = new DateTime.now();
  // ignore: avoid_init_to_null
  dynamic dateRange = null;

  @override
  Widget build(BuildContext context) {
    Future<void> _selectDate(BuildContext context) async {
      final newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(now.year, now.month),
        lastDate: DateTime(now.year + 1),
        initialDateRange: dateRange,
      );
      if (newDateRange != null)
        setState(() {
          dateRange = newDateRange;
        });
    }

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Chọn khoảng thời gian bạn dự định thực hiện',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Từ ngày\n${dateRange != null ? '${DateFormat('dd/MM/yyyy').format(dateRange.start)}' : '__/__/____'}',
                    style: TextStyle(color: Colors.white),
                    textScaleFactor: 1.2,
                  ),
                  Text(
                    'Đến ngày\n${dateRange != null ? '${DateFormat('dd/MM/yyyy').format(dateRange.end)}' : '__/__/____'}',
                    style: TextStyle(color: Colors.white),
                    textScaleFactor: 1.2,
                  ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Text('Chọn ngày'),
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
                  onPressed: dateRange != null
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TrachNhatKetQua(
                                selected: selected,
                                gender: gender,
                                ngaySinh: ngaySinh,
                                gioSinh: gioSinh,
                                dateRange: dateRange,
                              ),
                            ),
                          );
                        }
                      : null,
                  child: Text('Tiếp Tục'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        dateRange != null ? Colors.green : Colors.grey),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
