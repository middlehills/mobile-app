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
}
