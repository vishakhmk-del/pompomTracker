import 'package:intl/intl.dart';
import 'package:pompomtracker/core/hook/hook.dart';

class ScreenEmployeeAssign extends StatefulWidget {
  const ScreenEmployeeAssign({super.key});

  @override
  State<ScreenEmployeeAssign> createState() => _ScreenEmployeeAssignState();
}

class _ScreenEmployeeAssignState extends State<ScreenEmployeeAssign> {
  List<String> columns = [];
  List<String?> cells = [];
  List<Emplist>? conductorlist = [];
  List<Emplist>? driverlist = [];
  List<String> condNamelst = [];
  List<String> driverNamelst = [];
  String? selectedcondName;
  String? selecteddriverName;
  List<Map<String, Object>> conductorNamelist = [];
  List<Map<String, Object>> driverNamelist = [];
  Map<String?, TextEditingController> conductorControllers = {};
  Map<String?, TextEditingController> driverControllers = {};
  String? selectedBusList;
  Map<String?, String?> selectedCondMap = {};
  Map<String?, String?> selectedDriverMap = {};

  // Future<bool?> popscreen(BuildContext context) async {
  //   Navigator.push(context, Approutes().homescreen);
  //   return true;
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ConductorListFunctions.instance.getAssignDetailsList(context);

      if (!mounted) return;
      conductorlist = await Wklycollectfn.instance.conductorList(context);

      if (!mounted) return;
      driverlist = await Wklycollectfn.instance.driverList(context);

