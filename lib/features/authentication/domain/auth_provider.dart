import 'dart:async';
import 'dart:developer';

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
      final phoneNumber = midhillUser!.phoneNumber;
      AuthService.storePhoneNumber(phoneNumber);
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

  // LOGIN
  bool isLoggingIn = false;
  ApiResponse? loginApiResponse;

  void setLoggingInState(bool value) {
    isLoggingIn = value;
    notifyListeners();
  }

  Future<bool> login({
    required String baseUrl,
    required String pin,
  }) async {
    setLoggingInState(true);

    final phoneNumber = await AuthService.getPhoneNumber();

    if (phoneNumber == null) {
      loginApiResponse = ApiResponse(
        message: "Sign In again",
        data: {"error": "No phone number attached"},
        statusCode: 0,
        responsePhrase: "No phone number attached",
      );
      notifyListeners();
      setLoggingInState(false);
      return false;
    }

    loginApiResponse = await AuthApiFunctions.login(
      baseUrl: baseUrl,
      phoneNumber: phoneNumber,
      pin: pin,
    );

    if (loginApiResponse!.statusCode == 200) {
      midhillUser = MidhillUser.fromJson(
        loginApiResponse!.data!['user'],
      );
      accessToken = loginApiResponse!.data!["accessToken"];
      AuthService.storeAccessStoken(accessToken!);
      refreshToken = loginApiResponse!.data!["refreshToken"];
      AuthService.storeRefreshToken(refreshToken!);
      notifyListeners();
      setLoggingInState(false);
      return true;
    } else {
      setLoggingInState(false);
      return false;
    }
  }

  Timer? otpExpiryTimer;
  int remainingSeconds = 300;

  void setTimer() {
    remainingSeconds = 300;
    notifyListeners();
    const oneSecond = Duration(seconds: 1);

    otpExpiryTimer?.cancel();

    otpExpiryTimer = Timer.periodic(
      oneSecond,
      (Timer timer) {
        if (remainingSeconds == 0) {
          cancelTimer();
        } else {
          remainingSeconds--;
          notifyListeners();
        }
      },
    );
    notifyListeners();
  }

  void cancelTimer() {
    otpExpiryTimer?.cancel();
    // otpExpiryTimer = null;
    notifyListeners();
    log('cancelled');
  }

  bool isResendingOtp = false;

  setResendOtpState(bool value) {
    isResendingOtp = value;
    notifyListeners();
  }

  ApiResponse? resendOtpApiResponse;

  Future<bool> resendOtp({required String baseUrl}) async {
    setResendOtpState(true);

    resendOtpApiResponse =
        await AuthApiFunctions.resendOtp(baseUrl: baseUrl, id: midhillUser!.id);
    log(resendOtpApiResponse!.data.toString());

    setResendOtpState(false);
    if (resendOtpApiResponse!.statusCode == 200) {
      userOtp = resendOtpApiResponse!.data!['otp'];
      setTimer();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool isLoginForgotPassword = false;

  setForgotPasswordCheck(bool value) {
    isLoginForgotPassword = value;
    notifyListeners();
  }

  bool isInitiatingForgotPassword = false;

  setInitForgotPasswordState(bool value) {
    isInitiatingForgotPassword = value;

    notifyListeners();
  }

  ApiResponse? initForgotPasswordApiResponse;

  Future<bool> initiateForgotPassword({
    required String baseUrl,
    required String phoneNumber,
  }) async {
    setInitForgotPasswordState(true);

    initForgotPasswordApiResponse = await AuthApiFunctions.forgotPin(
        baseUrl: baseUrl, phoneNumber: phoneNumber);

    setInitForgotPasswordState(false);

    if (initForgotPasswordApiResponse!.statusCode == 200) {
      log(initForgotPasswordApiResponse?.data!['otp'] ?? "");

      try {
        midhillUser = MidhillUser.fromJson(
          initForgotPasswordApiResponse?.data!['user'],
        );

        accessToken = initForgotPasswordApiResponse!.data!["accessToken"];
        AuthService.storeAccessStoken(accessToken!);

        log(accessToken.toString());
      } catch (e) {
        return false;
      }

      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool isVerifyingFgPinOtp = false;

  setIsVerifyingFgPinOtpState(bool value) {
    isVerifyingFgPinOtp = value;

    notifyListeners();
  }

  String? otpCode;

  setOtp(String value) {
    otpCode = value;

    notifyListeners();
  }

  ApiResponse? verifyFgPinOtpApiResponse;

  Future<bool> verifyFgPinOtp({
    required String otp,
    required String baseUrl,
    required String userId,
  }) async {
    setIsVerifyingFgPinOtpState(true);

    verifyFgPinOtpApiResponse = await AuthApiFunctions.verifyOtp(
      baseUrl: baseUrl,
      otp: otp,
      userId: userId,
    );

    setOtp(otp);

    setIsVerifyingFgPinOtpState(false);
    if (verifyFgPinOtpApiResponse!.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  bool isChangingPassword = false;

  setIsChangingPasswordState(bool value) {
    isChangingPassword = value;

    notifyListeners();
  }

  ApiResponse? changePasswordApiResponse;

  Future<bool> changePassword({
    required String baseUrl,
    required String otpCode,
    required String newPin,
  }) async {
    setIsChangingPasswordState(true);

    changePasswordApiResponse = await AuthApiFunctions.changePin(
      baseUrl: baseUrl,
      otpCode: otpCode,
      newPin: newPin,
    );

    setIsChangingPasswordState(false);

    if (changePasswordApiResponse!.statusCode == 200) {
      log(changePasswordApiResponse?.data.toString() ?? "");

      return true;
    } else {
      return false;
    }
  }

  void reset() {
    userRegData = null;
    createAccountApiResponse = null;
    isCreatingAccount = false;
    midhillUser = null;
    userOtp = null;
    verifyOtpResponse = null;
    isVerifying = false;
    accessToken = null;
    refreshToken = null;
    isSigningIn = false;
    signInApiResponse = null;
    isLoggingIn = false;
    loginApiResponse = null;
    otpExpiryTimer = null;
    remainingSeconds = 300;
    notifyListeners();
  }
}
