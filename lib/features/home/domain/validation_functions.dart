class ValidationFunctions {
  static String? validateName(String? name) {
    if (name == null) {
      return "Please enter your name";
    } else if (name.isEmpty) {
      return "Please enter your name";
    } else if (name.length < 2) {
      return "Name must be at least 2 characters long";
    } else if (name.length > 20) {
      return "Name must be at most 20 characters long";
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(name)) {
      return "Name must only contain letters";
    } else {
      return null;
    }
  }

  static String? validateQuantity(String? quantity) {
    if (quantity == null) {
      return "Please enter item's quantity";
    } else if (quantity.isEmpty) {
      return "Quantity is empty";
    } else if (!RegExp(r'^[0-9]+$').hasMatch(quantity)) {
      return "Quantity must only contain digits";
    } else {
      return null;
    }
  }

  static String? validateAmount(String? amount) {
    if (amount == null) {
      return "Enter item's amount";
    } else if (amount.isEmpty) {
      return "Amount is empty";
    } else if (!RegExp(r'^₦?\d+(\.\d{2})?$').hasMatch(amount)) {
      return "Amount must be a valid number";
    } else {
      return null;
    }
  }
}
