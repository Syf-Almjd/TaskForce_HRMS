import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_extensions.dart';
import 'package:taskforce_hrms/src/config/utils/styles/app_colors.dart';
import 'package:taskforce_hrms/src/presentation/Shared/Components.dart';
import 'package:taskforce_hrms/src/presentation/Shared/WidgetBuilders.dart';

import '../../../../../data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import '../../../../../domain/Models/eLeaveModel.dart';
import '../../../../Cubits/navigation_cubit/navi_cubit.dart';
import '../../../../Shared/geoLocator.dart';
import '../History/Builders/eleave_history_card.dart';

class EleaveRequestScreen extends StatefulWidget {
  const EleaveRequestScreen({super.key});

  @override
  State<EleaveRequestScreen> createState() => _EleaveRequestScreenState();
}

class _EleaveRequestScreenState extends State<EleaveRequestScreen> {
  TextEditingController requestText = TextEditingController();
  String? _locationLatitude;
  String? _locationLongitude;
  String? _imageBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eleave Request"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (_imageBytes == null || _locationLatitude == null)
              ? Icon(
                  Icons.document_scanner_outlined,
                  color: AppColors.primaryColor,
                  size: getWidth(50, context),
                )
              : Column(
                  children: [
                    EleaveHistoryCard(
                        eleaveRecord: EleaveModel(
                            userUID: FirebaseAuth.instance.currentUser!.uid,
                            dateTime: DateTime.now().toString(),
                            userLocationLatitude: _locationLatitude!,
                            userLocationLongitude: _locationLongitude!,
                            userPhoto: _imageBytes.toString(),
                            userCity:
                                'Accurate Location: $_locationLongitude: $_locationLatitude',
                            requestInfo: requestText.text)),
                    OutlinedButton(
                        onPressed: () {
                          NaviCubit.get(context).navigateOff(context, widget);
                        },
                        child: const Text("Try again"))
                  ],
                ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: TextField(
              controller: requestText,
              enableSuggestions: true,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 1,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: context.getAppAssets.leaveRequestText),
              textAlign: TextAlign.center,
            ),
          ),
          loadButton(
            textSize: getWidth(4, context),
            buttonText: context.getAppAssets.recordAttendance,
            onPressed: () {
              startRequest();
            },
          ),
        ],
      ),
    );
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
        startRequest();
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
        startRequest();
      }
    } catch (e) {
      if (mounted) showToast("Error: $e", Colors.red, context);
    }
  }

  Future<void> uploadEleave() async {
    String city = await getLocationName(
        latitude: _locationLatitude!, longitude: _locationLongitude!);
    var requestEleave = EleaveModel(
        userUID: FirebaseAuth.instance.currentUser!.uid,
        dateTime: DateTime.now().toString(),
        userCity: city,
        userPhoto: _imageBytes.toString(),
        requestInfo: requestText.text,
        userLocationLatitude: _locationLatitude!,
        userLocationLongitude: _locationLongitude!);
    if (mounted) {
      await RemoteDataCubit.get(context)
          .recordEleaveRequest(requestEleave, context);
    }
  }

  void startRequest() {
    if (_imageBytes == null) _pickFile();
    if (_locationLatitude == null || _locationLongitude == null) getLocation();
    if (requestText.text.isEmpty) {
      showToast(
          "Please write request information", AppColors.scaffoldColor, context);
    }

    if (_locationLatitude != null &&
        _locationLongitude != null &&
        _imageBytes != null &&
        requestText.text.isNotEmpty) {
      uploadEleave();
      NaviCubit.get(context).pop(context);
    }
  }
}
