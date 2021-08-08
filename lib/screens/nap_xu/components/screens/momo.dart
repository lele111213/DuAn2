import 'dart:convert';
import 'dart:io';
import 'package:app_menh_ly/models/user.dart';
import 'package:app_menh_ly/screens/nap_xu/components/repo/momo_payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/theme_data.dart';
import 'package:flutter/services.dart';
import 'package:pausable_timer/pausable_timer.dart';

class Momo extends StatefulWidget {
  @override
  _MomoState createState() => _MomoState();
}

class _MomoState extends State<Momo> {
  static const EventChannel eventChannel =
      EventChannel('flutter.native/eventRequestPayment');
  static const MethodChannel platform =
      MethodChannel('flutter.native/channelRequestPayment');
  final textStyle = TextStyle(color: Colors.black54);
  final valueStyle = TextStyle(
      color: AppColor.accentColor, fontSize: 18.0, fontWeight: FontWeight.w400);
  String payResult = "";
  String payAmount = "10000";
  dynamic orderResponse = "null";
  PausableTimer? timer;
  User? user;
  bool getOrderResponse = true;
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
    }
    timer = PausableTimer(new Duration(seconds: 5), () async {
      String message = "";
      orderResponse = await platform.invokeMethod('getResult');
      print('timer:: $orderResponse');
      if (orderResponse != "null") {
        timer!.pause();
        orderResponse = jsonDecode(orderResponse);
        message = orderResponse['message'];
        // SEND REQUEST THAY SERVER ĐỂ XÁC NHẬN THANH TOÁN.
        if (orderResponse['status'] == 0) {
          var result = await sendPayRequest(
            customerNumber: orderResponse['phonenumber'],
            appData: orderResponse['token'],
            partnerRefId: orderResponse['orderId'],
            amount: orderResponse['amount'],
            requestId: orderResponse['requestId'],
          );
          if (result != null && result.status == 0) {
            print(result.status.toString() + "-" + result.message);
            message += ' +${orderResponse['amount'] ?? ""}';
            if (user != null) {
              user!.addCoin(orderResponse['amount'] ?? 0);
              // lưu user
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('user', jsonEncode(user!.toJson()));
            }
            print(user!.userName);
          } else {
            message = "Có lỗi xảy ra.";
          }
        }
        // remove circularProgress line 93
        Navigator.pop(context);

        setState(() {
          payResult = message;
        });
      }
      timer!.reset();
      timer!.start();
    });
    timer!.start();
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer!.cancel();
    }
  }

  void _onEvent(dynamic event) {
    print("_onEvent: '$event'.");
    var res = Map<String, dynamic>.from(event);
    setState(() {
      if (res["errorCode"] == 1) {
        payResult = "Thanh toán thành công";
      } else if (res["errorCode"] == 4) {
        payResult = "User hủy thanh toán";
      } else {
        payResult = "Giao dịch thất bại";
      }
    });
  }

  void _onError(Object error) {
    print("_onError: '$error'.");
    setState(() {
      payResult = "Giao dịch thất bại";
    });
  }

  /// Build Button Pay
  Widget _btnPay(String value, User? user) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: GestureDetector(
          onTap: () async {
            String response = "";
            int amount = int.parse(value);
            if (amount < 1000 || amount > 5000000) {
              setState(() {
                response = "Invalid Amount";
              });
            } else {
              try {
                // show circularProgress
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    });
                //
                final String result = await platform
                    .invokeMethod('requestPayment', {"amount": amount});
                response = result;
                print("payOrder Result: '$result'.");
              } on PlatformException catch (e) {
                print("Failed to Invoke: '${e.message}'.");
                response = "Thanh toán thất bại";
              }
              print(response);
              setState(() {
                payResult = response;
              });
            }
          },
          child: Container(
              height: 50.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text("Pay",
                  style: TextStyle(color: Colors.white, fontSize: 20.0))),
        ),
      );

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User?>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _quickConfig,
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Amount',
            icon: Icon(Icons.attach_money),
          ),
          initialValue: payAmount,
          onChanged: (value) {
            setState(() {
              payAmount = value;
            });
          },
          keyboardType: TextInputType.number,
        ),
        _btnPay(payAmount, user),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text("Transaction status:", style: textStyle),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            payResult,
            style: valueStyle,
          ),
        ),
      ],
    );
  }
}

/// Build Info App
Widget _quickConfig = Container(
  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text("Giá trị nạp từ 1,000 đến 5,000,000"),
          ),
        ],
      ),
      // _btnQuickEdit,
    ],
  ),
);
