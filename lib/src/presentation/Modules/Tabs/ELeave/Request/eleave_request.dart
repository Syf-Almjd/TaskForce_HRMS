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

import '../../../../../data/local/localData_cubit/local_data_cubit.dart';
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
  String userName = "Unknown";

  @override
  void initState() {
    LocalDataCubit.get(context).getEleaveStatus(context);

    super.initState();
    getData();
  }

  getData() async {
    userName = await LocalDataCubit.get(context)
        .getCurrentUser(context)
        .then((value) => value.name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_locationLatitude == null || _locationLongitude == null) getLocation();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Eleave Request"),
      ),
      body: ListView(
        children: [
          getCube(5, context),
          (_imageBytes == null || _locationLatitude == null)
              ? IconButton(
                  onPressed: () {
                    startRequest();
                  },
                  icon: Icon(
                    Icons.filter_tilt_shift_rounded,
                    color: AppColors.primaryColor,
                    size: getWidth(50, context),
                  ),
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
                            requestInfo: requestText.text,
                            userName: userName)),
                    OutlinedButton(
                        onPressed: () {
                          NaviCubit.get(context).navigateOff(context, widget);
                        },
                        child: const Text("Try again"))
                  ],
                ),
          getCube(5, context),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: TextField(
              controller: requestText,
              enableSuggestions: true,
              minLines: 1,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: context.getAppAssets.leaveRequestText),
              textAlign: TextAlign.center,
            ),
          ),
          getCube(5, context),
          loadButton(
            textSize: getWidth(4, context),
            buttonText: context.getAppAssets.recordEleave,
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

  Future<void> uploadEleave() async {
    var requestEleave = EleaveModel(
        userUID: FirebaseAuth.instance.currentUser!.uid,
        dateTime: DateTime.now().toString(),
        userCity: "No City Detected",
        userPhoto: _imageBytes.toString(),
        requestInfo: requestText.text,
        userLocationLatitude: _locationLatitude!,
        userLocationLongitude: _locationLongitude!,
        userName: userName);

    if (mounted) {
      await RemoteDataCubit.get(context)
          .recordEleaveRequest(requestEleave, context)
          .whenComplete(() => NaviCubit.get(context).pop(context));
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
    }
  }
}
