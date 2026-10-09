import 'package:flutter/material.dart';
import 'package:pompomtracker/core/shared_preference/shared_preference_manage.dart';
import 'package:pompomtracker/function/track/busTrackFun.dart';
import 'package:pompomtracker/model/bus_master/bus_list_req/bus_list_req.dart';
import 'package:pompomtracker/model/track/real_bus_det/bus_list.dart';
import 'package:pompomtracker/screens/track/announcement/announcement_service.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  List<BusDetList>? realtmBuslist = [];
  List<BusDetList>? realtmBus = [];
  BusDetList? selectedBus;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final sharedValue =
                      await SharedPrefManager.instance.getSharedData();
                  final usrid = sharedValue!.userId;
                  final value = BusListReq(userId: usrid);

                  realtmBuslist = await BusTrackFunctions.instance
                      .realbusdet(value, context);

                  print("Bus Count : ${realtmBuslist?.length}");

                  for (final bus in realtmBuslist ?? []) {
                    print(
                        "Bus=${bus.busId} Trip=${bus.tripId} Status=${bus.tripStatus}");
                  }
                  final runningBus = realtmBuslist?.firstWhere(
                    (b) => b.tripStatus == "1",
                    orElse: () => throw Exception("No running trip"),
                  );

                  if (runningBus != null) {
                    await AnnouncementService.instance.start(
                      context: context,
                      bus: runningBus,
                    );
                  }
                },
                child: Text("Trip Start"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await AnnouncementService.instance.stop();
                },
                child: const Text("Trip End"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
