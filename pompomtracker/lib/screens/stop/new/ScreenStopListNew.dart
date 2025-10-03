import 'dart:developer';
import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/screens/stop/new/ScreenAddnewStpNew.dart';
import 'package:pompomtracker/screens/stop/new/ScreenChangeStopNameNew.dart';

class ScreenStopListNew extends StatefulWidget {
  const ScreenStopListNew({super.key, required this.flag,this.routeId});
  final int flag;
  final int? routeId;
  @override
  State<ScreenStopListNew> createState() => _ScreenStopListNewState();
}

class _ScreenStopListNewState extends State<ScreenStopListNew> {
  final _isStagecontroller = TextEditingController();

  List<String> columns = [];
  List<String?> cells = [];
  final _formkey = GlobalKey<FormState>();
  final _formkey1 = GlobalKey<FormState>();
  String? dropdownbusvalue;
  String? routeName;
  String? tripId;
  List<Listdet>? triplist = [];
  List<Map<String, Object>> tripnamelst = [];
    List<Map<String, dynamic>> registarionlst = [];

  List<BusRegList>? busreglist = [];
 // String? selectedBusList;
  Map<String, dynamic>? selectedBusList;


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (!mounted) return;
      context.read<ElevatedBtnProvider>().changeSelectedVal(false);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        busreglist = await Wklycollectfn.instance.busReglistfn(context);

        setState(() {
          registarionlst = busreglist!.map((bus) {
            return {
              'busId': bus.busId,
              'display': bus.registrationNo ?? '',
            };
          }).toList();
        });

