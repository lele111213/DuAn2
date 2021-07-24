// Hành trình ngắn ngày
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TabNhatMenh extends StatelessWidget {
  const TabNhatMenh({
    Key? key,
    required this.title,
    required this.percent,
    required this.vanDe,
    required this.hoaGiai,
  }) : super(key: key);
  final String title;
  final String vanDe;
  final String hoaGiai;
  final int percent;
  Widget buildHeader({required String header}) => Text(
        header.toUpperCase(),
        style: TextStyle(color: Colors.green, height: 1.6),
        textScaleFactor: 1.2,
      );
  Widget buildText({required String text}) => Text(
        text,
        style: TextStyle(color: Colors.white, height: 1.5),
      );
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.white),
                    textScaleFactor: 1.3,
                  ),
                  SizedBox(height: 10),
                  CircularPercentIndicator(
                    radius: 60,
                    percent: percent / 100,
                    progressColor: Colors.red,
                    center: Text(
                      '$percent%',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            buildHeader(header: 'Vấn Đề'),
            buildText(text: vanDe),
            buildHeader(header: 'Hóa giải'),
            buildText(text: hoaGiai),
          ],
        ),
      ),
    );
  }
}
