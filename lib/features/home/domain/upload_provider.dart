import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/core/data/api_response.dart';
import 'package:mid_hill_cash_flow/features/home/data/upload_model.dart';
import 'package:mid_hill_cash_flow/features/home/domain/upload_api_functions.dart';

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

  // bool isAddingNewRecord = false;

  // setAddingNewRecordState(bool value) {
  //   isAddingNewRecord = value;
  //   notifyListeners();
  // }

  bool isSavingRecordsToServer = false;

  setRecordsToServerSavingState(bool value) {
    isSavingRecordsToServer = value;
    notifyListeners();
  }

  ApiResponse? recordsToServerApiResponse;

  Future<bool> saveRecordsToServer({required String baseUrl}) async {
    setRecordsToServerSavingState(true);
    try {
      if (uploads.length == 1) {
        recordsToServerApiResponse = await UploadApiFunctions.addSingleRecord(
          baseUrl: baseUrl,
          uploadData: uploads.first,
        );
      } else {
        recordsToServerApiResponse =
            await UploadApiFunctions.addMultipleRecords(
          baseUrl: baseUrl,
          uploadDataList: uploads,
        );
      }
      setRecordsToServerSavingState(false);

      if (recordsToServerApiResponse!.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      recordsToServerApiResponse = ApiResponse(
        message: e.runtimeType.toString(),
        data: {"error": e.toString()},
        statusCode: 0,
        responsePhrase: "An error occured",
      );
      setRecordsToServerSavingState(false);
      return false;
    }
  }

  void reset() {
    // uploads.clear();
    // isAddingNewRecord = false;
    isSavingRecordsToServer = false;
    recordsToServerApiResponse = null;
    notifyListeners();
  }
}
