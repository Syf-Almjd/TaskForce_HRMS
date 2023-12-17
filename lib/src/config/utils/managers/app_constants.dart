abstract class AppConstants {
  static const String appTitle = "TASKFORCE HR";
  static List<String> homeTabs = [
    "Attendance",
    "E-Leave",
    "Announcement",
    "Events",
    "Profile"
  ];
  static String inTapTitle = "Features:";
  static String inTapCalenderTitle = "Calender:";
  static const String appFontFamily = "poppins";
  static const String savedAppLanguage = "savedAppLanguage";

  ///Firebase Data
  static String usersCollection = "users";
  static String parentTabsCollection = "Taps";
  static String announcementCollection = "announcement";
  static String announcementDataCollection = "Tabs/announcement/posts";
  static String eventsCollection = "events";
  static String eventsDataCollection = "Tabs/events/posts";
  static String noPhotoUser = "NOPHOTO";
}
