import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/domain/Models/eLeaveModel.dart';

import '../../../../../../config/utils/styles/app_colors.dart';
import '../../../../../Shared/Components.dart';
import '../../../../../Shared/WidgetBuilders.dart';

class EleaveHistoryCard extends StatelessWidget {
  final EleaveModel eleaveRecord;
  const EleaveHistoryCard({super.key, required this.eleaveRecord});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: getWidth(100, context),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(10),
          // color: AppColors.greyDark.withOpacity(0.1),
        ),
        child: Wrap(
          direction: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: getHeight(10, context),
                width: getWidth(20, context),
                alignment: Alignment.centerLeft,
                child: previewImage(
                    padding: 0,
                    photoRadius: 5,
                    // backgroundColor: AppColors.primaryColor,
                    editable: false,
                    context: context,
                    fileUser: eleaveRecord.userPhoto),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: getWidth(50, context),
                    child: Text(
                      getDateTimeToDay(eleaveRecord.dateTime),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.bold,
                        fontSize: getWidth(5, context),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: getWidth(50, context),
                    child: Text(
                      eleaveRecord.requestInfo,
                      style: TextStyle(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.normal,
                        overflow: TextOverflow.ellipsis,
                        fontSize: getWidth(3, context),
                      ),
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  eleaveRecord.userCity,
                  style: TextStyle(
                    color: AppColors.greyDark,
                    fontWeight: FontWeight.normal,
                    fontSize: getWidth(4, context),
                  ),
                ),
              ),
            ),
          ],
        ),
        // Divider(
        //   endIndent: getWidth(17, context),
        //   indent: getWidth(17, context),
        //   thickness: 1,
        //   color: AppColors.darkColor.withOpacity(.3),
        // ),
      ),
    );
  }
}
