import 'package:pompomtracker/core/hook/hook.dart';

class ScreenBusList extends StatefulWidget {
  const ScreenBusList({super.key});

  @override
  State<ScreenBusList> createState() => _ScreenBusListState();
}

class _ScreenBusListState extends State<ScreenBusList> {
  List<String> columns = [];
  List<String?> cells = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await BusListFunctions.instance.getBusDetails();
    });
  }

  Future<bool?> popscreen(BuildContext context) async {
    Navigator.push(context, Approutes().homescreen);
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
        //  log('BackButton pressed!');
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(context, Approutes().homescreen);
            },
          ),
          title: Text(
            'Bus List',
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ScrollableWidget(
                child: ValueListenableBuilder(
                    valueListenable:
                        BusListFunctions.instance.getBusListNotifier,
                    builder: (BuildContext context, List<BusList> newList,
                        Widget? _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                columns: getColumns(columns = [
                                  'S.No',
                                  'Reg No',
                                  'Permit No',
                                  'Valid To',
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

  List<DataRow> getRows(List<BusList> newList) {
    return newList.asMap().entries.map((entry) {
      int index = entry.key + 1; // Serial number starts from 1
      BusList task = entry.value;
      cells = [
        task.registrationNo ?? '',
        task.permitNo ?? '',
        task.validTo ?? '',
      ];
      return DataRow(
        cells: [
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
                        builder: (context) =>
                            ScreenBusMater(regNo: task.registrationNo, flag: 1),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.primary,
                  )),
            ),
          ),
        ],
      );
    }).toList();
  }
}
