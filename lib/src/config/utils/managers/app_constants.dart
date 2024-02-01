import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/config/utils/styles/app_colors.dart';
import 'package:taskforce_hrms/src/presentation/Cubits/navigation_cubit/navi_cubit.dart';
import 'package:taskforce_hrms/src/presentation/Modules/Tabs/Attendance/Reminders/reminders_screen.dart';
import 'package:taskforce_hrms/src/presentation/Modules/Tabs/Profile/Screens/edit_profile_screen.dart';
import 'package:taskforce_hrms/src/presentation/Shared/Components.dart';

import '../../../domain/Models/UserModel.dart';

abstract class AppConstants {
  static const String appTitle = "TASKFORCE HR";
  static List<String> homeTabs = [
    "Attendance",
    "E-Leave",
    "Announcement",
    "Events",
    "Profile"
  ];

  static const String savedUser = "currentuser";

  static String inTapCalenderTitle = "Calender:";
  static const String appFontFamily = "poppins";
  static const String savedAppLanguage = "savedAppLanguage";

  ///Local Attendance Record
  static String userLocalAttendance = "userAttendance";
  static String userLocalEleave = "userEleave";

  ///Firebase Data
  static String usersCollection = "users";
  static String staffMembersCollection = "/dashboard/staff/members/";
  static String lastAttendUSER = "lastAttend";
  static String lastEleaveUSER = "lastEleave";
  static String lastLoginUSER = "lastLogin";

  ///Attendance
  static String attendanceRecordCollection = "attendanceRecord";
  static String attendanceStaffCollection = "/Tabs/attendance/staff";

  ///Eleave
  static String eLeaveRecordCollection = "eleaveRecord";
  static String eLeaveStaffCollection = "/Tabs/eleave/staff";

  ///Other
  static String announcementCollection = "/Tabs/announcement/posts";
  static String eventsCollection = "/Tabs/events/posts";
  static String noPhotoUser = "NOPHOTO";

  static List<String> profileCardsName = [
    "Edit Profile",
    "Notifications",
    "Report a problem",
    "Share",
    "Logout"
  ];
  static List<IconData> profileCardsIcons = [
    Icons.edit_attributes_outlined,
    Icons.notifications_active_outlined,
    Icons.report_problem_outlined,
    Icons.offline_share,
    Icons.door_back_door_outlined,
  ];
  static List<Function> profileCardsPages = [
    (BuildContext context, UserModel currentUser) {
      return NaviCubit.get(context).navigate(
          context,
          EditProfileScreen(
            currentUser: currentUser,
          ));
    },
    (BuildContext context, UserModel currentUser) {
      return NaviCubit.get(context).navigate(context, const ReminderScreen());
    },
    (BuildContext context, UserModel currentUser) {
      return showToast(
        "Contact +601154225092",
        AppColors.primaryColor,
        context,
      );
    },
    (BuildContext context, UserModel currentUser) {
      return openUrl(
          "https://play.google.com/store/apps/details?id=com.example.taskforce_hrms.taskforce_hrms");
    },
    (BuildContext context, UserModel currentUser) {
      return showChoiceDialog(
          context: context,
          title: "Logout",
          onYes: () {
            NaviCubit.get(context).navigateToSliderLogout(context);
          });
    }
  ];
}
