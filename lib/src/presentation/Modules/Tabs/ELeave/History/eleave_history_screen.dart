import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'package:taskforce_hrms/src/domain/Models/eLeaveModel.dart';
import 'package:taskforce_hrms/src/presentation/Shared/Components.dart';

import 'Builders/eleave_history_card.dart';

class EleaveHistoryScreen extends StatefulWidget {
  const EleaveHistoryScreen({super.key});

  @override
  State<EleaveHistoryScreen> createState() => _EleaveHistoryScreenState();
}

class _EleaveHistoryScreenState extends State<EleaveHistoryScreen> {
  List<EleaveModel> eleaveList = [];
  bool _isloaded = false;

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
      List<EleaveModel> data = await RemoteDataCubit.get(context)
          .getUserEleaveHistory(context)
          .then((value) => value.cast<EleaveModel>().reversed.toList());
      if (mounted) {
        setState(() {
          eleaveList = data;
          _isloaded = true;
        });
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eleave History"),
      ),
      body: Visibility(
        visible: _isloaded,
        replacement: loadingAnimation(),
        child: eleaveList.isEmpty
            ? const Center(child: Text("There are no records yet. All Set!"))
            : ListView(
                children: List.generate(eleaveList.length, (index) {
                  return Column(
                    children: [
                      EleaveHistoryCard(eleaveRecord: eleaveList[index]),
                      if (index != eleaveList.length - 1) getDivider(context)
                    ],
                  );
                }),
              ),
      ),
    );
  }
}
