import 'dart:convert';
import 'package:app_menh_ly/screens/nap_xu/components/models/momo/pay_response.dart';
import 'package:app_menh_ly/screens/nap_xu/components/utils/endpoints.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:sprintf/sprintf.dart';

class MomoPayConfig {
  static String merchantName = "MOMO payment test";
  static String merchantCode = "MOMONCUJ20210804";
  static double version = 2.0;
  static int payType = 3;
  static String publicKey =
      "-----BEGIN PUBLIC KEY-----MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAqjEUTzmutoTSCzG5/Yg3fkPeKa23AJV9AorzFB8NfCbWabsqoJc+c9QzmBt3G9dexlUirXxy/CbfAEM0k+VcDyQvOhhrGqec4+KEaF4pWGzEqD+pLhqmvt2jNg/uTyyNgHK7iniUDZp2KKlsXVf+jgXFwss8ddnwlhJidhyY8XE+cVQ/lDoaXqgSn17Wx55ats1Tq0iNG5MUlz4CmoDN4Vi80yFuufBcSdO05WzUH0ZYEE6cDdkBdY1O1H3ryWL+KyC4tE0qZu+XiXmELdg8o+64n1hOp0fLCYg8Ni/Zd5sFM/EtsCuVl2wOccg1PKtNBwAon+5tH/cBLQ3bqwmGhNY1awPggmqKKQCUZYdnAEFzFU1ijsIgtnmYFEU+9LCorQVfCV2XgcGZ1pf44nyX8g38K2nrNGw3ukCb2DWJ15UmdVS2j7qhOBNWrb/b5tyI2YhSGOiV7DoZEo+YAKCa+t0N8xhe7Not26IgX6ProDlNEpJaH763TcoH5HnJExWdGl5/MaNUKQSVb7R4yMxTwXIXyPzyQ4bfNbxPEzvPQH5t+Pziuws1EN6E3oig/15RbQXgcMlxBkWDZEIEThbaLX+JphKZ9tzC6T6oX5o6Qr6uKgqNhRXOUigxeZxEMBv4c5EtlGTJmeLMQAimtklZ4rr1n18+UpcdcoTeUPA+q1MCAwEAAQ==-----END PUBLIC KEY-----";
  static String secretKey = "KDbueVZray9IZpODOLJvsx7XFDcyNmZ4";
}

Future<PayResponse?> sendPayRequest(
    {required String customerNumber,
    required String appData,
    required String partnerRefId,
    required int amount,
    required String requestId}) async {
  // RsaKeyHelper rsaHelper = new RsaKeyHelper();
  var header = new Map<String, String>();
  header["Content-Type"] = "application/json; charset=UTF-8";

  var body = new Map<String, dynamic>();
  body["partnerCode"] = MomoPayConfig.merchantCode;
  body["partnerRefId"] = partnerRefId;
  body["customerNumber"] = customerNumber;
  body["appData"] = appData;
  body["version"] = MomoPayConfig.version;
  body["payType"] = MomoPayConfig.payType;
  body["description"] = "";
  body["extra_data"] = "";

  Map<String, dynamic> obj = {
    "partnerCode": MomoPayConfig.merchantCode,
    "partnerRefId": partnerRefId,
    "amount": amount,
    "partnerName": MomoPayConfig.merchantName
  };
  //
  // get hash from sv nhaibauxx@pythonanywhere.com
  //
  var url = Uri.parse(Endpoints.getHashUrl);
  http.Response response = await http.post(
    url,
    headers: header,
    body: jsonEncode(obj),
  );
  if (response.statusCode != 200 && jsonDecode(response.body)['status'] != 0) {
    print("lỗi get hash từ server nhaibauxx.pythonanywhere.com");
    return null;
  }
  var data = jsonDecode(response.body);
  print(data["hash"]);
  body["hash"] = data["hash"];
  //
  // send pay request
  //
  var urlMm = Uri.parse(Endpoints.apiEndpoinUrl);
  http.Response responseFromMomo = await http.post(
    urlMm,
    headers: header,
    body: jsonEncode(body),
  );

  print("pay-body_request: $body");
  if (responseFromMomo.statusCode != 200) {
    print("Lỗi send xử lý thanh toán.");
    return null;
  }
  var dataFMM = jsonDecode(responseFromMomo.body);
  print("pay-data_response: $dataFMM}");
  //
  // send confirm
  //
  Map<String, dynamic> bodyConfirm = {
    "partnerCode": MomoPayConfig.merchantCode,
    "partnerRefId": partnerRefId,
    "requestType": "capture",
    "requestId": requestId,
    "momoTransId": dataFMM["transid"],
    "customerNumber": customerNumber
  };
  // build signature sha256
  String rawSignature = sprintf(
      "partnerCode=%s&partnerRefId=%s&requestType=%s&requestId=%s&momoTransId=%s",
      [
        MomoPayConfig.merchantCode,
        partnerRefId,
        "capture",
        requestId,
        dataFMM["transid"]
      ]);
  print("rawSignature:: $rawSignature");
  var signature = new Hmac(sha256, utf8.encode(MomoPayConfig.secretKey));
  // add signature vào bodyConfirm
  bodyConfirm["signature"] =
      signature.convert(utf8.encode(rawSignature)).toString();
  print("confirm-body_request: $bodyConfirm");
  //
  // send request confirm
  //
  var urlConfirm = Uri.parse(Endpoints.apiConfirmdUrl);
  http.Response responseConfirm = await http.post(
    urlConfirm,
    headers: header,
    body: jsonEncode(bodyConfirm),
  );
  if (responseConfirm.statusCode != 200) {
    print("Lỗi confirm.");
    return null;
  }
  var dataConfirm = jsonDecode(responseConfirm.body);
  print("confirm-data_response: $dataConfirm}");
  //
  //return
  //
  return PayResponse.fromJson(dataFMM);
}
