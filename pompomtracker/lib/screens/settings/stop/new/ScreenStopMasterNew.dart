import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/function/time/timeconvertFun.dart';
import 'package:pompomtracker/provider/iconChange/iconChangeProvider.dart';
import 'package:pompomtracker/screens/settings/stop/new/ScreenAddnewStpNew.dart';
import 'package:pompomtracker/screens/settings/stop/new/ScreenStopPreview.dart';
import 'package:sizer/sizer.dart';

class ScreenStopMasterNew extends StatefulWidget {
  const ScreenStopMasterNew({
    super.key,
  });

  @override
  State<ScreenStopMasterNew> createState() => _ScreenStopMasterNewState();
}

class _ScreenStopMasterNewState extends State<ScreenStopMasterNew> {
  final _scafoldkey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _stopNameController = TextEditingController();
  final _kiloMeterController = TextEditingController();
  final _arrivingController = TextEditingController();
  final _departureController = TextEditingController();

  int? isstage;
  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 15);
  bool isChecked = true;
  List<Map<String, Object>> routelist = [];

  /// selectedBus should be a map (bus entry) not a plain String
  Map<String, dynamic>? selectedBusList;
  Map<String, dynamic>? selectedRouteList;
  int? selectedRouteId;

  List<Listdet>? existingStpdet = [];
  List<Listdet>? stpLstdet = [];

  List<Listdet>? routeDetailslist = [];
  List<String> columns = [];
  List<String?> cells = [];
  bool respIcon = false;
  String? selectedrouteName;
  String? routeName;
  String routeDisplay = '';
  List<BusRegList>? busreglist = [];
  List<Map<String, dynamic>> registarionlst = [];

  List<Listdet>? triplist = [];

  Map<String?, TextEditingController> kmControllers = {};
  Map<String?, TextEditingController> arrivingTimeControllers = {};
  Map<String?, TextEditingController> departureTimeControllers = {};

  @override
  void initState() {
    super.initState();
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

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final DateFormat timeFormat =
        DateFormat('hh:mm a'); // 12-hour format with AM/PM
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(alwaysUse24HourFormat: false), // Force 12-hour format
          child: child!,
        );
      },
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        final now = DateTime.now();
        final DateTime formattedTime = DateTime(
          now.year,
          now.month,
          now.day,
          newTime.hour,
          newTime.minute,
        );
        controller.text = timeFormat.format(formattedTime); // Show AM/PM format
      });
    }
  }

  Future<bool?> popscreen(BuildContext context) async {
    selectedTaskNotifier.value = StatementType.collectionType;
    selectedModeNotifier.value = StatementType.both;
    context.read<DropdownProvider>().changeSelectedVal(null, 0);
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const ScreenSettings()),
      (Route<dynamic> route) => false,
    );
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
          BackgroundColorGradient(),
          Scaffold(
            backgroundColor: Colors.transparent,
            key: _scafoldkey,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  context.read<DropdownProvider>().changeSelectedVal(null, 0);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const ScreenSettings()),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
              title:
                  const Text('Add Stop', style: TextStyle(color: Colors.white)),
            ),
            body: Column(
              children: [
                Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Theme(
                        data: MyTheme.googleFormTheme,
                        child: Column(
                          children: [
                            Text(
                              'Search For Stop Details',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 10),

                            // Bus Dropdown
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child:
                                  DropdownButtonFormField<Map<String, dynamic>>(
                                value: selectedBusList,
                                items: registarionlst.map((busItem) {
                                  return DropdownMenuItem<Map<String, dynamic>>(
                                    value: busItem,
                                    child: Text(
                                      busItem['display'] ?? '',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) async {
                                  if (newValue == null) return;

                                  // fetch trips for selected bus
                                  triplist =
                                      await StopFunctions.instance.tripNameList(
                                    newValue['busId'],
                                    context,
                                  );

                                  setState(() {
                                    selectedBusList = newValue;
                                    selectedRouteList = null;
                                    selectedRouteId = null;

                                    routelist = triplist!.map((trip) {
                                      // String routeDisplay =
                                      //     "{trip.tripName ?? ""} -> \${trip.startTime ?? ""}-\${trip.endTime ?? ""}";
                                      routeDisplay =
                                          "${trip.tripName ?? ""} -> ${trip.startTime ?? ""}-${trip.endTime ?? ""}";
                                      return {
                                        'routeId': trip.tripId!.toString(),
                                        'display': routeDisplay,
                                      };
                                    }).toList();
                                  });
                                },
                                icon: const Icon(Icons.arrow_drop_down),
                                decoration: InputDecoration(
                                  labelText: 'Select Bus',
                                  labelStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                                dropdownColor:
                                    Theme.of(context).colorScheme.tertiary,
                                validator: (value) {
                                  if (value == null) return 'Select Bus';
                                  return null;
                                },
                              ),
                            ),

                            const SizedBox(height: 15),

                            // Trip Dropdown
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child:
                                  DropdownButtonFormField<Map<String, dynamic>>(
                                isExpanded: true,
                                value: selectedRouteList,
                                items: routelist.map((tripMap) {
                                  final routeText =
                                      (tripMap['display'] as String)
                                          .split('->');
                                  routeName = routeText[0];
                                  final viaPart = routeText.length > 1
                                      ? '-> ${routeText[1]}'
                                      : '';
                                  return DropdownMenuItem<Map<String, dynamic>>(
                                    value: tripMap,
                                    child: ConstrainedBox(
                                      constraints:
                                          const BoxConstraints(maxWidth: 200),
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                          children: [
                                            TextSpan(text: routeName),
                                            TextSpan(
                                              text: viaPart,
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) async {
                                  if (newValue == null) return;
                                  setState(() {
                                    selectedRouteList = newValue;
                                    selectedRouteId =
                                        int.tryParse(newValue['routeId']);
                                    //selectedrouteName=routeName;
                                    kmControllers.clear();
                                    arrivingTimeControllers.clear();
                                    departureTimeControllers.clear();
                                    _departureController.clear();
                                    _arrivingController.clear();
                                    _kiloMeterController.clear();
                                    //  if(!context.mounted)return;
                                    context.read<DropdownProvider>().clear();
                                    StopFunctions.instance
                                        .getExistingStopNotifier.value = [];
                                    Provider.of<IconChangeProvider>(context,
                                            listen: false)
                                        .clearAll();
                                  });
                                  //   StopFunctions.instance.getExistingStopNotifier.value=[];
                                  //  Provider.of<IconChangeProvider>(context, listen: false).clearAll();

                                  final data = await StopFunctions.instance
                                      .getExistingStpFn(newValue['routeId']);

                                  if (data['stops'] == null ||
                                      data['stops']!.isEmpty) {
                                    stpLstdet = await StopFunctions.instance
                                        .stopDetFn(newValue['routeId']);
                                    if (stpLstdet == null ||
                                        stpLstdet!.isEmpty) {
                                      if (!context.mounted) return;
                                      context
                                          .read<DropdownProvider>()
                                          .changeSelectedVal(false, 1);
                                    } else {
                                      if (!context.mounted) return;
                                      context
                                          .read<DropdownProvider>()
                                          .changeSelectedVal(false, 1);
                                    }
                                  } else {
                                    if (data['flag'] == 1) {
                                      if (!context.mounted) return;
                                      popMessage(context);
                                    } else {
                                      if (!context.mounted) return;
                                      context
                                          .read<DropdownProvider>()
                                          .changeSelectedVal(true, 3);
                                    }
                                  }
                                },
                                icon: const Icon(Icons.arrow_drop_down),
                                decoration: InputDecoration(
                                  labelText: 'Select Trip',
                                  labelStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                                dropdownColor:
                                    Theme.of(context).colorScheme.tertiary,
                                validator: (value) {
                                  if (value == null) return 'Select Trip';
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Consumer<DropdownProvider>(
                  builder: (context, provider, child) {
                    if (provider.selectedVal == false &&
                        provider.selectedNum == 1) {
                      return Expanded(child: stopAddForm(context));
                    } else if (provider.selectedVal == true) {
                      return Expanded(
                          child: ScrollableWidget(child: buildExStopTbl()));
                    }
                    // else if(provider.selectedVal ==false && provider.selectedNum==1){
                    //   return stopAddForm(context);
                    // }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget stopAddForm(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(5),
        color: Colors.white,
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border:
                Border.all(color: Theme.of(context).colorScheme.onSecondary),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Theme(
                data: MyTheme.googleFormTheme,
                child: Column(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/bus/busmaster.png'),
                      radius: 50,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _stopNameController,
                      textCapitalization: TextCapitalization.characters,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.black),
                      decoration: InputDecoration(
                          labelText: 'Stop Name',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.black)),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Enter Stop Name';
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .5,
                        child: TextFormField(
                          controller: _kiloMeterController,
                          keyboardType: TextInputType.number,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Kilo Meter',
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.black),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Enter Kilo Meter';
                            return null;
                          },
                        ),
                      ),
                      Theme(
                        data: Theme.of(context),
                        child: Consumer<CheckProvider>(
                          builder: (context, check, _) => Checkbox(
                              value: check.isAccepted,
                              onChanged: (value) {
                                check.setAccepted(value);
                              }),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Is stage",
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: Colors.black),
                        ),
                      ),
                    ]),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _arrivingController,
                      readOnly: true,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.black),
                      decoration: InputDecoration(
                          labelText: 'Arriving Time',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.black),
                          suffixIcon: const Icon(Icons.timer)),
                      onTap: () => _selectTime(context, _arrivingController),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Enter Value';
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _departureController,
                      readOnly: true,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.black),
                      decoration: InputDecoration(
                          labelText: 'Departure Time',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.black),
                          suffixIcon: const Icon(Icons.timer)),
                      onTap: () => _selectTime(context, _departureController),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.orange,
                            const Color.fromARGB(255, 204, 123, 2)
                          ],
                        ),
                      ),
                      child: Theme(
                        data: MyTheme.buttonStyleTheme,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await stopMasterSaveFun(context);
                            }
                          },
                          child: Text('SAVE',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Consumer<LoadingProvider>(
                        builder: (context, loadingProvider, child) {
                      return loadingProvider.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color.fromARGB(255, 204, 123, 2),
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildExStopTbl() {
    return ValueListenableBuilder(
      valueListenable: StopFunctions.instance.getExistingStopNotifier,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          kmControllers.clear();
                          arrivingTimeControllers.clear();
                          departureTimeControllers.clear();
                          _departureController.clear();
                          _arrivingController.clear();
                          _kiloMeterController.clear();
                          StopFunctions.instance.getExistingStopNotifier.value =
                              [];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScreenAddNewStopNew(
                                tripName: selectedRouteList?['display'],
                                tripId: selectedRouteList?['routeId'],
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                              size: 25,
                            ),
                            Text(
                              'Add New Stop',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.all(10),
                      color: Colors.white,
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.onSecondary),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            DataTable(
                              dataRowMaxHeight: 35,
                              dataRowMinHeight: 35,
                              headingRowHeight: 35,
                              columnSpacing: 15,
                              headingRowColor: WidgetStateProperty.all(
                                  const Color.fromARGB(255, 204, 123, 2)),
                              columns: getColumns(columns = [
                                'Stop Id',
                                'Stop Name',
                                'Is Stage',
                                'Km',
                                'Arriving',
                                'Departure',
                                'Update'
                              ]),
                              rows: getRows(newList),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.orange,
                                        Color.fromARGB(255, 204, 123, 2),
                                      ],
                                    ),
                                  ),
                                  child: Theme(
                                    data: MyTheme.buttonStyleTheme,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ScreenStopPreview(
                                              tripid:
                                                  selectedRouteList?['routeId'],
                                              tripName:
                                                  selectedRouteList?['display'],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Preview',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              FutureBuilder(
                future: Future.delayed(const Duration(seconds: 10)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 2.5,
                          horizontal: MediaQuery.of(context).size.width / 2.3,
                        ),
                        child: const CircularProgressIndicator(
                            color: Color.fromARGB(255, 204, 123, 2)),
                      ),
                    );
                  } else {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 2.5,
                          horizontal: MediaQuery.of(context).size.width / 2.7,
                        ),
                        child: Text(
                          'No data found',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary),
                        ),
                      ),
                    );
                  }
                },
              ),
            ]
          ],
        );
      },
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
              ?.copyWith(color: Colors.black),
        ),
      );
    }).toList();
  }

  List<DataRow> getRows(List<Listdet> newList) => newList.map((Listdet task) {
        if (!kmControllers.containsKey(task.stopId)) {
          kmControllers[task.stopId] = TextEditingController(text: task.km);
        }
        if (!arrivingTimeControllers.containsKey(task.stopId)) {
          arrivingTimeControllers[task.stopId] = TextEditingController(
              text: TimeConvertFun.instance.formatTo12Hour(task.arrivingTime));
        }

        if (!departureTimeControllers.containsKey(task.stopId)) {
          departureTimeControllers[task.stopId] = TextEditingController(
              text: TimeConvertFun.instance.formatTo12Hour(task.departureTime));
        }

        cells = [
          task.stopId ?? '',
          task.stopName ?? '',
          task.isStage ?? '',
          task.km ?? '',
          task.arrivingTime ?? '',
          task.departureTime ?? ''
        ];

        return DataRow(cells: [
          ...Utils.modelBuilder(cells, (index, cell) {
            final taskbold = index == 0;
            final val = cells[2];
            final stage = val == "y" ? "yes" : "no";

            if (index == 3) {
              return DataCell(
                Center(
                  child: TextFormField(
                    controller: kmControllers[task.stopId],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      suffixIcon: Theme(
                        data: Theme.of(context),
                        child: Text(
                          "km",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    textAlign: TextAlign.center,
                    style: taskbold
                        ? const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 88, 147, 250))
                        : const TextStyle(
                            fontWeight: FontWeight.normal, color: Colors.black),
                    onFieldSubmitted: (newValue) {
                      task.km = newValue; // Update Km
                      StopFunctions.instance.getExistingStopNotifier
                          .notifyListeners();
                    },
                  ),
                ),
              );
            } else if (index == 4) {
              return DataCell(
                Center(
                  child: TextFormField(
                    controller: arrivingTimeControllers[task.stopId],
                    readOnly: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        suffixIcon: Theme(
                            data: Theme.of(context),
                            child: Icon(
                              Icons.timer,
                              color: Theme.of(context).colorScheme.primary,
                            ))),
                    textAlign: TextAlign.center,
                    style: taskbold
                        ? const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 88, 147, 250))
                        : const TextStyle(
                            fontWeight: FontWeight.normal, color: Colors.black),
                    onFieldSubmitted: (newValue) {
                      task.arrivingTime = newValue;
                      StopFunctions.instance.getExistingStopNotifier
                          .notifyListeners();
                    },
                    onTap: () => _selectTime(
                        context, arrivingTimeControllers[task.stopId]!),
                  ),
                ),
              );
            } else if (index == 5) {
              return DataCell(
                Center(
                  child: TextFormField(
                    controller: departureTimeControllers[task.stopId],
                    //readOnly: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        suffixIcon: Theme(
                            data: Theme.of(context),
                            child: Icon(
                              Icons.timer,
                              color: Theme.of(context).colorScheme.primary,
                            ))),
                    textAlign: TextAlign.center,
                    style: taskbold
                        ? const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 88, 147, 250))
                        : const TextStyle(
                            fontWeight: FontWeight.normal, color: Colors.black),
                    onFieldSubmitted: (newValue) {
                      task.departureTime = newValue;
                      StopFunctions.instance.getExistingStopNotifier
                          .notifyListeners();
                    },
                    onTap: () => _selectTime(
                        context, departureTimeControllers[task.stopId]!),
                  ),
                ),
              );
            } else {
              return DataCell(
                Center(
                  child: Text(
                    index == 2 ? stage : '$cell',
                    style: taskbold
                        ? const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 88, 147, 250))
                        : const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              );
            }
          }),
          DataCell(
            Center(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        //   Provider.of<IconChangeProvider>(context).isVerified(task.stopId)?
                        // Wklycollectfn.instance.showApierror(context, "Already Varified"):
                        messageBox(
                          context,
                          task,
                          kmControllers[task.stopId],
                          // arrivingTimeControllers[task.stopId],
                          // departureTimeControllers[task.stopId],
                          TextEditingController(
                            text: TimeConvertFun.instance.formatTo24Hour(
                                arrivingTimeControllers[task.stopId]?.text),
                          ),
                          TextEditingController(
                            text: TimeConvertFun.instance.formatTo24Hour(
                                departureTimeControllers[task.stopId]?.text),
                          ),
                        );
                      },
                      icon: Icon(
                        Provider.of<IconChangeProvider>(context)
                                .isVerified(task.stopId)
                            ? Icons.verified
                            : Icons.add_circle_outline,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                ],
              ),
            ),
          ),
        ]);
      }).toList();

  Future<void> stopMasterSaveFun(BuildContext context) async {
    final loadingProvider = context.read<LoadingProvider>();
    loadingProvider.toggleLoading();

    final stopName = _stopNameController.text.trim();
    final kiloMeter = _kiloMeterController.text.trim();
    final arriving = _arrivingController.text.trim();
    final departure = _departureController.text.trim();
    final routrId = selectedRouteId;

    // parse times only if provided
    String arvtime = '';
    String departime = '';
    try {
      if (arriving.isNotEmpty) {
        final DateFormat inputFormat = DateFormat('hh:mm a');
        final DateTime dateTime = inputFormat.parse(arriving);
        final DateFormat outputFormat = DateFormat('HH:mm:ss');
        arvtime = outputFormat.format(dateTime);
      }
      if (departure.isNotEmpty) {
        final DateFormat inputFormat = DateFormat('hh:mm a');
        final DateTime dateTime = inputFormat.parse(departure);
        final DateFormat outputFormat = DateFormat('HH:mm:ss');
        departime = outputFormat.format(dateTime);
      }
    } catch (e) {
      // if parsing fails, stop and show error
      loadingProvider.toggleLoading();
      Fluttertoast.showToast(msg: 'Invalid time format');
      return;
    }

    final value = await SharedPrefManager.instance.getSharedData();

    if (isChecked == true) {
      isstage = flag1;
    } else {
      isstage = flag0;
    }

    final stopMasReq = StopMasterReq(
      tripId: routrId,
      kilometer: kiloMeter,
      isStage: isstage,
      stop: stopName,
      userId: value!.userId,
      arrivingTime: arvtime,
      departureTime: departime,
    );

    final stopMasterResp = await Busdata().stopMasterSave(stopMasReq);

    final reultAsJson = jsonDecode(stopMasterResp.toString());
    final resValue =
        StopMasterResp.fromJson(reultAsJson as Map<String, dynamic>);

    loadingProvider.toggleLoading();

    if (resValue.status == 'success') {
      Fluttertoast.showToast(
          msg: "Stop details saved successfully",
          backgroundColor: Colors.white,
          textColor: Colors.black);
      if (!context.mounted) return;
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) =>
      //      ScreenStopListNew(flag: 1, routeId: selectedRouteId),
      //   ),
      // );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //      builder: (context) =>
      //      ScreenAddNewStopNew(
      //       tripName: selectedRouteList?['display'],
      //       tripId: selectedRouteList?['routeId'],
      //       busId: selectedBusList?['busId'],),
      //       ),
      //   );

      final data = await StopFunctions.instance
          .getExistingStpFn(selectedRouteList?['routeId']);

      if (data['stops'] == null || data['stops']!.isEmpty) {
        stpLstdet = await StopFunctions.instance
            .stopDetFn(selectedRouteList?['routeId']);
        if (stpLstdet == null || stpLstdet!.isEmpty) {
          if (!context.mounted) return;
          context.read<DropdownProvider>().changeSelectedVal(false, 1);
        } else {
          if (!context.mounted) return;
          context.read<DropdownProvider>().changeSelectedVal(false, 2);
        }
      } else {
        if (!context.mounted) return;
        context.read<DropdownProvider>().changeSelectedVal(true, 3);
      }
    } else if (resValue.status == 'Failed') {
      showerror(_scafoldkey.currentContext, 2);
    } else {
      showerror(_scafoldkey.currentContext, 3);
    }
  }

  void showerror(BuildContext? buildContext, int stat) {
    if (stat == 2) {
      Fluttertoast.showToast(
          msg: "Stop details not saved",
          backgroundColor: Colors.white,
          textColor: Colors.black);
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          backgroundColor: Colors.white,
          textColor: Colors.black);
    }
  }

  messageBox(
      BuildContext context,
      Listdet value,
      TextEditingController? kmcntrlr,
      TextEditingController? arvtm,
      TextEditingController? departm) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "Add Stop",
          style: TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        content: Text(
          "Do you want to add this stop across your trip?",
          style: TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontFamily: 'Poppins-Medium',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await editArriveTime(
                    context,
                    value,
                    kmcntrlr,
                    arvtm,
                    departm,
                  );
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                    fontFamily: 'Poppins-Medium',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  popMessage(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Alert..!",
                        style: TextStyle(
                          fontFamily: 'Poppins-Medium',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        "No stops found for your trip.\nWould you like to view the stops already added to the same route?\nYou can modify their timings or add new stops to this trip.",
                        style: TextStyle(
                          fontFamily: 'Poppins-Medium',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              if (!context.mounted) return;
                              context
                                  .read<DropdownProvider>()
                                  .changeSelectedVal(false, 1);
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "No",
                              style: TextStyle(
                                fontFamily: 'Poppins-Medium',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              if (!context.mounted) return;
                              context
                                  .read<DropdownProvider>()
                                  .changeSelectedVal(true, 3);
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                fontFamily: 'Poppins-Medium',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        // AlertDialog(
        //   backgroundColor: Colors.white,
        //   title:
        //   actions: [

        //   ],
        // ),
        );
  }

  Future<void> editArriveTime(
      BuildContext ctx,
      Listdet value,
      TextEditingController? kmcntrlr,
      TextEditingController? arvtm,
      TextEditingController? departm) async {
    String updatedKm = kmcntrlr?.text ?? '';
    String updatedArrivingTime = arvtm?.text ?? '';
    String updatedDepartureTime = departm?.text ?? '';

    value.km = updatedKm;
    value.arrivingTime = updatedArrivingTime;
    value.departureTime = updatedDepartureTime;
    StopFunctions.instance.getExistingStopNotifier.notifyListeners();

    String? resp = await StopFunctions.instance.editArrivingTime(value);

    if (resp == 'success') {
      _scafoldkey.currentContext!
          .read<IconChangeProvider>()
          .setVerified(value.stopId, true);
    } else {
      _scafoldkey.currentContext!
          .read<IconChangeProvider>()
          .setVerified(value.stopId, false);
    }
  }

  @override
  void dispose() {
    _stopNameController.dispose();
    _kiloMeterController.dispose();
    _arrivingController.dispose();
    _departureController.dispose();

    for (final c in kmControllers.values) {
      c.dispose();
    }
    for (final c in arrivingTimeControllers.values) {
      c.dispose();
    }
    for (final c in departureTimeControllers.values) {
      c.dispose();
    }

    super.dispose();
  }
}

// Widget buildStmntTbl() {
//   return ValueListenableBuilder(
//       valueListenable: StopFunctions.instance.getStopDetNotifier,
//       builder: (BuildContext context, List<Listdet> newList, Widget? _) {
//         return Column(
//           children: [
//             if (newList.isNotEmpty) ...[
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                       color: Theme.of(context).colorScheme.onSecondary),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         IconButton(
//                             onPressed: () {
//                               // Navigator.push(
//                               //   context,
//                               //   MaterialPageRoute(
//                               //     builder: (context) => ScreenAddNewStopNew(
//                               //       tripName: routeName,
//                               //       tripId: dropdownbusvalue,
//                               //     ),
//                               //   ),
//                               // );
//                             },
//                             icon: Icon(
//                               Icons.add_circle_outline,
//                               color: Theme.of(context).colorScheme.primary,
//                               size: 25,
//                             )),
//                         Text(
//                           'Add New Stop',
//                           style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                             color: Colors.black),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: DataTable(
//                         dataRowMaxHeight: 35,
//                         dataRowMinHeight: 35,
//                         headingRowHeight: 35,
//                         columnSpacing: 15,
//                         headingRowColor: WidgetStateProperty.all(
//                             Color.fromARGB(255, 204, 123, 2)),
//                         columns: getColumns(columns = [
//                           'Stop Name',
//                           'Is Stage',
//                           'Arriving ',
//                           'Departure',
//                           'Action'
//                         ]),
//                         rows: getRows(newList),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ] else ...[
//               FutureBuilder(
//                 future: Future.delayed(
//                     const Duration(seconds: 10)), // Add a delay of 5 seconds
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(
//                           vertical: MediaQuery.of(context).size.height / 2.5,
//                           horizontal: MediaQuery.of(context).size.width / 2.3,
//                         ),
//                         child: const CircularProgressIndicator(
//                           color: Color.fromARGB(255, 204, 123, 2),
//                         ),
//                       ),
//                     );
//                   } else {
//                     // After 5 seconds, show the No Data Found image
//                     return Center(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(
//                           vertical: MediaQuery.of(context).size.height / 2.5,
//                           horizontal: MediaQuery.of(context).size.width / 2.7,
//                         ),
//                         child: Text(
//                           'No data found',
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ]
//           ],
//         );
//       });
// }

// List<DataColumn> getStopColumns(List<String> columns) {
//   return columns.map((String column) {
//     return DataColumn(
//       label: Text(
//         column,
//         style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
//       ),
//     );
//   }).toList();
// }

// List<DataRow> getStopRows(List<Listdet> newList) => newList.map((Listdet task) {
//       cells = [
//         task.stopName ?? '',
//         task.isStage ?? '',
//         task.arrivingTime ?? '',
//         task.departureTime ?? ''
//       ];

//       return DataRow(cells: [
//         ...Utils.modelBuilder(cells, (index, cell) {
//           final taskbold = index == 0;
//           final val = cells[1];
//           //print(val);
//           // bool stg=val==cells[1]?true:false;
//           final stage = val == "y" ? "yes" : "no";
//           print(stage);

//           return DataCell(
//             Center(
//               child: Text(index == 1 ? stage : '$cell',
//                   style: taskbold
//                       ? const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Color.fromARGB(255, 88, 147, 250))
//                       : const TextStyle(fontWeight: FontWeight.normal,color: Colors.black)),
//             ),
//             // onTap: (){
//             //   switch(index){
//             //     case 1:remarkbox(context,task);
//             //   }
//             // }
//           );
//         }),
//         DataCell(
//           Center(
//             child: Row(
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) => ScreenStopNameChangeNew(
//                       //       stopdet: task,
//                       //       tripName: routeName,
//                       //       tripid: task.tripId,
//                       //     ),
//                       //   ),
//                       // );
//                     },
//                     icon: Icon(
//                       Icons.edit,
//                       color: Theme.of(context).colorScheme.primary,
//                     )),
//                 IconButton(
//                     onPressed: () {
//                       deleteStop(context, task.tripId, task.stopId);
//                     },
//                     icon: Icon(
//                       Icons.delete,
//                       color: Theme.of(context).colorScheme.primary,
//                     )),
//               ],
//             ),
//           ),
//         ),
//       ]);
//     }).toList();

// deleteStop(BuildContext context, String? tripid, String? stopid) async =>
//     showDialog<bool>(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => PopScope(
//               canPop: false,
//               child: AlertDialog(
//                 title: Container(
//                   height: MediaQuery.of(context).size.height / 6,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                         color: Theme.of(context).colorScheme.onSecondary),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 20),
//                         child: Text("Do you want to delete?",
//                             style: Theme.of(context).textTheme.titleLarge),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(vertical: 10.0),
//                             child: Container(
//                               height: 30,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                   colors: [
//                                     Theme.of(context).colorScheme.primary,
//                                     Theme.of(context).colorScheme.secondary
//                                   ],
//                                 ),
//                                 borderRadius: BorderRadius.circular(12.0),
//                               ),
//                               child: Theme(
//                                 data: MyTheme.buttonStyleTheme,
//                                 child: ElevatedButton(
//                                   onPressed: () async {
//                                     Navigator.pop(context, false);
//                                   },
//                                   child: Text(
//                                     'No',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .titleMedium,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(vertical: 10.0),
//                             child: Container(
//                               height: 30,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                   colors: [
//                                     Theme.of(context).colorScheme.primary,
//                                     Theme.of(context).colorScheme.secondary
//                                   ],
//                                 ),
//                                 borderRadius: BorderRadius.circular(12.0),
//                               ),
//                               child: Theme(
//                                 data: MyTheme.buttonStyleTheme,
//                                 child: ElevatedButton(
//                                   onPressed: () async {
//                                     StopFunctions.instance
//                                         .deleteStop(tripid, stopid);
//                                     Navigator.pop(context, false);
//                                   },
//                                   child: Text(
//                                     'yes',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .titleMedium,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ));

// remarkbox(BuildContext context, Listdet task) async => showDialog<bool>(
//     context: context,
//     builder: (context) => AlertDialog(
//           title: Container(
//             decoration: BoxDecoration(
//               border: Border.all(
//                   color: Theme.of(context).colorScheme.onSecondary),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Form(
//               key: _formkey1,
//               child: Center(
//                   child: Theme(
//                 data: MyTheme.googleFormTheme,
//                 child: Column(
//                   children: [
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       "Change Stage Status",
//                       style: Theme.of(context).textTheme.titleLarge,
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 15.0, horizontal: 10),
//                         child: TextFormField(
//                             controller: _isStagecontroller,
//                             style: TextStyle(
//                               color: Theme.of(context).colorScheme.onPrimary,
//                             ),
//                             decoration: InputDecoration(
//                               labelText: 'Is Stage',
//                               hintText: 'Enter y/n',
//                               hintStyle:
//                                   Theme.of(context).textTheme.labelSmall,
//                               labelStyle:
//                                   Theme.of(context).textTheme.labelSmall,
//                             ),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return "Enter valid letter";
//                               } else if (value.contains('.') ||
//                                   value.contains("-") ||
//                                   value.contains(" ") ||
//                                   value.contains(",")) {
//                                 return "Enter valid letter";
//                               }
//                               return null;
//                             }),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10.0),
//                       child: Container(
//                         height: 45,
//                         width: 200,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                             colors: [
//                               Theme.of(context).colorScheme.primary,
//                               Theme.of(context).colorScheme.secondary
//                             ],
//                           ),
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                         child: Theme(
//                           data: MyTheme.buttonStyleTheme,
//                           child: ElevatedButton(
//                             onPressed: () async {
//                               if (_formkey1.currentState!.validate()) {
//                                 context
//                                     .read<ElevatedBtnProvider>()
//                                     .changeSelectedVal(true);
//                                 final tripid = dropdownbusvalue;
//                                 print(tripid);
//                                 //fetchclstatement(context, value);
//                                 //StopFunctions.instance.stopDetFn(tripid);
//                               }
//                             },
//                             child: Text(
//                               'Update',
//                               style: Theme.of(context).textTheme.titleMedium,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )),
//             ),
//           ),
//         ));
