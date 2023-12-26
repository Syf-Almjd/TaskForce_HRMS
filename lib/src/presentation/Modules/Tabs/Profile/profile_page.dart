import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_extensions.dart';
import 'package:taskforce_hrms/src/config/utils/styles/app_colors.dart';
import 'package:taskforce_hrms/src/presentation/Cubits/navigation_cubit/navi_cubit.dart';
import 'package:taskforce_hrms/src/presentation/Modules/Tabs/Profile/Builders/profile_card.dart';
import 'package:taskforce_hrms/src/presentation/Shared/Components.dart';
import 'package:taskforce_hrms/src/presentation/Shared/WidgetBuilders.dart';
import 'package:taskforce_hrms/src/presentation/test.dart';

import '../../../../config/utils/managers/app_constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: getHeight(15, context),
              width: getWidth(30, context),
              child: previewImage(
                  fileUser: AppConstants.noPhotoUser, context: context),
            ),
            SizedBox(
              height: getHeight(15, context),
              width: getWidth(50, context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(context.getAppAssets.loading,
                      style: const TextStyle(
                          color: AppColors.blackLight,
                          fontWeight: FontWeight.bold)),
                  Text(context.getAppAssets.loading,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: AppColors.greyDark,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
        ...List.generate(
            AppConstants.profileCardsName.length,
            (index) => ProfileCard(
                  title: AppConstants.profileCardsName[index],
                  icon: AppConstants.profileCardsIcons[index],
                  onTap: () {
                    NaviCubit.get(context).navigate(context, const TestPage());
                  },
                )),
      ],
    );
  }
}