        if (!mounted) return;
        final checkProvider = context.read<CheckProvider>();
        checkProvider.reset();
      } catch (e, st) {
        log('Error loading bus list: \$e');
        log(st.toString());
      }
    });
  }

  Future<bool?> popscreen(BuildContext context) async {
    selectedTaskNotifier.value = StatementType.collectionType;
    selectedModeNotifier.value = StatementType.both;
    widget.flag == 0
        ? Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const ScreenMainPage()),
            (Route<dynamic> route) => false)
        : Navigator.push(context, Approutes().settingscreen);
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
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      widget.flag == 0
                          ? Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const ScreenMainPage()),
                              (Route<dynamic> route) => false)
                          : Navigator.push(context, Approutes().settingscreen);
                    },
                  ),
                  title: Text(
                    'Stop List',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                body: Column(
                  children: [
                    Card(
                        margin: const EdgeInsets.all(10),
                        elevation: 3,
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Form(
                                key: _formkey,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Theme(
                                      data: MyTheme.googleFormTheme,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Search For Stop Details',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                    const SizedBox(height: 10),

                                          SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: DropdownButtonFormField<Map<String, dynamic>>(
                                        value: selectedBusList,
                                        items: registarionlst.map((busItem) {
                                          return DropdownMenuItem<Map<String, dynamic>>(
                                            value: busItem,
                                            child: Text(
                                              busItem['display'] ?? '',
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.onSecondary,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (newValue)async {
                                  if (newValue == null) return;

                                          triplist = await StopFunctions.instance.tripNameList(newValue['busId'],context);

                                          setState(() {

                                            selectedBusList = newValue;
                                            
                                            tripnamelst = triplist!.map((trip) {
                                              String routeDisplay =
                                                  "${trip.tripName ?? ""}->${trip.startTime ?? ""}-${trip.endTime ?? ""}";

                                              return {
                                                'tripId': trip.tripId!, // routeId as int
                                                'display': routeDisplay // Display label
                                              };
                                            }).toList();
                                          });
                                          // setState(() {
                                          //   selectedBusList = newValue;
                                          // });
                                        },
                                      //  value: selectedBusList,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                        icon: Theme(
                                          data: Theme.of(context),
                                          child: const Icon(
                                            Icons.arrow_drop_down,
                                          ),
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'Select Bus',
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        dropdownColor: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Select Bus Type';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 25, left: 5, right: 5),
                                              child: DropdownButtonFormField(
                                                //controller: _selectsearchtypedropdwn,
                                                dropdownColor: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                                icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSecondary),
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSecondary,
                                                ),
                                                decoration: InputDecoration(
                                                  labelText: 'Select Trip Name',
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge,
                                                ),
                                                items:
                                                    tripnamelst.map((tripMap) {
                                                      final routeText =(tripMap['display'] as String).split('->');
                                              final routeName =routeText[0]; // First part
                                              final viaPart =routeText.length > 1? '-> ${routeText[1]}': '';
                                                  // String combinedValue =
                                                  //     '${tripMap['tripId']}+${tripMap['display']}';
                                                  return DropdownMenuItem<String>(
                                                    value: tripMap['tripId'] as String,
                                                    child: ConstrainedBox(
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxWidth: 200),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        style: TextStyle(
                                                          color:Theme.of(context).colorScheme.onSecondary,
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                            text:'$routeName\n', // Route name on the first line
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                viaPart, // "via" part on the second line
                                                            style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onSecondary,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                                  );
                                                }).toList(),
                                                onChanged: (newvalue) {
                                                  log('Bus :$newvalue');
                                                  // List<String> parts =
                                                  //     newvalue!.split('+');
                                                  // tripId = parts[0];
                                                  // display = parts[1];

                                                  context
                                                      .read<
                                                          ElevatedBtnProvider>()
                                                      .changeSelectedVal(false);

                                                  setState(() {
                                                    dropdownbusvalue = newvalue;
                                                    //context.read<ElevatedBtnProvider>().changeSelectedVal(true);
                                                  });
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Select A Trip Name';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                value: dropdownbusvalue,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(25.0),
                                            child: Container(
                                              height: 45,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .secondary
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: Theme(
                                                data: MyTheme.buttonStyleTheme,
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    if (_formkey.currentState!
                                                        .validate()) {
                                                      context.read<ElevatedBtnProvider>()
                                                          .changeSelectedVal(true);

                                                      StopFunctions.instance.stopDetFn(dropdownbusvalue);
                                                    }
                                                  },
                                                  child: Text(
                                                    'Show',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                )))),
                    Consumer<ElevatedBtnProvider>(
                      builder: (context, provider, child) {
                        if (provider.selectedVal == false) {
                          return Container();
                        } else if (provider.selectedVal == true) {
                          return Expanded(
                              child: ScrollableWidget(child: buildStmntTbl()));
                        }
                        return Container();
                      },
                    ),
                  ],
                )),
          ],
        ));
  }

  Widget buildStmntTbl() {
    return ValueListenableBuilder(
        valueListenable: StopFunctions.instance.getStopDetNotifier,
        builder: (BuildContext context, List<Listdet> newList, Widget? _) {
          return Column(
            children: [
              if (newList.isNotEmpty) ...[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.onSecondary),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScreenAddNewStopNew(
                                      tripName: routeName,
                                      tripId: dropdownbusvalue,
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: Theme.of(context).colorScheme.primary,
                                size: 25,
                              )),
                          Text(
                            'Add New Stop',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DataTable(
                          dataRowMaxHeight: 35,
                          dataRowMinHeight: 35,
                          headingRowHeight: 35,
                          columnSpacing: 15,
                          headingRowColor: WidgetStateProperty.all(
                              Color.fromARGB(255, 204, 123, 2)),
                          columns: getColumns(columns = [
                            'Stop Name',
                            'Is Stage',
                            'Arriving ',
                            'Departure',
                            'Action'
                          ]),
                          rows: getRows(newList),
                        ),
                      ),
                    ],
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
                          child: const CircularProgressIndicator(
                            color: Color.fromARGB(255, 204, 123, 2),
                          ),
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
                            style: TextStyle(color: Colors.black),
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
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
      );
    }).toList();
  }

  List<DataRow> getRows(List<Listdet> newList) => newList.map((Listdet task) {
        cells = [
          task.stopName ?? '',
          task.isStage ?? '',
          task.arrivingTime ?? '',
          task.departureTime ?? ''
        ];

        return DataRow(cells: [
          ...Utils.modelBuilder(cells, (index, cell) {
            final taskbold = index == 0;
            final val = cells[1];
            //print(val);
            // bool stg=val==cells[1]?true:false;
            final stage = val == "y" ? "yes" : "no";
            print(stage);

            return DataCell(
              Center(
                child: Text(index == 1 ? stage : '$cell',
                    style: taskbold
                        ? const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 88, 147, 250))
                        : const TextStyle(fontWeight: FontWeight.normal,color: Colors.black)),
              ),
              // onTap: (){
              //   switch(index){
              //     case 1:remarkbox(context,task);
              //   }
              // }
            );
          }),
          DataCell(
            Center(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScreenStopNameChangeNew(
                              stopdet: task,
                              tripName: routeName,
                              tripid: task.tripId,
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                  IconButton(
                      onPressed: () {
                        deleteStop(context, task.tripId, task.stopId);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                ],
              ),
            ),
          ),
        ]);
      }).toList();

  deleteStop(BuildContext context, String? tripid, String? stopid) async =>
      showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => PopScope(
                canPop: false,
                child: AlertDialog(
                  title: Container(
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.onSecondary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text("Do you want to delete?",
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                height: 30,
                                width: 100,
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
                                      Navigator.pop(context, false);
                                    },
                                    child: Text(
                                      'No',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                height: 30,
                                width: 100,
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
                                      StopFunctions.instance
                                          .deleteStop(tripid, stopid);
                                      Navigator.pop(context, false);
                                    },
                                    child: Text(
                                      'yes',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ));

  remarkbox(BuildContext context, Listdet task) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).colorScheme.onSecondary),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Form(
                key: _formkey1,
                child: Center(
                    child: Theme(
                  data: MyTheme.googleFormTheme,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Change Stage Status",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10),
                          child: TextFormField(
                              controller: _isStagecontroller,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Is Stage',
                                hintText: 'Enter y/n',
                                hintStyle:
                                    Theme.of(context).textTheme.labelSmall,
                                labelStyle:
                                    Theme.of(context).textTheme.labelSmall,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter valid letter";
                                } else if (value.contains('.') ||
                                    value.contains("-") ||
                                    value.contains(" ") ||
                                    value.contains(",")) {
                                  return "Enter valid letter";
                                }
                                return null;
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: 45,
                          width: 200,
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
                                if (_formkey1.currentState!.validate()) {
                                  context
                                      .read<ElevatedBtnProvider>()
                                      .changeSelectedVal(true);
                                  final tripid = dropdownbusvalue;
                                  print(tripid);
                                  //fetchclstatement(context, value);
                                  //StopFunctions.instance.stopDetFn(tripid);
                                }
                              },
                              child: Text(
                                'Update',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            ),
          ));
}
