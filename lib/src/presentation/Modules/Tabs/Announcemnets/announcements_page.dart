import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_enums.dart';
import 'package:taskforce_hrms/src/data/remote/RemoteData_cubit/RemoteData_cubit.dart';

import '../../../../domain/Models/announcementModel.dart';
import '../../../Shared/WidgetBuilders.dart';
import 'Builders/announcement_list.dart';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  List<AnnouncementModel> announcementList = [];
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  Future<void> getData() async {
    try {
      List<AnnouncementModel> data = await RemoteDataCubit.get(context)
          .getAnnouncementPostsData()
          .then((value) =>
              value.cast<AnnouncementModel>().toList().reversed.toList());
      if (mounted) {
        setState(() {
          announcementList = data;
          loaded = true;
        });
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loaded,
      replacement: getSkeletonLoading(type: PostsType.announcements),
      child: Column(
        children: List.generate(
            announcementList.length,
            (index) =>
                AnnouncementList(announcementModel: announcementList[index])),
      ),
    );
  }
}
