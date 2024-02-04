import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/presentation/Shared/Components.dart';
import 'package:taskforce_hrms/src/presentation/Shared/WidgetBuilders.dart';

import '../../../../../domain/Models/announcementModel.dart';

class AnnouncementReadScreen extends StatelessWidget {
  final AnnouncementModel announcement;

  const AnnouncementReadScreen({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text('Announcement Details'),
          ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              announcement.title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              getDateTimeToDay(announcement.date),
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const Text(
              'By: PPK Admin',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            Text(
              announcement.date,
              style: const TextStyle(
                fontSize: 16.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16.0),
            previewImage(fileUser: announcement.image, context: context),
            const SizedBox(height: 16.0),
            Text(
              announcement.description,
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
