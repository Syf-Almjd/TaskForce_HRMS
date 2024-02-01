import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_extensions.dart';
import 'package:taskforce_hrms/src/data/local/localData_cubit/local_data_cubit.dart';
import 'package:taskforce_hrms/src/data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'package:taskforce_hrms/src/domain/Models/attendanceModel.dart';
import 'package:taskforce_hrms/src/presentation/Cubits/navigation_cubit/navi_cubit.dart';
import 'package:taskforce_hrms/src/presentation/Shared/Components.dart';

import '../../../../../config/utils/styles/app_colors.dart';
import '../../../../Shared/WidgetBuilders.dart';
import '../../../../Shared/geoLocator.dart';
import '../History/Builders/attend_history_card.dart';

class AttendScreen extends StatefulWidget {
  const AttendScreen({super.key});

  @override
  State<AttendScreen> createState() => _AttendScreenState();
}

class _AttendScreenState extends State<AttendScreen> {
  bool showAttendanceInfo = false;
  String? _locationLatitude;
  String? _locationLongitude;
  String? _imageBytes;

  @override
  void initState() {
    LocalDataCubit.get(context).getAttendanceStatus(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_locationLatitude == null || _locationLongitude == null) getLocation();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (_imageBytes == null || _locationLatitude == null)
              ? IconButton(
                  onPressed: () {
                    sendRecord();
                  },
                  icon: Icon(
                    Icons.recent_actors_outlined,
                    color: AppColors.primaryColor,
                    size: getWidth(50, context),
                  ),
                )
              : Column(
                  children: [
                    AttendanceHistoryCard(
                        attendanceRecord: AttendanceModel(
                            userUID: FirebaseAuth.instance.currentUser!.uid,
                            dateTime: DateTime.now().toString(),
                            userLocationLatitude: _locationLatitude!,
                            userLocationLongitude: _locationLongitude!,
                            userPhoto: _imageBytes.toString(),
                            userCity:
                                'Accurate Location: $_locationLongitude: $_locationLatitude')),
                    OutlinedButton(
                        onPressed: () {
                          NaviCubit.get(context).navigateOff(context, widget);
                        },
                        child: const Text("Try again"))
                  ],
                ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text(
              context.getAppAssets.attendanceWaring,
              textAlign: TextAlign.center,
            ),
          ),
          loadButton(
            textSize: getWidth(4, context),
            buttonText: context.getAppAssets.recordAttendance,
            onPressed: () {
              sendRecord();
            },
          ),
        ],
      ),
    );
  }

  void sendRecord() {
    if (_imageBytes == null) _pickFile();
    if (_locationLatitude != null &&
        _locationLongitude != null &&
        _imageBytes != null) {
      uploadAttendance();
    }
  }

  void _pickFile() async {
    try {
      final picker = ImagePicker();
      final pickedFile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
      if (mounted && pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        Uint8List bytesUint8List = Uint8List.fromList(bytes);
        setState(() {
          _imageBytes = base64Encode(bytesUint8List);
        });
      }
    } catch (e) {
      if (mounted) showToast("Error: $e", Colors.red, context);
    }
  }

  Future<void> getLocation() async {
    try {
      Position position = await getGeoPosition();
      if (mounted) {
        setState(() {
          _locationLongitude = position.longitude.toString();
          _locationLatitude = position.latitude.toString();
        });
      }
    } catch (e) {
      if (mounted) showToast("Error: $e", Colors.red, context);
    }
  }

  Future<void> uploadAttendance() async {
    AttendanceModel recordAttendance = AttendanceModel(
        userUID: FirebaseAuth.instance.currentUser!.uid,
        dateTime: DateTime.now().toString(),
        userLocationLatitude: _locationLatitude!,
        userLocationLongitude: _locationLongitude!,
        userPhoto: _imageBytes.toString(),
        userCity: "No City Detected");

    if (mounted) {
      RemoteDataCubit.get(context)
          .recordTodayAttendance(recordAttendance, context);
      NaviCubit.get(context).pop(context);
    }
  }
}
