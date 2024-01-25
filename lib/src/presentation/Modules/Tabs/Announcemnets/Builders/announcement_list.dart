import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_extensions.dart';
import 'package:taskforce_hrms/src/config/utils/styles/app_colors.dart';
import 'package:taskforce_hrms/src/domain/Models/announcementModel.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: getWidth(100, context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              previewImage(
                  editable: false,
                  context: context,
                  fileUser: widget.announcementModel.image),
              Padding(
                padding: const EdgeInsets.all(12.0),
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
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 12),
                child: Text(widget.announcementModel.description,
                    style: TextStyle(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.ellipsis,
                      fontSize: getWidth(3, context),
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.start),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      getDateTimeToDay(widget.announcementModel.date),
                      style: TextStyle(
                        color: AppColors.greyDark,
                        fontWeight: FontWeight.normal,
                        fontSize: getWidth(4, context),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FilledButton(
                        onPressed: () {},
                        child: Text(context.getAppAssets.read)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
