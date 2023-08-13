import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

TextStyle fontAlmarai(
    {double? size, Color? textColor, FontWeight? fontWeight}) {
  return GoogleFonts.almarai(
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
        child: LoadingAnimationWidget.waveDots(color: Colors.yellow, size: 30));
  }
}

Widget padBox({size}) {
  return Padding(padding: EdgeInsets.all(size ?? 10));
}

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

Widget itemsList({
  String? name,
  String? img,
}) {
  bool isClicked = false;
  return GestureDetector(
    // onTap: () => NaviState.navigate(context, widget.pageWidget),
    // onTapDown: (context) {
    // },
    // onTapCancel: () => ,
    // onTapUp: () => ,
    // onTap: () {
    //   if (widget.pageNum == 1) {
    //     Navigator.push(context,
    //         MaterialPageRoute(builder: (context) => const anyPage()));
    //   } else if (widget.pageNum == 2) {
    //     Navigator.push(context,
    //         MaterialPageRoute(builder: (context) => const anyPage()));
    //   } else if (widget.pageNum == 3) {
    //     Navigator.push(context,
    //         MaterialPageRoute(builder: (context) => const anyPage()));
    //   } else if (widget.pageNum == 4) {
    //     Navigator.push(context,
    //         MaterialPageRoute(builder: (context) => const anyPage()));
    //   }
    // },
    child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color:
              // mainPageController.statePage == false
              //     ? Colors.grey
              // :
              // HexColor("#44564a"),
              Colors.white38,
          border: Border.all(
              color: isClicked == false
                  ? Colors.transparent
                  : Colors.grey.withOpacity(0.3),
              style: BorderStyle.solid,
              width: 0.75),
          // color: HexColor("#44564a"),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                img!,
                fit: BoxFit.contain,
                scale: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              name!,
              style: GoogleFonts.poppins(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )),
  );
}

Widget rowHomeItems({
  required String name,
  required String img,
  required Function onTap,

}) {
  return InkWell(
    onTap: (){onTap(name);},
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white70,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  height: 100,
                  width: 150,
                  child: Card(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        img,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          return loadingProgress != null
                              ? Center(
                                  child: LoadingAnimationWidget.flickr(
                                      leftDotColor: Colors.blue,
                                      rightDotColor: Colors.yellow,
                                      size: 30))
                              : child;
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                name
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget socialMediaItem({
  required int index,
  required String img,
  required Function onTap,
}) {

  return Padding(
    padding: const EdgeInsets.all(7.0),
    child: InkWell(
      onTap: (){onTap(index);},
      child: SizedBox(
        height: 50,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            img,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              return loadingProgress != null
                  ? Center(
                      child: LoadingAnimationWidget.flickr(
                          leftDotColor: Colors.blue,
                          rightDotColor: Colors.yellow,
                          size: 30))
                  : child;
            },
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    ),
  );
}


void openUrl(String url) {
  var openUrl =  Uri.parse(url);
  launchUrl(
    openUrl,
    mode: LaunchMode.externalApplication,
  );
}
enum asd {
  save,
  fail,
  alert,
}

void showToast(String text, SnackBarType type, context) => IconSnackBar.show(
  context: context,
  snackBarType: type,
  label: text,
);

void showToast2(String text, asd, context) => IconSnackBar.show(
  context: context,
  snackBarType: asd as SnackBarType,
  label: text,
);
//OTHER

// Widget buildProductDetails({String? name, String? img}) {
//   return Card(
//     elevation: 4.0,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(8.0),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         ClipRRect(
//           child: Image.network(
//             img!,
//             height: 50.0,
//             width: 50,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 name!,
//                 style: const TextStyle(
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget columnHomeItems({required ProductModel product}) {
//   return Column(
//     children: [
//       SizedBox(
//         height: 100,
//         width: double.maxFinite,
//         child: ClipRRect(
//             borderRadius: BorderRadius.circular(15),
//             child: Image.network(
//               product.productImgID,
//               fit: BoxFit.cover,
//             )),
//       ),
//       const SizedBox(
//         height: 30,
//       ),
//       Row(
//         children: [
//           Text(
//             "${product.productPrice} ريال",
//             style: fontArabicA(size: 10, textColor: Colors.green),
//           ),
//           const Spacer(),
//           Text(
//             product.productTitle,
//             style: fontArabicA(fontWeight: FontWeight.bold, size: 10),
//           ),
//         ],
//       ),
//       const SizedBox(
//         height: 10,
//         width: 10,
//       ),
//       Text(
//         product.productDescription,
//         overflow: TextOverflow.ellipsis,
//         style: fontArabicA(size: 10),
//       ),
//       SizedBox(
//         height: 10,
//         width: 10,
//       ),
//     ],
//   );
// }
