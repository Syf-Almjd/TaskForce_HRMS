import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/domain/Models/eventModel.dart';
import 'package:taskforce_hrms/src/presentation/Shared/Components.dart';
import 'package:taskforce_hrms/src/presentation/Shared/WidgetBuilders.dart';

import '../../../../Shared/MapsLauncher.dart';

class EventReadScreen extends StatelessWidget {
  final EventModel eventModel;

  const EventReadScreen({super.key, required this.eventModel});

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
              eventModel.title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              getDateTimeToDay(eventModel.datePublished),
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
              "Event in ${getDateTimeToDay(eventModel.date)}",
              style: const TextStyle(
                fontSize: 16.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16.0),
            previewImage(fileUser: eventModel.image, context: context),
            const SizedBox(height: 16.0),
            Text(
              eventModel.description,
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.date_range_rounded),
              title: const Text('Event Date'),
              subtitle: Text(eventModel.date),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Event Location'),
              subtitle: Text(eventModel.locationName),
            ),
            TextButton.icon(
              style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.all(20))),
              onPressed: () {
                MapsLauncher.launchCoordinates(
                    eventModel.locationLatitude, eventModel.locationLongitude);
              },
              label: const Text("Open in Maps"),
              icon: const Icon(Icons.map_sharp),
            ),
          ],
        ),
      ),
    );
  }
}
