import 'dart:async';
import 'dart:convert';
import 'package:app_menh_ly/screens/nap_xu/components/models/check_status_response.dart';

import '../models/create_order_response.dart';
import '../utils/endpoints.dart';
import '../utils/util.dart' as utils;
import 'package:http/http.dart' as http;
import 'package:sprintf/sprintf.dart';

class ZaloPayConfig {
  static const String appId = "2554";
  static const String key1 = "sdngKKJmqEMzvh5QQcdD2A9XBSKUNaYn";
  static const String key2 = "trMrHtvjo6myautxDUiAcYsVtaeQ8nhf";

  static const String appUser = "zalopaydemo";
  static int transIdDefault = 1;
}

Future<CheckStatusResponse?> checkStatus(String appTransID) async {
  var header = new Map<String, String>();
  header["Content-Type"] = "application/x-www-form-urlencoded";

  var body = new Map<String, String>();
  body["app_id"] = ZaloPayConfig.appId;
  body["app_trans_id"] = appTransID;

  var dataGetMac = sprintf("%s|%s|%s", [
    body["app_id"],
    body["app_trans_id"],
    ZaloPayConfig.key1,
  ]);
  body["mac"] = utils.getMacCheckStatus(dataGetMac);
  print("mac check: ${body["mac"]}");

  var url = Uri.parse(Endpoints.checkStatusUrl);
  http.Response response = await http.post(
    url,
    headers: header,
    body: body,
  );
  print("body_request check: $body");
  if (response.statusCode != 200) {
    return null;
  }

  var data = jsonDecode(response.body);
  print("data_response check: $data}");
  return CheckStatusResponse.fromJson(data);
}

Future<CreateOrderResponse?> createOrder(int price) async {
  var header = new Map<String, String>();
  header["Content-Type"] = "application/x-www-form-urlencoded";

  var body = new Map<String, String>();
  body["app_id"] = ZaloPayConfig.appId;
  body["app_user"] = ZaloPayConfig.appUser;
  body["app_time"] = DateTime.now().millisecondsSinceEpoch.toString();
  body["amount"] = price.toStringAsFixed(0);
  body["app_trans_id"] = utils.getAppTransId();
  body["embed_data"] = "{}";
  // body["callback_url"] = "http://localhost:8000";
  body["item"] = "[]";
  body["bank_code"] = utils.getBankCode();
  body["description"] = utils.getDescription(body["app_trans_id"]!);

  var dataGetMac = sprintf("%s|%s|%s|%s|%s|%s|%s", [
    body["app_id"],
    body["app_trans_id"],
    body["app_user"],
    body["amount"],
    body["app_time"],
    body["embed_data"],
    body["item"]
  ]);
  body["mac"] = utils.getMacCreateOrder(dataGetMac);
  print("mac: ${body["mac"]}");

  var url = Uri.parse(Endpoints.createOrderUrl);
  http.Response response = await http.post(
    url,
    headers: header,
    body: body,
  );

  print("body_request: $body");
  if (response.statusCode != 200) {
    return null;
  }

  var data = jsonDecode(response.body);
  print("data_response: $data}");
  return CreateOrderResponse.fromJson(data);
}
