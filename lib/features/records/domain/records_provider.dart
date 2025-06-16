import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/core/data/api_response.dart';
import 'package:mid_hill_cash_flow/features/records/data/transaction_model.dart';
import 'package:mid_hill_cash_flow/features/records/domain/records_api_functions.dart';

class RecordsProvider extends ChangeNotifier {
  bool showIncome = false;

  setShowIncomeState(bool value) {
    if (transactions.isNotEmpty) {
      showIncome = value;
    }
    notifyListeners();
  }

  DateTime? selectedDate;

  void selectDate(DateTime? value) {
    selectedDate = value;
    if (value != null) {
      filteredTransactions = transactions
          .where((transaction) =>
              transaction.createdAt.year == value.year &&
              transaction.createdAt.month == value.month &&
              transaction.createdAt.day == value.day)
          .toList();
    }
    notifyListeners();
  }

  // FilterRange filterRange = FilterRange.all;

  // setFilterRange(FilterRange value) {
  //   filterRange = value;

  //   // switch (filterRange) {
  //   //   case FilterRange.all:
  //   //     filteredTransactions = transactions;
  //   //     break;
  //   //   case FilterRange.today:
  //   //     filteredTransactions = transactions.where((transaction) {
  //   //       final now = DateTime.now();
  //   //       return transaction.createdAt.year == now.year &&
  //   //           transaction.createdAt.month == now.month &&
  //   //           transaction.createdAt.day == now.day;
  //   //     }).toList();
  //   //   case FilterRange.thisMonth:
  //   //     filteredTransactions = transactions.where((transaction) {
  //   //       final now = DateTime.now();
  //   //       return transaction.createdAt.year == now.year &&
  //   //           transaction.createdAt.month == now.month;
  //   //     }).toList();
  //   //   case FilterRange.thisWeek:
  //   //     filteredTransactions = transactions.where((transaction) {
  //   //       final now = DateTime.now();
  //   //       final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  //   //       final endOfWeek = startOfWeek.add(const Duration(days: 6));
  //   //       return transaction.createdAt
  //   //               .isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
  //   //           transaction.createdAt
  //   //               .isBefore(endOfWeek.add(const Duration(days: 1)));
  //   //     }).toList();
  //   //   default:
  //   //     filteredTransactions = transactions;
  //   // }
  //   // notifyListeners();

  // }

  List<Transaction> filteredTransactions = [];

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
  }) async {
    setRecordFetchingState(true);
    try {
      recordsApiResponse = await RecordsApiFunctions.fetchTransactions(
        baseUrl: baseUrl,
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
        // setFilterRange(filterRange);
        transactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        if (selectedDate != null) {
          selectDate(selectedDate!);
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
      filteredTransactions.removeAt(index);
      transactions.removeWhere((trans) => trans.id == transaction.id);
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

  void reset() {
    showIncome = false;
    // filterRange = FilterRange.all;
    selectedDate = null;
    filteredTransactions = [];
    isRecordFetching = false;
    recordsApiResponse = null;
    transactions = [];
    totalIncome = 0;
    isDeletingRecord = false;
    temporaryTransaction = null;
    deleteRecordFromServerApiResponse = null;
    notifyListeners();
  }
}
