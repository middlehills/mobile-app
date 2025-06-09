import 'dart:convert';

class Transaction {
  String id;
  String userId;
  String itemName;
  String quantity;
  int amount;
  bool deleted;
  DateTime createdAt;
  DateTime updatedAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.itemName,
    required this.quantity,
    required this.amount,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromRawJson(String str) =>
      Transaction.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        userId: json["user_id"],
        itemName: json["item_name"],
        quantity: json["quantity"],
        amount: json["amount"],
        deleted: json["deleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "item_name": itemName,
        "quantity": quantity,
        "amount": amount,
        "deleted": deleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
