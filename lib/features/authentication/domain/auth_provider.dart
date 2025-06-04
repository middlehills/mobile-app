import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/core/data/api_response.dart';
import 'package:mid_hill_cash_flow/features/authentication/data/user_model.dart';
import 'package:mid_hill_cash_flow/features/authentication/data/user_reg_data.dart';
import 'package:mid_hill_cash_flow/features/authentication/domain/auth_api_functions.dart';
import 'package:mid_hill_cash_flow/features/authentication/domain/auth_service.dart';

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

  String? userOtp;

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

      userOtp = createAccountApiResponse!.data!['otp'];
      notifyListeners();
      setCreatingAccountState(false);
      return true; // Return true if the account creation was successful
    } else {
      setCreatingAccountState(false);
      return false; // Return false if the account creation failed
    }
  }

  // VERIFY SIGN UP OTP
  ApiResponse? verifyOtpResponse;

  bool isVerifying = false;

  setVerifyingState(bool value) {
    isVerifying = value;
  }

  String? accessToken;
  String? refreshToken;

  Future<bool> verifyUser({
    required String baseUrl,
    required String otp,
  }) async {
    setVerifyingState(true);

    verifyOtpResponse = await AuthApiFunctions.verifySignUp(
      baseUrl: baseUrl,
      id: midhillUser!.id,
      otp: userOtp!,
    );

    if (verifyOtpResponse!.statusCode == 200) {
      accessToken = verifyOtpResponse!.data!["accessToken"];
      AuthService.storeAccessStoken(accessToken!);
      refreshToken = verifyOtpResponse!.data!["refreshToken"];
      AuthService.storeRefreshToken(refreshToken!);
      notifyListeners();

      setVerifyingState(false);
      return true;
    } else {
      setVerifyingState(false);
      return false;
    }
  }

  // SIGN IN
  bool isSigningIn = false;
  ApiResponse? signInApiResponse;

  void setSigningInState(bool value) {
    isSigningIn = value;
    notifyListeners();
  }

  Future<bool> signIn({
    required String baseUrl,
    required String phoneNumber,
    required String pin,
  }) async {
    setSigningInState(true);

    signInApiResponse = await AuthApiFunctions.signIn(
      baseUrl: baseUrl,
      phoneNumber: phoneNumber,
      pin: pin,
    );

    if (signInApiResponse!.statusCode == 200) {
      midhillUser = MidhillUser.fromJson(
        signInApiResponse!.data!['user'],
      );
      userOtp = signInApiResponse!.data!['otp'];
      setSigningInState(false);
      return true;
    } else {
      setSigningInState(false);
      return false;
    }
  }
}
