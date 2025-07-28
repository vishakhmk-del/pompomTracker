import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/screens/Emp_Details/employee/Employee/new/ScreenEmployeeNew.dart';

class ScreenDriverViewNew extends StatefulWidget {
  const ScreenDriverViewNew({super.key});

  @override
  State<ScreenDriverViewNew> createState() => _ScreenDriverViewNewState();
}

class _ScreenDriverViewNewState extends State<ScreenDriverViewNew> {
  List<String> columns = [];
  List<String?> cells = [];
  List<BusRegList>? busreglist = [];
  List<String> registarionlst = [];
  String? selectedBusList;
  Future<bool?> popscreen(BuildContext context) async {
      Navigator.pop(context,false);
    return true;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ConductorListFunctions.instance.getDriverList(context);
      if (!mounted) return;

      final loadingProvider = context.read<LoadingProvider>();
      loadingProvider.reset();
    });
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
                 Navigator.pop(context,false);

                      //Navigator.pushReplacement(context, Approutes().employeescreen);

                },
              ),
              title: Text(
                'Driver List',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ScrollableWidget(
                    child: ValueListenableBuilder(
                        valueListenable:
                            ConductorListFunctions.instance.getDriveristNotifier,
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
                                        Color.fromARGB(255, 204, 123, 2)),
                                    columns: getColumns(columns = [
                                      'S.No',
                                      'Name',
                                      'User name',
                                      'Mobile No',
                                      ''
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

  List<DataRow> getRows(List<Listdet> newList) {
    return newList.asMap().entries.map((entry) {
      int index = entry.key + 1; // Serial number starts from 1
      Listdet task = entry.value;
      cells = [task.cname ?? '', task.empId ?? '', task.mobileNo ?? ''];
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
                            ScreenEmployeeNew(conductor_id: task.empId, flag: 2),
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

  // Future<void> _showMyDialog(BuildContext context, conductorId) async {
  //   final value = await SharedPrefManager.instance.getSharedData();
  //   if (!context.mounted) return;

  //   busreglist = await Wklycollectfn.instance.busReglistfn(context);
  //   if (!context.mounted) return;

  //   registarionlst =
  //       busreglist!.map((bus) => bus.registrationNo ?? "").toList();
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Container(
  //           height: MediaQuery.of(context).size.height / 4,
  //           width: MediaQuery.of(context).size.width,
  //           decoration: BoxDecoration(
  //             border:
  //                 Border.all(color: Theme.of(context).colorScheme.onSecondary),
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Column(
  //               children: [
  //                 Text(
  //                   'Link Conductor Bus',
  //                   style: Theme.of(context).textTheme.titleMedium,
  //                 ),
  //                 const SizedBox(
  //                   height: 20,
  //                 ),
  //                 ListBody(
  //                   children: <Widget>[
  //                     DropdownButtonFormField(
  //                       items: registarionlst.map((valueItem) {
  //                         return DropdownMenuItem(
  //                           value: valueItem,
  //                           child: Text(
  //                             valueItem,
  //                             style: TextStyle(
  //                                 color: Theme.of(context)
  //                                     .colorScheme
  //                                     .onSecondary),
  //                           ),
  //                         );
  //                       }).toList(),
  //                       onChanged: (newValue) {
  //                         setState(() {
  //                           selectedBusList = newValue;
  //                         });
  //                       },
  //                       value: selectedBusList,
  //                       style: TextStyle(
  //                           color: Theme.of(context).colorScheme.onPrimary),
  //                       icon: Theme(
  //                         data: Theme.of(context),
  //                         child: const Icon(
  //                           Icons.arrow_drop_down,
  //                         ),
  //                       ),
  //                       decoration: InputDecoration(
  //                         labelText: 'Select Bus',
  //                         labelStyle: Theme.of(context).textTheme.bodySmall,
  //                       ),
  //                       dropdownColor: Theme.of(context).colorScheme.tertiary,
  //                       validator: (value) {
  //                         if (value == null || value.isEmpty) {
  //                           return 'Select Bus Type';
  //                         } else {
  //                           return null;
  //                         }
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(
  //                   height: 20,
  //                 ),
  //                 Container(
  //                   height: 30,
  //                   width: 100,
  //                   decoration: BoxDecoration(
  //                     gradient: LinearGradient(
  //                       begin: Alignment.topLeft,
  //                       end: Alignment.bottomRight,
  //                       colors: [
  //                         Theme.of(context).colorScheme.primary,
  //                         Theme.of(context).colorScheme.secondary
  //                       ],
  //                     ),
  //                     borderRadius: BorderRadius.circular(12.0),
  //                   ),
  //                   child: Theme(
  //                     data: MyTheme.buttonStyleTheme,
  //                     child: ElevatedButton(
  //                       onPressed: () async {
  //                         final req = MasterListReq(
  //                             empId: conductorId,
  //                             busRegNo: selectedBusList,
  //                             userId: value!.userId);
  //                         final resp = await Busdata().linkConductorBus(req);
  //                         final resultAsjson = jsonDecode(resp.toString());
  //                         final resValue = ConductorBusInkResp.fromJson(
  //                             resultAsjson as Map<String, dynamic>);
  //                         if (resValue.status == 'success') {
  //                           Fluttertoast.showToast(
  //                               msg: "Linked successfully",
  //                               toastLength: Toast.LENGTH_SHORT,
  //                               gravity: ToastGravity.CENTER,
  //                               timeInSecForIosWeb: 1,
  //                               backgroundColor: Colors.white,
  //                               textColor: Colors.black,
  //                               fontSize: 15.0);
  //                           Navigator.of(context).pop();
  //                         } else {
  //                           Fluttertoast.showToast(
  //                               msg: " Error",
  //                               toastLength: Toast.LENGTH_SHORT,
  //                               gravity: ToastGravity.CENTER,
  //                               timeInSecForIosWeb: 1,
  //                               backgroundColor: Colors.white,
  //                               textColor: Colors.black,
  //                               fontSize: 15.0);
  //                           Navigator.of(context).pop();
  //                         }
  //                       },
  //                       child: Text(
  //                         'LINK',
  //                         style: Theme.of(context).textTheme.titleMedium,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
