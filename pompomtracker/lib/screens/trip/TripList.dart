import 'package:pompomtracker/core/hook/hook.dart';

class ScreenTripList extends StatefulWidget {
  const ScreenTripList({super.key});

  @override
  State<ScreenTripList> createState() => _ScreenTripListState();
}

class _ScreenTripListState extends State<ScreenTripList> {
  List<String> columns = [];
  List<String?> cells = [];
  List<BusRegList>? busreglist = [];
  List<String> registarionlst = [];
  String? selectedBusList;
  // final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      busreglist = await Wklycollectfn.instance.busReglistfn(context);
      setState(() {
        registarionlst =
            busreglist!.map((bus) => bus.registrationNo ?? "").toList();
      });
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
        //log('BackButton pressed!');
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
            'Trip List',
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onSecondary),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Theme(
                        data: MyTheme.googleFormTheme,
                        child: Column(children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonFormField(
                              items: registarionlst.map((valueItem) {
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(
                                    valueItem,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedBusList = newValue;

                                  //TripListFuntions.instance.getTripList();
                                });
                              },
                              value: selectedBusList,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                              icon: Theme(
                                data: Theme.of(context),
                                child: const Icon(
                                  Icons.arrow_drop_down,
                                ),
                              ),
                              decoration: InputDecoration(
                                labelText: 'Select Bus',
                                labelStyle:
                                    Theme.of(context).textTheme.bodySmall,
                              ),
                              dropdownColor:
                                  Theme.of(context).colorScheme.tertiary,
                              validator: (value) {
                                if (value == null) {
                                  return 'Select Bus Type';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Theme.of(context).colorScheme.primary,
                                  Theme.of(context).colorScheme.secondary,
                                ],
                              ),
                            ),
                            child: Theme(
                              data: MyTheme.buttonStyleTheme,
                              child: ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<ElevatedBtnProvider>()
                                      .changeSelectedVal(false);
                                  TripListFuntions.instance
                                      .getTripList(selectedBusList);
                                  context
                                      .read<ElevatedBtnProvider>()
                                      .changeSelectedVal(true);
                                },
                                child: Text('SHOW',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                              ),
                            ),
                          ),
                        ]))),
              ),
            ),
            Consumer<ElevatedBtnProvider>(
                builder: (context, widgetProvider, child) {
              if (widgetProvider.selectedVal == false) {
                return Container();
              } else if (widgetProvider.selectedVal == true) {
                return Expanded(child: ScrollableWidget(child: tableDispay()));
              }
              return Container();
            }),
          ],
        ),
      ),
    );
  }

  Widget tableDispay() {
    return ValueListenableBuilder(
        valueListenable: TripListFuntions.instance.getTripListNotifier,
        builder: (BuildContext context, List<Listdet> newList, Widget? _) {
          return Column(
            children: [
              if (newList.isNotEmpty) ...[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.onSecondary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DataTable(
                    columns: getColumns(columns = [
                      'S.No',
                      'Reg No',
                      'Trip',
                      'Start T',
                      'End T',
                      'Action',
                    ]),
                    rows: getRows(newList),
                  ),
                ),
              ] else ...[
                FutureBuilder(
                  future: Future.delayed(
                      const Duration(seconds: 10)), // Add a delay of 5 seconds
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height / 2.5,
                            horizontal: MediaQuery.of(context).size.width / 2.3,
                          ),
                          child: const CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      // After 5 seconds, show the No Data Found image
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height / 2.5,
                            horizontal: MediaQuery.of(context).size.width / 2.7,
                          ),
                          child: Text(
                            'No data found',
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ]
            ],
          );
        });
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
        task.tripName ?? '',
        task.startTime ?? '',
        task.endTime ?? '',
      ];
      return DataRow(
        cells: [
          DataCell(
            Center(
              child: Text(
                '$index', // Display the serial number
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondary),
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
                        : TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.onSecondary)),
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
                        builder: (context) => ScreenTrip(
                            trip_id: task.tripId,
                            regNo: task.registratioNo,
                            flag: 1),
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
