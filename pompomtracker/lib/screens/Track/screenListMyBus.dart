
import 'dart:developer';

import 'package:pompomtracker/core/hook/hook.dart';
import 'package:sizer/sizer.dart';

class ScreenListMyBus extends StatefulWidget {
  const ScreenListMyBus({super.key});

  @override
  State<ScreenListMyBus> createState() => _ScreenListMyBusState();
}

class _ScreenListMyBusState extends State<ScreenListMyBus> {
  List<BusDetList>? realtmBuslist = [];
  List<String> columns = [];
  List<String?> cells = [];
  String? busId;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize(context));
  }
   Future<void> _initialize(BuildContext context) async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final usrid = sharedValue!.userId;
    final value = BusListReq(userId: usrid);
    if (!context.mounted) return;
          await BusTrackFunctions.instance.realbusdet(value, context);
    if (!context.mounted) return;

       Livelocationfun.instance.startTracking(
      context: context,
      onLocationUpdate: (position) async {
        if (position.latitude != 0 && position.longitude != 0) {
          // if (!mounted) return;
          // setState(() {
          //   isLoading = false;
          //   _starting = LatLng(position.latitude, position.longitude);
          // });

        }
      },
    );    
  }
  Future<bool?> popscreen(BuildContext context) async {
    BusTrackFunctions.instance.getRealBusDetailsNotifier.value=[];

    Navigator.pushReplacement(context, Approutes().mainScreen);
    return true;
  }
    messageBox(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "No Active Trips",
          style: TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        content: Text(
          "There is no active trip available. You can't track your bus.",
          style: TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "OK",
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (!didPop) {
          if (didPop) return;
          await popscreen(context);
        }
        log('BackButton pressed!');
      },
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              leading: IconButton(
                  onPressed: () {
                   BusTrackFunctions.instance.getRealBusDetailsNotifier.value=[];

                    Navigator.pushReplacement(context, Approutes().mainScreen);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white)),
              title: const Text(
                'My Bus',
                style: TextStyle(color: Colors.white),
              ),
              
            ),
            body: Column(
              children: [
                Expanded(
                  child: ScrollableWidget(
                    child: ValueListenableBuilder(
                        valueListenable: BusTrackFunctions.instance.getRealBusDetailsNotifier,
                        builder: (BuildContext context, List<BusDetList> data ,Widget? _) {
                          
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (data.isNotEmpty) ...[
                                
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black),
                                  ),
                                  child: DataTable(
                                    showCheckboxColumn: false, 
                                    dataRowMaxHeight: 35,
                                    dataRowMinHeight: 35,
                                    headingRowHeight: 35,
                                    columnSpacing: 8,
                                    headingRowColor: WidgetStateProperty.all(
                                        Color.fromARGB(255, 204, 123, 2)),
                                    columns: getColumns(columns = [
                                      'S.No',
                                      'Reg No',
                                      'Bus Name',
                                      'Track Bus',
                                    ]),
                                    rows: getRows(data),
                                  ),
                                ),
                              ] else ...[
                                FutureBuilder(
                                  future: Future.delayed(const Duration(
                                      seconds: 10)), // Add a delay of 5 seconds
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2.5,
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.3,
                                          ),
                                          child:
                                              const CircularProgressIndicator(
                                                  color: Color.fromARGB(
                                                      255, 204, 123, 2)),
                                        ),
                                      );
                                    } else {
                                      // After 5 seconds, show the No Data Found image
                                      return Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2.5,
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.7,
                                          ),
                                          child: Text(
                                            'No data found',
                                            style: TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ]
                            ],
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      return DataColumn(
        label: Text(
          column,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white),
        ),
      );
    }).toList();
  }

  List<DataRow> getRows(List<BusDetList> newList) {
    return newList.asMap().entries.map((entry) {
      int index = entry.key + 1; // Serial number starts from 1
      BusDetList task = entry.value;
      
      cells = [
        task.registrationNo ?? '',
        task.busName ?? '',
      ];
      return DataRow(
        onSelectChanged: (_) {
        busId=task.busId;
                 task.tripStatus=='0'? 
                 messageBox(context): 
                 Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>  ScreenMapTrack(task:task,),
                                ),
                              );
      },
        cells: [
        DataCell(
          Center(
            child: Text(
              '$index', // Display the serial number
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
        ...Utils.modelBuilder(cells, (index, cell) {
          final taskbold = index == 0;
          return DataCell(
            Center(
              child: Text('$cell',
                  style: taskbold
                      ? const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)
                      : const TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.black)),
            ),
          );
        }),
        DataCell(
          Center(
            child: task.tripStatus=='0'? 
                Icon(Icons.location_off_rounded,
                          size: 20, color: Colors.red[600])
                      : Icon(Icons.location_on_rounded,
                          size: 20, color: Colors.green[600])
          ),
        ),
      ]);
    }).toList();
  }
}