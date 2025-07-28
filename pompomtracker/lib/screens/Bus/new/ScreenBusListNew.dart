import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/screens/Bus/new/ScreenBusMasterNew.dart';

class ScreenBusListNew extends StatefulWidget {
  const ScreenBusListNew({super.key});

  @override
  State<ScreenBusListNew> createState() => _ScreenBusListNewState();
}

class _ScreenBusListNewState extends State<ScreenBusListNew> {
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
     Navigator.pushReplacement(context, Approutes().busmasternewscreen);

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
      child: Stack(
        children: [
          BackgroundColorGradient(),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back,color: Colors.white,),
                onPressed: () {
                 Navigator.pushReplacement(context, Approutes().busmasternewscreen);
          
                },
              ),
              title: Text(
                'Bus List',
                style: TextStyle(color: Colors.white),
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
                                    dataRowMaxHeight: 35,
                                    dataRowMinHeight: 35,
                                    headingRowHeight: 35,
                                    columnSpacing: 15,
                                    headingTextStyle:TextStyle(color: Colors.white),
                                    headingRowColor: WidgetStateProperty.all(
                                        Color.fromARGB(255, 204, 123, 2)),
                                    columns: getColumns(columns = [
                                      'S.No',
                                      'Bus Name',
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
        ],
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
        task.busName??'',
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
                            fontWeight: FontWeight.bold,)
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
                            ScreenBusMasterNew(regNo: task.registrationNo, flag: 1),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Color.fromARGB(255, 204, 123, 2),
                  )),
            ),
          ),
        ],
      );
    }).toList();
  }
}
