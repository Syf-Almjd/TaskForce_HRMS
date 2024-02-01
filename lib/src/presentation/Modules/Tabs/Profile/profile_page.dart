import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/config/utils/styles/app_colors.dart';
import 'package:taskforce_hrms/src/domain/Models/UserModel.dart';
import 'package:taskforce_hrms/src/presentation/Modules/Tabs/Profile/Builders/profile_card.dart';
import 'package:taskforce_hrms/src/presentation/Shared/Components.dart';
import 'package:taskforce_hrms/src/presentation/Shared/WidgetBuilders.dart';

import '../../../../config/utils/managers/app_constants.dart';
import '../../../../data/local/localData_cubit/local_data_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel userModel = UserModel.loadingUser();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    userModel = UserModel.fromJson(
        await LocalDataCubit.get(context).getSharedMap(AppConstants.savedUser));

    if (mounted) {
      setState(() {});
    }
  }

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
                  padding: 20, fileUser: userModel.photoID, context: context),
            ),
            SizedBox(
              height: getHeight(15, context),
              width: getWidth(50, context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(userModel.name,
                      style: const TextStyle(
                          color: AppColors.blackLight,
                          fontWeight: FontWeight.bold)),
                  Text("Last Login: ${getDateTimeToDay(userModel.lastLogin)}",
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
                AppConstants.profileCardsPages[index](context, userModel);
              }),
        ),
      ],
    );
  }
}
