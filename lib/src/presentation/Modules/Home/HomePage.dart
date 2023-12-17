// AppCubit.get(context).updateSharedUser();
// add it later

import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_constants.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_extensions.dart';
import 'package:taskforce_hrms/src/presentation/Shared/Components.dart';

import '../../../config/utils/managers/app_enums.dart';
import '../../Shared/WidgetBuilders.dart';
import 'Builders/SectionsIcon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;
  List<AppTabsHeaders> headersTab = AppTabsHeaders.values.toList();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(milliseconds: 500));
        },
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      headersTab[currentTab].name.toCapitalize(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getWidth(5, context)),
                    ),
                    SizedBox(
                      height: getHeight(10, context),
                      width: getWidth(20, context),
                      child: previewImage(
                          editable: false,
                          fileUser: "NOPHOTO",
                          context: context),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: getHeight(10, context),
              width: getWidth(90, context),
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: AppConstants.homeTabs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SectionsIcon(
                      index: index,
                      onTap: () {
                        setState(() {
                          currentTab = index;
                        });
                      },
                      selectedTab: currentTab == index,
                    );
                  }),
            ),
            Container(
                padding: const EdgeInsets.all(20),
                height: getHeight(100, context),
                width: getWidth(100, context),
                child: getAppTabByIndex(currentTab)),
          ],
        ));
  }
}
