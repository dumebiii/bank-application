class Transaction {
  Transaction({
    required this.type,
    required this.amount,
    required this.balance,
    required this.phoneNumber,
    required this.created,
  });

  final String? type;
  final dynamic amount;
  final dynamic balance;
  final String? phoneNumber;
  final DateTime? created;

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      type: json["type"],
      amount: json["amount"],
      balance: json["balance"],
      phoneNumber: json["phoneNumber"],
      created: json["created"] == null ? null : DateTime.parse(json["created"]),
    );
  }
}
