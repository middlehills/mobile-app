// To parse this JSON data, do
//
//     final uploadModel = uploadModelFromJson(jsonString);

import 'dart:convert';

UploadModel uploadModelFromJson(String str) =>
    UploadModel.fromJson(json.decode(str));

String uploadModelToJson(UploadModel data) => json.encode(data.toJson());

class UploadModel {
  String itemName;
  String quantity;
  int amount;
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
      createdAt: json["createdAt"]);

  Map<String, dynamic> toJson() => {
        "item_name": itemName,
        "quantity": quantity,
        "amount": amount,
        // "createdAt": createdAt,
      };
}