      if (!mounted) return;
      setState(() {
        conductorNamelist = conductorlist!.map((bus) {
          return {
            'condId': bus.empId ?? "",
            'display': bus.name ?? "",
          };
        }).toList();

        driverNamelist = driverlist!.map((bus) {
          return {
            'driverId': bus.empId ?? "",
            'display': bus.name ?? "",
          };
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        margin: const EdgeInsets.only(top: 3, left: 3, right: 3, bottom: 10),
        elevation: 3,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.onPrimaryFixed,
                    Theme.of(context).colorScheme.onPrimary,
                  ])),
          child: Card(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              children: [
                Expanded(
                  child: ScrollableWidget(
                    child: ValueListenableBuilder(
                        valueListenable: ConductorListFunctions
                            .instance.getAssignDetailsNotifier,
                        builder: (BuildContext context,
                            List<TripDetail> newList, Widget? _) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (newList.isNotEmpty) ...[
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Assign Employee",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
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
                                      'Bus Name',
                                      'Registration No',
                                      'Conductor Name',
                                      'Driver Name'
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
                                              const CircularProgressIndicator(),
                                        ),
                                      );
                                    } else {
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

  List<DataRow> getRows(List<TripDetail> newList) {
    return newList.asMap().entries.map((entry) {
      int index = entry.key + 1; // Serial number starts from 1
      TripDetail task = entry.value;
      selectedCondMap[task.busId] ??= task.conductorId ?? "No Employee";
      selectedDriverMap[task.busId] ??= task.driverId ?? "No Employee";

      cells = [
        index.toString(),
        task.busName ?? '',
        task.registrationNo ?? '',
        task.conductorName ?? "No Employee",
        task.driverName ?? "No Employee"
      ];
      return DataRow(
        cells: [
          ...Utils.modelBuilder(cells, (index, cell) {
            final taskbold = index == 0;
            if (index == 3) {
              return DataCell(
                Center(
                  child: TextFormField(
                    readOnly: true,
                    onTap: () {
                      addConductor(
                        task,
                        context,
                      );
                    },
                    controller: conductorControllers.putIfAbsent(
                      task.conductorId ?? 'No Employee',
                      () => TextEditingController(
                          text: task.conductorName ?? 'No Employee'),
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      // Minimize padding
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff13bc91)),
                    onFieldSubmitted: (newValue) {
                      task.conductorId = newValue; // Update Km
                    },
                  ),
                ),
              );
            } else if (index == 4) {
              return DataCell(
                Center(
                  child: TextFormField(
                    readOnly: true,
                    onTap: () {
                      addDriver(task, context);
                    },
                    controller: driverControllers.putIfAbsent(
                      task.driverId ?? 'No Employee',
                      () => TextEditingController(
                          text: task.driverName ?? 'No Employee'),
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      // Minimize padding
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff13bc91)),
                    onFieldSubmitted: (newValue) {
                      task.driverId = newValue; // Update Km
                    },
                  ),
                ),
              );
            } else {
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
            }
          }),
        ],
      );
    }).toList();
  }

  addConductor(TripDetail task, BuildContext context) async {
    final busId = task.busId;
    String? currentSelection = selectedCondMap[busId];

    await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Container(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border:
                Border.all(color: Theme.of(context).colorScheme.onSecondary),
            borderRadius: BorderRadius.circular(12),
          ),
          child: StatefulBuilder(builder: (context, setState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text("Change Conductor",
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    items: [
                      const DropdownMenuItem(
                        value: 'No Employee',
                        child: Text('No Employee'),
                      ),
                      ...conductorNamelist.map((busMap) {
                        final displayText = busMap['display'] as String;
                        final condId = busMap['condId'] as String;
                        return DropdownMenuItem<String>(
                          value: condId,
                          child: Text(displayText),
                        );
                      }).toList(),
                    ],
                    value: conductorNamelist
                            .any((item) => item['condId'] == currentSelection)
                        ? currentSelection
                        : 'No Employee',
                    onChanged: (newValue) {
                      setState(() {
                        currentSelection = newValue;
                      });
                    },
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      border: OutlineInputBorder(),
                    ),
                    dropdownColor: Theme.of(context).colorScheme.tertiary,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 16,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Theme(
                      data: MyTheme.buttonStyleTheme,
                      child: ElevatedButton(
                        onPressed: () async {
                          final sharedValue =
                              await SharedPrefManager.instance.getSharedData();
                          final formattedDate =
                              DateFormat('yyyy-MM-dd').format(DateTime.now());
                          final empreq = EmployeeReq(
                              busId: busId,
                              empId: currentSelection,
                              ownerId: sharedValue?.userId,
                              startDate: formattedDate,
                              userType: 3);

                          selectedCondMap[busId] = currentSelection;
                          if (!context.mounted) return;
                          // Navigator.pop(context);
                          await employeeAssign(empreq, context);

                          //onReload();
                        },
                        child: Text(
                          'ASSIGN',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  addDriver(TripDetail task, BuildContext context) async {
    final busId = task.busId;
    String? currentSelection = selectedDriverMap[busId];

    await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Container(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border:
                Border.all(color: Theme.of(context).colorScheme.onSecondary),
            borderRadius: BorderRadius.circular(12),
          ),
          child: StatefulBuilder(builder: (context, setState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text("Change Driver",
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    items: [
                      const DropdownMenuItem(
                        value: 'No Employee',
                        child: Text('No Employee'),
                      ),
                      ...driverNamelist.map((busMap) {
                        final displayText = busMap['display'] as String;
                        final driverId = busMap['driverId'] as String;
                        return DropdownMenuItem<String>(
                          value: driverId,
                          child: Text(displayText),
                        );
                      }).toList(),
                    ],
                    value: driverNamelist
                            .any((item) => item['driverId'] == currentSelection)
                        ? currentSelection
                        : 'No Employee',
                    onChanged: (newValue) {
                      setState(() {
                        currentSelection = newValue;
                      });
                    },
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      border: OutlineInputBorder(),
                    ),
                    dropdownColor: Theme.of(context).colorScheme.tertiary,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 16,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Theme(
                      data: MyTheme.buttonStyleTheme,
                      child: ElevatedButton(
                        onPressed: () async {
                          final sharedValue =
                              await SharedPrefManager.instance.getSharedData();
                          final formattedDate =
                              DateFormat('yyyy-MM-dd').format(DateTime.now());
                          final empreq = EmployeeReq(
                              busId: busId,
                              empId: currentSelection,
                              ownerId: sharedValue?.userId,
                              startDate: formattedDate,
                              userType: 5);

                          selectedDriverMap[busId] = currentSelection;
                          if (!context.mounted) return;
                          employeeAssign(empreq, context);
                        },
                        child: Text(
                          'ASSIGN',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Future employeeAssign(EmployeeReq val, BuildContext context) async {
    try {
      final getEditDet = await Busdata().employeeAssgn(val);
      if (getEditDet == null) {
        if (!context.mounted) return;

        Wklycollectfn.instance.showApierror(context, "Something went wrong");
      } else if (getEditDet.statusCode == 200) {
        final resultJson = jsonDecode(getEditDet.toString());
        final details =
            ConductorEditResp.fromJson(resultJson as Map<String, dynamic>);
        if (details.status == 'success') {
          if (!context.mounted) return;
          await ConductorListFunctions.instance.getAssignDetailsList(context);
          if (!context.mounted) return;

          Navigator.pop(context);
          if (!context.mounted) return;

          Wklycollectfn.instance.showApierror(context, "Assigned Successfully");
        } else if (details.status == 'failed') {
          if (details.flag == 'exist') {
            if (!context.mounted) return;

            warningMessage(details.message, val, context);
          }
          if (!context.mounted) return;
          Wklycollectfn.instance.showApierror(context, details.message);
        }
      } else if (getEditDet.statusCode == 401) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Unauthenticated");
      } else if (getEditDet.statusCode == 500) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Sever Not reached");
        // showLoginerror(context, 3);
      } else if (getEditDet.statusCode == 408) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return;

        Wklycollectfn.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }

  warningMessage(
      String? message, EmployeeReq employeeReq, BuildContext context) async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: StatefulBuilder(builder: (context, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                    message ?? 'An active employee already exists for this bus',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 18)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 20,
                      width: MediaQuery.of(context).size.width / 3.2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Theme(
                        data: MyTheme.buttonStyleTheme,
                        child: ElevatedButton(
                          onPressed: () async {
                            final updatedReq =
                                employeeReq.copyWith(flag: "keep");
                            ConductorListFunctions.instance
                                .employeeStatus(updatedReq, context);
                          },
                          child: Text(
                            'Keep it',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 20,
                      width: MediaQuery.of(context).size.width / 3.2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Theme(
                        data: MyTheme.buttonStyleTheme,
                        child: ElevatedButton(
                          onPressed: () async {
                            final updatedReq =
                                employeeReq.copyWith(flag: "change");

                            ConductorListFunctions.instance
                                .employeeStatus(updatedReq, context);
                          },
                          child: Text(
                            'Change',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        }),
      ),
    );
  }

// void myReloadFunction(context) {
//   // e.g., call Provider method or setState
//   final provider =context.read<AssignEmployeeProvider>();
//   provider.fetchData(context);
// }
}
