class BankInfomation {
  final int bankId;
  final String bankCode;
  final String bankNumber;
  final String secretKey;
  final String bankName;
  final int isUse;

  BankInfomation({
    required this.bankId,
    required this.bankCode,
    required this.bankNumber,
    required this.secretKey,
    required this.bankName,
    required this.isUse
  });

  factory BankInfomation.fromJson(Map<String, dynamic> json) {
    return BankInfomation(
      bankId: json['Bank_id'] as int,
      bankCode: json['Bank_code'] as String,
      bankNumber: json['Bank_number'] as String,
      secretKey: json['Secret_key'] as String,
      bankName: json['Bank_name'] as String,
      isUse: json['Is_use'] as int
    );
  }
}
