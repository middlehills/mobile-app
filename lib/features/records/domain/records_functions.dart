class RecordsFunctions {
  RecordsFunctions._();

  static String formatMoney(int amount) {
    final number = amount / 1.0;
    return number.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
