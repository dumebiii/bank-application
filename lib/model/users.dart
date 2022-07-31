class Users {
  Users({
    required this.phoneNumber,
    required this.balance,
    required this.created,
  });

  final String? phoneNumber;
  final dynamic balance;
  final DateTime? created;

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      phoneNumber: json["phoneNumber"],
      balance: json["balance"],
      created: json["created"] == null ? null : DateTime.parse(json["created"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "balance": balance,
        "created": created?.toIso8601String(),
      };
}
