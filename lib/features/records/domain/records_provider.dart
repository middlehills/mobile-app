import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/core/data/api_response.dart';
import 'package:mid_hill_cash_flow/features/records/data/transaction_model.dart';
import 'package:mid_hill_cash_flow/features/records/domain/records_api_functions.dart';
import 'package:mid_hill_cash_flow/features/records/presentation/transaction_filter_row.dart';

class RecordsProvider extends ChangeNotifier {
  bool showIncome = false;

  setShowIncomeState(bool value) {
    if (transactions.isNotEmpty) {
      showIncome = value;
    }
    notifyListeners();
  }

  FilterRange filterRange = FilterRange.all;

  setFilterRange(FilterRange value) {
    filterRange = value;
    notifyListeners();
  }

  bool isRecordFetching = false;

  setRecordFetchingState(bool value) {
    isRecordFetching = value;
    notifyListeners();
  }

  ApiResponse? recordsApiResponse;

  List<Transaction> transactions = [];
  int totalIncome = 0;

  Future<bool> fetchRecordsFromServer({
    required String baseUrl,
    required String businessID,
  }) async {
    setRecordFetchingState(true);
    try {
      recordsApiResponse = await RecordsApiFunctions.fetchTransactions(
        baseUrl: baseUrl,
        businessID: businessID,
      );
      setRecordFetchingState(false);
      if (recordsApiResponse!.statusCode == 200) {
        transactions = [];
        totalIncome = 0;
        notifyListeners();
        for (var element in recordsApiResponse!.data!['data']) {
          transactions.add(Transaction.fromJson(element));
          totalIncome += element['amount'] as int;
        }
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      recordsApiResponse = ApiResponse(
        message: e.runtimeType.toString(),
        data: {"error": e.toString()},
        statusCode: 0,
        responsePhrase: "An error occured",
      );
      setRecordFetchingState(false);
      notifyListeners();
      return false;
    }
  }

  bool isDeletingRecord = false;

  Transaction? temporaryTransaction;

  setDeletingRecordState(bool value) {
    isDeletingRecord = value;
    notifyListeners();
  }

  ApiResponse? deleteRecordFromServerApiResponse;

  Future<bool> deleteRecord({
    required String baseUrl,
    required Transaction transaction,
    required int index,
  }) async {
    setDeletingRecordState(true);
    try {
      transactions.removeAt(index);
      temporaryTransaction = transaction;
      notifyListeners();

      deleteRecordFromServerApiResponse =
          await RecordsApiFunctions.deleteTransaction(
              baseUrl: baseUrl, transactionId: transaction.id);

      if (deleteRecordFromServerApiResponse!.statusCode == 200) {
        totalIncome = 0;
        for (var transaction in transactions) {
          totalIncome += transaction.amount;
        }
        notifyListeners();
        setDeletingRecordState(false);
        return true;
      } else {
        transactions.insert(index, temporaryTransaction!);
        setDeletingRecordState(false);
        return false;
      }
    } catch (e) {
      recordsApiResponse = ApiResponse(
        message: e.runtimeType.toString(),
        data: {"error": e.toString()},
        statusCode: 0,
        responsePhrase: "An error occured",
      );
      setDeletingRecordState(false);
      notifyListeners();
      return false;
    }
  }
}
