import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/core/data/api_response.dart';
import 'package:mid_hill_cash_flow/features/authentication/data/user_model.dart';
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
    // required String hashedPin,
  }) async {
    setProfileUpdateState(true);

    updateProfileApiResponse = await ProfileApiFunctions.updateUserDetails(
      baseUrl: baseUrl,
      pin: pin,
      hashedPin: midhillUser!.pin,
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
    // required String userId,
  }) async {
    setProfileUpdateVerifyState(true);

    verifyUpdateProfileApiResponse =
        await ProfileApiFunctions.verifyEditProfile(
      baseUrl: baseUrl,
      otpCode: otpCode,
      body: updateRequestBody!,
      userId: midhillUser!.id,
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
    // required String hashedPin,
    required String confrimationPin,
  }) async {
    setChangePasswordLoadingState(true);
    if (!confirmNewPin(confrimationPin)) {
      return false;
    }

    changePinApiResponse = await ProfileApiFunctions.changePin(
      baseUrl: baseUrl,
      curPin: currentPin!,
      hashedPin: midhillUser!.pin,
      newPin: newPin!,
    );

    setChangePasswordLoadingState(false);

    if (changePinApiResponse!.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  bool isDeletingAccount = false;

  setDeleteAccountLoadingState(bool value) {
    isDeletingAccount = value;
    notifyListeners();
  }

  ApiResponse? deleteAccountApiResponse;

  Future<bool> deleteAccount({
    required String baseUrl,
  }) async {
    setDeleteAccountLoadingState(true);
    deleteAccountApiResponse =
        await ProfileApiFunctions.deleteAccount(baseUrl: baseUrl);

    setDeleteAccountLoadingState(false);
    if (deleteAccountApiResponse!.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  bool isFetchingUser = false;

  setFetchingState(bool value) {
    isFetchingUser = value;
    notifyListeners();
  }

  ApiResponse? fetchingUserApiResponse;
  MidhillUser? midhillUser;

  Future<bool> fetchUser({
    required baseUrl,
  }) async {
    setFetchingState(true);

    fetchingUserApiResponse =
        await ProfileApiFunctions.getUserDetails(baseUrl: baseUrl);

    setFetchingState(false);

    if (fetchingUserApiResponse!.statusCode == 200) {
      try {
        midhillUser = MidhillUser.fromJson(
          fetchingUserApiResponse!.data!["user"],
        );
        notifyListeners();
      } catch (e) {
        fetchingUserApiResponse = ApiResponse(
          message: e.toString(),
          data: {},
          statusCode: null,
          responsePhrase: "",
        );
        notifyListeners();
        return false;
      }
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    isProfileUpdating = false;
    updateProfileApiResponse = null;
    updateRequestBody = null;
    isProfileUpdateVerifying = false;
    verifyUpdateProfileApiResponse = null;
    currentPin = null;
    newPin = null;
    changePinApiResponse = null;
    isChangingPassword = false;
    isDeletingAccount = false;
    deleteAccountApiResponse = null;
    isFetchingUser = false;
    fetchingUserApiResponse = null;
    notifyListeners();
  }
}
