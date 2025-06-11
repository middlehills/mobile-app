import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/core/data/api_response.dart';
import 'package:mid_hill_cash_flow/features/profile/domain/profile_api_functions.dart';

class ProfileProvider extends ChangeNotifier {
  bool isProfileUpdating = false;

  void setProfileUpdateState(bool value) {
    isProfileUpdating = value;
    notifyListeners();
  }

  ApiResponse? updateProfileApiResponse;

  Map<String, String>? updateRequestBody;

  void setProfileRequestBody({
    String? firstName,
    String? lastName,
    String? phone,
  }) {
    updateRequestBody = {
      if (firstName != null) "first_name": firstName,
      if (lastName != null) "last_name": lastName,
      if (phone != null) "phone_number": phone,
    };
    notifyListeners();
  }

  Future<bool> updateProfileDetails({
    required String baseUrl,
    required String pin,
    required String hashedPin,
  }) async {
    setProfileUpdateState(true);

    updateProfileApiResponse = await ProfileApiFunctions.updateUserDetails(
      baseUrl: baseUrl,
      pin: pin,
      hashedPin: hashedPin,
    );

    setProfileUpdateState(false);

    if (updateProfileApiResponse!.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  bool isProfileUpdateVerifying = false;

  void setProfileUpdateVerifyState(bool value) {
    isProfileUpdateVerifying = value;
    notifyListeners();
  }

  ApiResponse? verifyUpdateProfileApiResponse;

  Future<bool> verifyUpdateProfileDetails({
    required String baseUrl,
    required String otpCode,
    required String userId,
  }) async {
    setProfileUpdateVerifyState(true);

    verifyUpdateProfileApiResponse =
        await ProfileApiFunctions.verifyEditProfile(
      baseUrl: baseUrl,
      otpCode: otpCode,
      body: updateRequestBody!,
      userId: userId,
    );

    setProfileUpdateVerifyState(false);

    if (verifyUpdateProfileApiResponse!.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  String? currentPin;
  String? newPin;

  setCurrentPin(String value) {
    currentPin = value;
    notifyListeners();
  }

  setNewPin(String value) {
    newPin = value;
    notifyListeners();
  }

  ApiResponse? changePinApiResponse;

  bool confirmNewPin(String value) {
    if (value == newPin) {
      return true;
    } else {
      changePinApiResponse = ApiResponse(
        message: "Confirmation PIN doesn't match",
        data: {},
        statusCode: null,
        responsePhrase: "Confirmation PIN doesn't match",
      );
      notifyListeners();
      return false;
    }
  }

  bool isChangingPassword = false;
  setChangePasswordLoadingState(bool value) {
    isChangingPassword = value;
    notifyListeners();
  }

  Future<bool> changeUserPin({
    required String baseUrl,
    required String hashedPin,
    required String confrimationPin,
  }) async {
    setChangePasswordLoadingState(true);
    if (!confirmNewPin(confrimationPin)) {
      return false;
    }

    changePinApiResponse = await ProfileApiFunctions.changePin(
      baseUrl: baseUrl,
      curPin: currentPin!,
      hashedPin: hashedPin,
      newPin: newPin!,
    );

    setChangePasswordLoadingState(false);

    if (changePinApiResponse!.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
