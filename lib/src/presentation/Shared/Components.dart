import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_constants.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_extensions.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/utils/managers/app_assets.dart';
import '../../config/utils/styles/app_colors.dart';
import '../../data/remote/API/RemoteHttpRequest.dart';
import '../Cubits/navigation_cubit/navi_cubit.dart';

TextStyle fontAlmarai(
    {double? size, Color? textColor, FontWeight? fontWeight}) {
  return GoogleFonts.almarai(
      fontWeight: fontWeight ?? FontWeight.normal,
      fontSize: size ?? 16,
      color: textColor ?? Colors.black54);
}

TextStyle fontLobster(
    {double? size, Color? textColor, FontWeight? fontWeight}) {
  return GoogleFonts.lobster(
      fontWeight: fontWeight ?? FontWeight.normal,
      fontSize: size ?? 16,
      color: textColor ?? Colors.black54);
}

TextStyle fontElMessiri(
    {double? size, Color? textColor, FontWeight? fontWeight}) {
  return GoogleFonts.elMessiri(
      fontWeight: fontWeight ?? FontWeight.normal,
      fontSize: size ?? 16,
      color: textColor ?? Colors.black54);
}

TextStyle fontPoppins(
    {double? size, Color? textColor, FontWeight? fontWeight}) {
  return GoogleFonts.poppins(
      fontWeight: fontWeight ?? FontWeight.bold,
      fontSize: size ?? 16,
      color: textColor ?? Colors.black54);
}

double getHeight(int percent, context) {
  return (MediaQuery.of(context).size.height * (percent / 100)).toDouble();
}

SizedBox getCube(int percent, context) {
  return SizedBox(
    width: (MediaQuery.of(context).size.width * (percent / 100)).toDouble(),
    height: (MediaQuery.of(context).size.height * (percent / 100)).toDouble(),
  );
}

double getWidth(int percent, context) {
  return (MediaQuery.of(context).size.width * (percent / 100)).toDouble();
}

Widget loadingAnimation({Widget? loadingType}) {
  if (loadingType != null) {
    return loadingType;
  } else {
    return Center(
        child: LoadingAnimationWidget.waveDots(color: Colors.blue, size: 30));
  }
}

Widget padBox({size}) {
  return Padding(padding: EdgeInsets.all(size ?? 10));
}

///Custom TextField
Widget textFieldA({
  // here if you put in before the { it is required by default but if you put after it you need to say required
  Key?
      key, //the difference is that inside {} it can be optional if you want to enforce input when call use "required"
  required TextEditingController controller,
  required String hintText,
  bool? obscureText = false, //optional
  TextAlign textAlign = TextAlign.start, //optional
  Icon? prefixIcon,
  double? internalPadding,
  void Function(String)? onChanged,
  void Function(String)? onSubmitted,
}) {
  return TextField(
    key: key,
    controller: controller,
    obscureText: obscureText ?? false,
    cursorColor: HexColor("#4f4f4f"),
    textAlign: textAlign,
    decoration: InputDecoration(
      hintText: hintText,
      fillColor: HexColor("#f2f3ff"),
      contentPadding: EdgeInsets.all(internalPadding ?? 20),
      hintStyle: GoogleFonts.almarai(
        fontSize: 15,
        color: Colors.black87,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      prefixIcon: prefixIcon,
      prefixIconColor: HexColor("#4f4f4f"),
      filled: true,
    ),
    onChanged: onChanged,
    onSubmitted: onSubmitted,
  );
}

///Custom Button
Widget buttonA({
  final Function()? onPressed,
  required final String buttonText,
  int? height,
  int? width,
  Color? color,
  int? borderSize,
  Color? textColor,
}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: (height ?? 55).toDouble(),
      width: (height ?? 275).toDouble(),
      decoration: BoxDecoration(
        color: (color ?? HexColor('#ebcd34')),
        borderRadius: BorderRadius.circular(
          (borderSize ?? 17).toDouble(),
        ),
      ),
      child: Center(
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: fontAlmarai(size: 22),
        ),
      ),
    ),
  );
}

///shows logo
Padding logoContainer(context) {
  return Padding(
    padding: const EdgeInsets.all(50.0),
    child: Container(
      width: getWidth(50, context),
      height: getHeight(20, context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(width: 2),
      ),
      child: const Image(
        image: AssetImage(AppAssets.assetsLogoTransparent),
        fit: BoxFit.contain,
      ),
    ),
  );
}

//Show a toast
void showToast(String text, Color color, context) => toastification.show(
      context: context,
      title: Text(text.toString()),
      alignment: Alignment.bottomCenter,
      primaryColor: color,
      dragToClose: true,
      showProgressBar: true,
      icon: const Icon(Icons.info_outlined),
      autoCloseDuration: const Duration(seconds: 3),
    );

Widget getDivider(context) {
  return Divider(
    endIndent: getWidth(17, context),
    indent: getWidth(17, context),
    thickness: 1,
    color: AppColors.darkColor.withOpacity(.3),
  );
}

//Validate Text field
validateForm(
  GlobalKey<FormState> validateKey,
) {
  if (validateKey.currentState!.validate()) {
    validateKey.currentState!.save();
    return true;
  } else {
    return false;
  }
}

String getDateTimeToDay(String dateString) {
  try {
    DateTime date = DateTime.parse(dateString).toLocal();
    String time = "${date.hour}:${date.minute.toString().padLeft(2, '0')}";

    DateTime now = DateTime.now();
    if (date.isAtSameMomentAs(now)) {
      return "Today, at $time";
    } else if (date.isAtSameMomentAs(now.add(const Duration(days: 1)))) {
      return "Tomorrow, at $time";
    } else if (date.isAtSameMomentAs(now.subtract(const Duration(days: 1)))) {
      return "Yesterday, at $time";
    } else {
      return "${date.day}, ${date.month.dateMonthName} at $time";
    }
  } catch (e) {
    return "Loading";
  }
}

Future showChoiceDialog(
    {required BuildContext context,
    String? title,
    String? content,
    required Function onYes,
    Function? onNo}) {
  return (showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text(title ?? ""),
          content: Text(content ?? "Are you Sure?"),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                if (onNo != null) {
                  onNo();
                }
                NaviCubit.get(context).pop(context);
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                onYes();
                NaviCubit.get(context).pop(context);
              },
            ),
          ],
        );
      }));
}

void openUrl(String url) {
  var openUrl = Uri.parse(url);
  launchUrl(
    openUrl,
    mode: LaunchMode.externalApplication,
  );
}

String getCurrentUserAttendance() {
  return "${AppConstants.attendanceStaffCollection}/${FirebaseAuth.instance.currentUser?.uid}/${AppConstants.attendanceRecordCollection}";
}

Future<String> getLocationName(
    {required String latitude, required String longitude}) async {
  var location = await HttpRequestPage.getCityInfoAPI(latitude, longitude);
  return location!["city"];
}

String getCurrentUserEleave() {
  return "${AppConstants.eLeaveStaffCollection}/${FirebaseAuth.instance.currentUser?.uid}/${AppConstants.eLeaveRecordCollection}";
}
