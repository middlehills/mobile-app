import 'package:flutter/material.dart';
// import 'package:intercom_flutter/intercom_flutter.dart';

class NavBarProvider extends ChangeNotifier {
  int selectedIndex = 0;

  // update bottomNavBarSelection
  void updateIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void reset() {
    selectedIndex = 0;
    notifyListeners();
  }

  // bool isUserIdentifiedForIntercom = false;

  // setUserId(String value, String valueName) async {
  //   try {
  //     await Intercom.instance.loginIdentifiedUser(userId: value);
  //     final attributes = await Intercom.instance.fetchLoggedInUserAttributes();
  //     // await Intercom.instance.updateUser(userId: value, name: valueName);
  //     log(attributes.toString());
  //     isUserIdentifiedForIntercom = true;
  //     log("IDENTIFIED");
  //   } catch (e) {
  //     isUserIdentifiedForIntercom = false;
  //   }

  //   notifyListeners();
  // }
}
