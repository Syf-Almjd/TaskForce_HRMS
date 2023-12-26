import 'package:flutter/material.dart';

import '../../../../config/utils/managers/app_enums.dart';
import '../../../../data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import '../../../../domain/Models/eventModel.dart';
import '../../../Shared/WidgetBuilders.dart';
import 'Builders/events_list.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List<EventModel> eventsList = [];

  bool loaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    List<EventModel> data = await RemoteDataCubit.get(context)
        .getPostsData(PostsType.events)
        .then((value) => value.cast<EventModel>().toList());

    setState(() {
      eventsList = data;
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: loaded,
        replacement: getSkeletonLoading(type: PostsType.events),
        child: Column(
          children: List.generate(
              eventsList.length,
              (index) => EventsList(
                    event: eventsList[index],
                  )),
        ));
  }
}
