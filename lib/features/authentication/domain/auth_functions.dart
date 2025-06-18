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

  static String? validateFullName(String? fullName) {
    if (fullName == null) {
      return "Please enter your full name";
    } else if (fullName.isEmpty) {
      return "Please enter your full name";
    } else if (fullName.length < 5) {
      return "Full name must be at least 5 characters long";
    } else if (fullName.length > 50) {
      return "Full name must be at most 50 characters long";
    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(fullName)) {
      return "Full name must only contain letters and spaces";
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

  static String? validateEmail(String? email) {
    if (email == null) {
      return "Please enter your email";
    } else if (email.isEmpty) {
      return "Please enter your email";
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return "Please enter a valid email address";
    } else {
      return null;
    }
  }

  static String? validateBVN(String? bvn) {
    if (bvn == null) {
      return "Please enter your BVN";
    } else if (bvn.isEmpty) {
      return "Please enter your BVN";
    } else if (bvn.length != 11) {
      return "BVN must be exactly 11 digits";
    } else if (!RegExp(r'^[0-9]{11}$').hasMatch(bvn)) {
      return "BVN must only contain digits";
    } else {
      return null;
    }
  }

  static String secondsToDigitalTime(int seconds) {
    // Calculate minutes and remaining seconds
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    // Format the result as "m:ss"
    String formattedSeconds = remainingSeconds.toString().padLeft(2, '0');

    return "$minutes:$formattedSeconds";
  }
}
