import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_extensions.dart';
import 'package:taskforce_hrms/src/domain/Models/eventModel.dart';

import '../../../../../config/utils/managers/app_enums.dart';
import '../../../../../config/utils/styles/app_colors.dart';
import '../../../../Cubits/app_localization/app_localization_cubit.dart';
import '../../../../Shared/Components.dart';
import '../../../../Shared/WidgetBuilders.dart';

class EventsList extends StatelessWidget {
  final EventModel event;
  const EventsList({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
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
                    fileUser: event.image),
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
                      event.title.toCapitalize(),
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
                      event.description,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      getDateTimeToDay(event.date),
                      style: TextStyle(
                        color: AppColors.greyDark,
                        fontWeight: FontWeight.normal,
                        fontSize: getWidth(4, context),
                      ),
                    ),
                    FilledButton(
                        onPressed: () {
                          AppLocalizationCubit.get(context).changeAppLanguage(
                              context,
                              setLanguage: appLanguages.english);
                        },
                        child: Text(context.getAppAssets.location)),
                  ],
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
