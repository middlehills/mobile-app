import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/core/data/api_response.dart';
import 'package:mid_hill_cash_flow/features/authentication/data/user_model.dart';
import 'package:mid_hill_cash_flow/features/authentication/data/user_reg_data.dart';
import 'package:mid_hill_cash_flow/features/authentication/domain/auth_api_functions.dart';

class AuthProvider extends ChangeNotifier {
  // This class is used to manage the user registration data
  UserRegData? userRegData;

  // method to set user registration data
  void setUserRegData(String firstName, String lastName, String phoneNumber) {
    userRegData = UserRegData(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: "0$phoneNumber",
    );
    notifyListeners();
  }

  // CREATE ACCOUNT
  // Holds the API response for the create account request
  ApiResponse? createAccountApiResponse;

  // Indicates whether the account creation process is ongoing
  bool isCreatingAccount = false;

  // Updates the account creation state and notifies listeners
  void setCreatingAccountState(bool value) {
    isCreatingAccount = value;
    notifyListeners();
  }

  MidhillUser? midhillUser;

  String? otp;

  Future<bool> createAccount({
    required String baseUrl,
    required String pin,
  }) async {
    setCreatingAccountState(true);

    createAccountApiResponse = await AuthApiFunctions.signUp(
        baseUrl: baseUrl, userRegData: userRegData!, pin: pin);

    if (createAccountApiResponse!.statusCode == 201) {
      midhillUser =
          MidhillUser.fromJson(createAccountApiResponse!.data!['data']);

      otp = createAccountApiResponse!.data!['otp'];
      setCreatingAccountState(false);
      return true; // Return true if the account creation was successful
    } else {
      setCreatingAccountState(false);
      return false; // Return false if the account creation failed
    }
  }
}
