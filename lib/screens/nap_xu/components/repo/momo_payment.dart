import 'dart:convert';
import 'package:rsa_encrypt/rsa_encrypt.dart';
import 'package:app_menh_ly/screens/nap_xu/components/models/momo/pay_response.dart';
import 'package:app_menh_ly/screens/nap_xu/components/utils/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:pointycastle/asymmetric/api.dart';

class MomoPayConfig {
  static String merchantName = "MOMO payment test";
  static String merchantCode = "MOMONCUJ20210804";
  static double version = 2.0;
  static int payType = 3;
  static String publicKey =
      "-----BEGIN PUBLIC KEY-----MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAqjEUTzmutoTSCzG5/Yg3fkPeKa23AJV9AorzFB8NfCbWabsqoJc+c9QzmBt3G9dexlUirXxy/CbfAEM0k+VcDyQvOhhrGqec4+KEaF4pWGzEqD+pLhqmvt2jNg/uTyyNgHK7iniUDZp2KKlsXVf+jgXFwss8ddnwlhJidhyY8XE+cVQ/lDoaXqgSn17Wx55ats1Tq0iNG5MUlz4CmoDN4Vi80yFuufBcSdO05WzUH0ZYEE6cDdkBdY1O1H3ryWL+KyC4tE0qZu+XiXmELdg8o+64n1hOp0fLCYg8Ni/Zd5sFM/EtsCuVl2wOccg1PKtNBwAon+5tH/cBLQ3bqwmGhNY1awPggmqKKQCUZYdnAEFzFU1ijsIgtnmYFEU+9LCorQVfCV2XgcGZ1pf44nyX8g38K2nrNGw3ukCb2DWJ15UmdVS2j7qhOBNWrb/b5tyI2YhSGOiV7DoZEo+YAKCa+t0N8xhe7Not26IgX6ProDlNEpJaH763TcoH5HnJExWdGl5/MaNUKQSVb7R4yMxTwXIXyPzyQ4bfNbxPEzvPQH5t+Pziuws1EN6E3oig/15RbQXgcMlxBkWDZEIEThbaLX+JphKZ9tzC6T6oX5o6Qr6uKgqNhRXOUigxeZxEMBv4c5EtlGTJmeLMQAimtklZ4rr1n18+UpcdcoTeUPA+q1MCAwEAAQ==-----END PUBLIC KEY-----";
}

Future<PayResponse?> sendPayRequest({
  required String customerNumber,
  required String appData,
  required String partnerRefId,
  required int amount,
}) async {
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

  var url = Uri.parse(Endpoints.getHashUrl);
  http.Response response = await http.post(
    url,
    headers: header,
    body: jsonEncode(obj),
  );
  if (response.statusCode != 200) {
    return null;
  }
  var data = jsonDecode(response.body);
  print(data["hash"]);
  body["hash"] = data["hash"];
  var urlMm = Uri.parse(Endpoints.apiEndpoinUrl);
  http.Response responseFromMomo = await http.post(
    urlMm,
    headers: header,
    body: jsonEncode(body),
  );

  print("body_request: $body");
  if (responseFromMomo.statusCode != 200) {
    return null;
  }
  data = jsonDecode(responseFromMomo.body);
  print("data_response: $data}");
  return PayResponse.fromJson(data);
}
