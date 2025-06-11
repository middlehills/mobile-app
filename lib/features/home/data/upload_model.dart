import 'package:hive/hive.dart';

part 'upload_model.g.dart';

@HiveType(typeId: 1)
class UploadModel extends HiveObject {
  @HiveField(0)
  String itemName;

  @HiveField(1)
  String quantity;

  @HiveField(2)
  int amount;

  @HiveField(3)
  DateTime createdAt;

  UploadModel({
    required this.itemName,
    required this.quantity,
    required this.amount,
    required this.createdAt,
  });

  factory UploadModel.fromJson(Map<String, dynamic> json) => UploadModel(
        itemName: json["item_name"],
        quantity: json["quantity"],
        amount: json["amount"],
        // parse ISO8601 string:
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "item_name": itemName,
        "quantity": quantity,
        "amount": amount,
        // "createdAt": createdAt.toIso8601String(),
      };
}
