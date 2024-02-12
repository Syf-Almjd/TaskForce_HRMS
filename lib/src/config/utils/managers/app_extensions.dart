import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taskforce_hrms/src/presentation/Modules/Home/home_page.dart';
import 'package:taskforce_hrms/src/presentation/Modules/Tabs/Attendance/CheckOut/check_out_attendance.dart';
import 'package:taskforce_hrms/src/presentation/Modules/Tabs/ELeave/History/eleave_history_screen.dart';
import 'package:taskforce_hrms/src/presentation/Modules/Tabs/ELeave/Request/eleave_request.dart';
import 'package:taskforce_hrms/src/presentation/Modules/Tabs/ELeave/eleave_page.dart';
import 'package:taskforce_hrms/src/presentation/Modules/Tabs/Profile/profile_page.dart';
import 'package:taskforce_hrms/src/presentation/Modules/Tabs/announcemnets/announcements_page.dart';

import '../../../presentation/Modules/Tabs/Attendance/Attend/attend_screen.dart';
import '../../../presentation/Modules/Tabs/Attendance/History/attend_history_screen.dart';
import '../../../presentation/Modules/Tabs/Events/events_page.dart';
import '../../../presentation/test.dart';
import 'app_enums.dart';

extension DateFromString on String {
  DateTime toDate() {
    return DateTime.parse(this).toLocal();
  }
}

extension AppTab on AppTabsHeaders {
  Widget getTabScreen() {
    switch (this) {
      case AppTabsHeaders.attendance:
        return const HomePage();
      case AppTabsHeaders.eleave:
        return const EleavePage();
      case AppTabsHeaders.announcements:
        return const AnnouncementsPage();
      case AppTabsHeaders.events:
        return const EventsPage();
      case AppTabsHeaders.profile:
        return const ProfilePage();
    }
  }
}

extension FeatureButtonsWidget on Enum {
  Widget getFeatureButtonWidget() {
    switch (this) {
      //Attendance
      case AttendanceTabButtons.checkin:
        return const AttendScreen();
      case AttendanceTabButtons.checkout:
        return const CheckoutAttendanceScreen();
      case AttendanceTabButtons.history:
        return const AttendanceHistoryScreen();

      // case AttendanceTabButtons.share:
      //   return const ShareAttendanceScreen();

      //eleave
      case EleaveTabButtons.request:
        return const EleaveRequestScreen();
      case EleaveTabButtons.history:
        return const EleaveHistoryScreen();
      default:
        return const TestPage();
    }
  }
}

extension AppContext on BuildContext {
  get getAppAssets => AppLocalizations.of(this);
  // get getLocalData => LocalDataCubit.get(this); created an method on Local Class
  // get getRemoteData => RemoteDataCubit.get(this); created an method on Remote Class
}

extension StringExtension on String {
  String toCapitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension MediaQueryExtension on BuildContext {
  Size get _size => MediaQuery.of(this).size;
  double get width => _size.width;
  double get height => _size.height;
}

extension DeviceTypeExtension on DeviceType {
  int getMinWidth() {
    switch (this) {
      case DeviceType.mobile:
        return 320;
      case DeviceType.ipad:
        return 481;
      case DeviceType.smallScreenLaptop:
        return 769;
      case DeviceType.largeScreenDesktop:
        return 1025;
      case DeviceType.extraLargeTV:
        return 1201;
    }
  }

  int getMaxWidth() {
    switch (this) {
      case DeviceType.mobile:
        return 480;
      case DeviceType.ipad:
        return 768;
      case DeviceType.smallScreenLaptop:
        return 1024;
      case DeviceType.largeScreenDesktop:
        return 1200;
      case DeviceType.extraLargeTV:
        return 3840; // any number more than 1200
    }
  }
}

extension MonthName on int {
  String get dateMonthName {
    switch (this) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }
}
