import 'dart:developer';

import 'package:pompomtracker/core/hook/hook.dart';

class BusRouteList extends StatefulWidget {
  const BusRouteList({super.key});

  @override
  State<BusRouteList> createState() => _BusRouteListState();
}

class _BusRouteListState extends State<BusRouteList> {
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
    Navigator.push(context, Approutes().mainScreen);
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
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, Approutes().mainScreen);
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text('Bus Route List'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ScrollableWidget(
                child: ValueListenableBuilder(
                    valueListenable:
                        BusRouteListFunctions.instance.getBusRouteListNotifier,
                    builder: (BuildContext context, List<Listdet> newList,
                        Widget? _) {
                      return Column(
                        children: [
                          if (newList.isNotEmpty) ...[
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary),
                                //borderRadius:const BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                              ),
                              child: DataTable(
                                dataRowMaxHeight: 35,
                                dataRowMinHeight: 35,
                                headingRowHeight: 35,
                                columnSpacing: 15,
                                headingRowColor: WidgetStateProperty.all(
                                    const Color(0xff13bc91)),
                                columns: getColumns(columns = [
                                  'S.No',
                                  'Reg No',
                                  'Route',
                                  'Via',
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
                                        vertical:
                                            MediaQuery.of(context).size.height /
                                                2.5,
                                        horizontal:
                                            MediaQuery.of(context).size.width /
                                                2.3,
                                      ),
                                      child: const CircularProgressIndicator(),
                                    ),
                                  );
                                } else {
                                  // After 5 seconds, show the No Data Found image
                                  return Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical:
                                            MediaQuery.of(context).size.height /
                                                2.5,
                                        horizontal:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                      ),
                                      child: Text(
                                        'No data found',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary),
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
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      return DataColumn(
        label: Text(
          column,
          style: Theme.of(context).textTheme.bodyLarge,
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
        task.routeName ?? '',
        task.via ?? '',
      ];
      return DataRow(cells: [
        //
        DataCell(
          Center(
            child: Text(
              '$index', // Display the serial number
              style: const TextStyle(fontWeight: FontWeight.bold),
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
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 88, 147, 250))
                      : const TextStyle(fontWeight: FontWeight.normal)),
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
                        builder: (context) => ScreenLinkBusRoute(
                            registrationNumber: task.registratioNo,
                            routeId: task.routeId,
                            flag: 1)),
                  );
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                )),
          ),
        ),
      ]);
    }).toList();
  }
}
