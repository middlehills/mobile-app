class Record {
  final String id;
  final String userId;
  final String itemName;
  final String quantity;
  final int amount;
  final bool deleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  Record({
    required this.id,
    required this.userId,
    required this.itemName,
    required this.quantity,
    required this.amount,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      id: json['id'],
      userId: json['user_id'],
      itemName: json['item_name'],
      quantity: json['quantity'],
      amount: json['amount'],
      deleted: json['deleted'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'item_name': itemName,
      'quantity': quantity,
      'amount': amount,
      'deleted': deleted,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

List<Record> dummyRecords = [
  Record(
      id: "051c3b1c-dd48-437b-ab08-a9868420ab29",
      userId: "d0599d51-25e6-401c-b077-c567813c9220",
      itemName: "Rice in dericas",
      quantity: "2",
      amount: 500,
      deleted: false,
      createdAt: DateTime.parse("2025-04-25T23:27:55.864Z"),
      updatedAt: DateTime.parse("2025-04-25T23:27:55.864Z")),
  Record(
      id: "e7a3b29f-ce58-49a1-b3d7-8d72f1cba4e5",
      userId: "d0599d51-25e6-401c-b077-c567813c9220",
      itemName: "Beans in kg",
      quantity: "1.5",
      amount: 320,
      deleted: false,
      createdAt: DateTime.parse("2025-04-26T10:15:22.347Z"),
      updatedAt: DateTime.parse("2025-04-26T10:15:22.347Z")),
  Record(
      id: "c8f91e2d-a678-4e87-b351-5f98a0dc31b7",
      userId: "d0599d51-25e6-401c-b077-c567813c9220",
      itemName: "Tomatoes pieces",
      quantity: "6",
      amount: 150,
      deleted: false,
      createdAt: DateTime.parse("2025-04-26T14:32:10.129Z"),
      updatedAt: DateTime.parse("2025-04-26T14:32:10.129Z")),
  Record(
      id: "4d7f2e5b-9a12-4c36-8e74-b093a6f8d9c1",
      userId: "d0599d51-25e6-401c-b077-c567813c9220",
      itemName: "Cooking oil in liters",
      quantity: "2",
      amount: 850,
      deleted: false,
      createdAt: DateTime.parse("2025-04-27T08:45:33.612Z"),
      updatedAt: DateTime.parse("2025-04-27T08:45:33.612Z")),
  Record(
      id: "9b3a7c1d-5e8f-4b2a-9d6c-0f4e2a1b3c5d",
      userId: "d0599d51-25e6-401c-b077-c567813c9220",
      itemName: "Sugar in kg",
      quantity: "3",
      amount: 450,
      deleted: false,
      createdAt: DateTime.parse("2025-04-27T11:20:15.789Z"),
      updatedAt: DateTime.parse("2025-04-27T11:20:15.789Z")),
  Record(
      id: "2e5f8a1d-7c3b-49e6-b0a5-d2c9f7e3a1b8",
      userId: "d0599d51-25e6-401c-b077-c567813c9220",
      itemName: "Milk packets",
      quantity: "5",
      amount: 375,
      deleted: false,
      createdAt: DateTime.parse("2025-04-28T09:05:42.513Z"),
      updatedAt: DateTime.parse("2025-04-28T09:05:42.513Z")),
  Record(
      id: "f1e2d3c4-b5a6-4789-9876-5432a1b2c3d4",
      userId: "d0599d51-25e6-401c-b077-c567813c9220",
      itemName: "Bread loaves",
      quantity: "2",
      amount: 180,
      deleted: false,
      createdAt: DateTime.parse("2025-04-28T15:40:18.236Z"),
      updatedAt: DateTime.parse("2025-04-28T15:40:18.236Z")),
  Record(
      id: "a1b2c3d4-e5f6-7890-a1b2-c3d4e5f67890",
      userId: "d0599d51-25e6-401c-b077-c567813c9220",
      itemName: "Chicken in kg",
      quantity: "1.5",
      amount: 950,
      deleted: false,
      createdAt: DateTime.parse("2025-04-29T12:33:27.654Z"),
      updatedAt: DateTime.parse("2025-04-29T12:33:27.654Z")),
  Record(
      id: "7f8e9d6c-5b4a-3210-f9e8-d7c6b5a43210",
      userId: "d0599d51-25e6-401c-b077-c567813c9220",
      itemName: "Onions in kg",
      quantity: "1",
      amount: 120,
      deleted: false,
      createdAt: DateTime.parse("2025-04-29T16:18:39.425Z"),
      updatedAt: DateTime.parse("2025-04-29T16:18:39.425Z")),
  Record(
      id: "3e4d5c6b-7a8b-9c0d-1e2f-3a4b5c6d7e8f",
      userId: "d0599d51-25e6-401c-b077-c567813c9220",
      itemName: "Potatoes in kg",
      quantity: "3",
      amount: 280,
      deleted: false,
      createdAt: DateTime.parse("2025-04-30T10:52:14.789Z"),
      updatedAt: DateTime.parse("2025-04-30T10:52:14.789Z")),
  Record(
      id: "5a4b3c2d-1e0f-9a8b-7c6d-5e4f3a2b1c0d",
      userId: "d0599d51-25e6-401c-b077-c567813c9220",
      itemName: "Pepper in grams",
      quantity: "500",
      amount: 200,
      deleted: true,
      createdAt: DateTime.parse("2025-04-30T14:27:33.612Z"),
      updatedAt: DateTime.parse("2025-05-01T09:15:42.753Z")),
  Record(
      id: "1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d",
      userId: "d0599d51-25e6-401c-b077-c567813c9220",
      itemName: "Salt packets",
      quantity: "1",
      amount: 70,
      deleted: false,
      createdAt: DateTime.parse("2025-05-01T11:08:27.345Z"),
      updatedAt: DateTime.parse("2025-05-01T11:08:27.345Z")),
  Record(
      id: "9c8b7a6d-5e4f-3c2b-1a0d-9e8f7c6b5a4e",
      userId: "d0599d51-25e6-401c-b077-c567813c9220",
      itemName: "Eggs crate",
      quantity: "1",
      amount: 420,
      deleted: false,
      createdAt: DateTime.parse("2025-05-01T17:42:51.927Z"),
      updatedAt: DateTime.parse("2025-05-01T17:42:51.927Z")),
  Record(
      id: "4b5c6d7e-8f9a-0b1c-2d3e-4f5a6b7c8d9e",
      userId: "d0599d51-25e6-401c-b077-c567813c9220",
      itemName: "Flour in kg",
      quantity: "2",
      amount: 350,
      deleted: false,
      createdAt: DateTime.parse("2025-05-02T08:30:16.428Z"),
      updatedAt: DateTime.parse("2025-05-02T08:30:16.428Z"))
];
