import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/features/home/data/upload_model.dart';

class UploadProvider extends ChangeNotifier {
  List<UploadModel> uploads = [];

  void createRecord({
    required String name,
    required String quantity,
    required int amount,
  }) {
    // create record
    final thisRecord = UploadModel(
      itemName: name,
      quantity: quantity,
      amount: amount,
      createdAt: DateTime.now(),
    );

    // delete record
    uploads.add(thisRecord);

    notifyListeners();
  }

  void deleteRecord({
    required DateTime createdAt,
  }) {
    uploads.removeWhere((upload) {
      return upload.createdAt == createdAt;
    });

    notifyListeners();
  }

  void clearRecords() {
    uploads.clear();

    notifyListeners();
  }

  bool isAddingNewRecord = false;

  setAddingNewRecordState(bool value) {
    isAddingNewRecord = value;
    notifyListeners();
  }
}
