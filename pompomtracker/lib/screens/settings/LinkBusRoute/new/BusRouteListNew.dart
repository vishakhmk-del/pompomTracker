import 'dart:developer';

import 'package:pompomtracker/core/hook/hook.dart';

class BusRouteListNew extends StatefulWidget {
  const BusRouteListNew({super.key});

  @override
  State<BusRouteListNew> createState() => _BusRouteListNewState();
}

class _BusRouteListNewState extends State<BusRouteListNew> {
  List<String> columns = [];
  List<String?> cells = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await BusRouteListFunctions.instance.getBusRouteList();
    });
  }

  Future<bool?> popscreen(BuildContext context) async {
    // Navigator.push(context, Approutes().linkbusrouteNewscreen);
    BusRouteListFunctions.instance.getBusRouteListNotifier.value = [];
    Navigator.pushReplacement(context, Approutes().linkbusrouteNewscreen);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (!didPop) {
          if (didPop) return;
          await popscreen(context);
        }
        log('BackButton pressed!');
      },
      child: Stack(
        children: [
          // BackgroundColorGradient(),
          Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              leading: IconButton(
                  onPressed: () {
                    BusRouteListFunctions
                        .instance.getBusRouteListNotifier.value = [];

                    Navigator.pushReplacement(
                        context, Approutes().linkbusrouteNewscreen);
                    //  Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white)),
              title: const Text(
                'Bus Route List',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ScrollableWidget(
                    child: ValueListenableBuilder(
                        valueListenable: BusRouteListFunctions
                            .instance.getBusRouteListNotifier,
                        builder: (BuildContext context, List<Listdet> newList,
                            Widget? _) {
                          return Column(
                            children: [
                              if (newList.isNotEmpty) ...[
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    //borderRadius:const BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                                  ),
                                  child: DataTable(
                                    dataRowMaxHeight: 35,
                                    dataRowMinHeight: 35,
                                    headingRowHeight: 35,
                                    columnSpacing: 15,
                                    headingRowColor: WidgetStateProperty.all(
                                        Color.fromARGB(255, 204, 123, 2)),
                                    columns: getColumns(columns = [
                                      'S.No',
                                      'Reg No',
                                      // 'Route',
                                      // 'Via',
                                      'Permit No',
                                      'Action',
                                    ]),
                                    rows: getRows(newList),
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
                                                255, 204, 123, 2),
                                          ),
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
                                            style:
                                                TextStyle(color: Colors.black),
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

  List<DataRow> getRows(List<Listdet> newList) {
    return newList.asMap().entries.map((entry) {
      int index = entry.key + 1; // Serial number starts from 1
      Listdet task = entry.value;
      cells = [
        task.registratioNo ?? '',
        // task.routeName ?? '',
        // task.via ?? '',
        task.permitNo ?? ''
      ];
      return DataRow(cells: [
        //
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
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ScreenLinkBusRouteNew(
                            registrationNumber: task.registratioNo,
                            permitId: task.permitId,
                            busId: task.busId,
                            flag: 1)),
                  );
                },
                icon: Icon(
                  Icons.edit,
                  color: Color.fromARGB(255, 204, 123, 2),
                )),
          ),
        ),
      ]);
    }).toList();
  }
}
