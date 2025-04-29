class AuthFunctions {
  AuthFunctions._();

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

  static String? validatePhoneumber(String? phone) {
    if (phone == null) {
      return "Please enter your phone number";
    } else if (phone.isEmpty) {
      return "Please enter your phone number";
    } else if (phone.length < 10) {
      return "Phone number must be at least 10 digits long";
    } else if (phone.length > 11) {
      return "Phone number must be at most 11 digits long";
    } else if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      return "Phone number must only contain digits";
    } else {
      return null;
    }
  }
}
