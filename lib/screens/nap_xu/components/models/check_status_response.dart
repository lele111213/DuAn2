class CheckStatusResponse {
  final int returncode;
  final String returnmessage;
  final int subreturncode;
  final String subreturnmessage;
  final bool? isprocessing;
  final int? amount;
  final int? zptransid;

  CheckStatusResponse({
    required this.returncode,
    required this.returnmessage,
    required this.subreturncode,
    required this.subreturnmessage,
    required this.isprocessing,
    required this.amount,
    required this.zptransid,
  });

  factory CheckStatusResponse.fromJson(Map<String, dynamic> json) {
    return CheckStatusResponse(
      returncode: json['return_code'] as int,
      returnmessage: json['return_message'] as String,
      subreturncode: json['sub_return_code'] as int,
      subreturnmessage: json['sub_return_message'] as String,
      isprocessing: json['is_processing'] as bool,
      amount: json['amount'] as int,
      zptransid: json["zp_trans_id"] as int,
    );
  }
}
