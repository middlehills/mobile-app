import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/features/records/presentation/transaction_filter_row.dart';

class RecordsProvider extends ChangeNotifier {
  bool showIncome = false;

  setShowIncomeState(bool value) {
    showIncome = value;
    notifyListeners();
  }

  FilterRange filterRange = FilterRange.all;

  setFilterRange(FilterRange value) {
    filterRange = value;
    notifyListeners();
  }
}
