class PayResponse {
  final int status;
  final String message;
  final String? transid;
  final int? amount;
  final String? signature;

  PayResponse({
    required this.status,
    required this.message,
    required this.transid,
    required this.amount,
    required this.signature,
  });

  factory PayResponse.fromJson(Map<String, dynamic> json) {
    return PayResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      transid: json['transid'] as String?,
      amount: json['amount'] as int?,
      signature: json['signature'] as String?,
    );
  }
}
