import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_enums.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_extensions.dart';
import 'package:taskforce_hrms/src/config/utils/styles/app_colors.dart';
import 'package:taskforce_hrms/src/domain/Models/announcementModel.dart';
import 'package:taskforce_hrms/src/presentation/Cubits/app_localization/app_localization_cubit.dart';
import 'package:taskforce_hrms/src/presentation/Shared/Components.dart';

import '../../../../Shared/WidgetBuilders.dart';

class AnnouncementList extends StatefulWidget {
  final AnnouncementModel announcementModel;

  const AnnouncementList({Key? key, required this.announcementModel})
      : super(key: key);

  @override
  _AnnouncementListState createState() => _AnnouncementListState();
}

class _AnnouncementListState extends State<AnnouncementList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: getWidth(100, context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.primaryColor),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                previewImage(
                    editable: false,
                    context: context,
                    fileUser: widget.announcementModel.image),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: getWidth(50, context),
                        child: Text(
                          widget.announcementModel.title.toCapitalize(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.darkColor,
                            fontWeight: FontWeight.bold,
                            fontSize: getWidth(5, context),
                          ),
                        ),
                      ),
                      Text(
                        widget.announcementModel.date,
                        style: TextStyle(
                          color: AppColors.greyDark,
                          fontWeight: FontWeight.normal,
                          fontSize: getWidth(4, context),
                        ),
                      ),
                      Text(widget.announcementModel.description,
                          style: TextStyle(
                            color: AppColors.darkColor,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.ellipsis,
                            fontSize: getWidth(3, context),
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.start),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FilledButton(
                      onPressed: () {
                        AppLocalizationCubit.get(context).changeAppLanguage(
                            context,
                            setLanguage: appLanguages.arabic);
                      },
                      child: Text(getAppAssets(context).read)),
                )
              ],
            ),
          ),
        ),
        // Divider(
        //   endIndent: getWidth(20, context),
        //   indent: getWidth(20, context),
        //   thickness: 1,
        //   color: AppColors.lowPriority.withOpacity(.3),
        // ),
        getCube(1, context)
      ],
    );
  }
}
