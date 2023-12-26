// AppCubit.get(context).updateSharedUser();
// add it later

import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_constants.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_extensions.dart';
import 'package:taskforce_hrms/src/presentation/Shared/Components.dart';

import '../../../config/utils/managers/app_enums.dart';
import '../../Shared/WidgetBuilders.dart';
import 'Builders/sections_icon.dart';

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
    return Scaffold(
      body: ListView(
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
                        editable: false, fileUser: "NOPHOTO", context: context),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: getHeight(10, context),
            width: getWidth(90, context),
            child: ListView.builder(
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
          NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is OverscrollNotification &&
                    notification.overscroll < 0) {
                  Scrollable.ensureVisible(
                    context,
                    alignment: 0.0, // 0.0 aligns to the top, 1.0 to the bottom
                  );
                  return true; // Prevent the nested list from scrolling
                }
                return false;
              },
              child: Container(
                  margin: const EdgeInsets.all(20),
                  child: getAppTabByIndex(currentTab)))
        ],
      ),
    );
  }
}
