
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/provider/iconChange/iconChangeProvider.dart';

class ScreenStopMaster extends StatefulWidget {
  const ScreenStopMaster({super.key});

  @override
  State<ScreenStopMaster> createState() => _ScreenStopMasterState();
}

class _ScreenStopMasterState extends State<ScreenStopMaster> {
  final _scafoldkey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _stopNameController = TextEditingController();
  final _kiloMeterController = TextEditingController();
  final _arrivingController = TextEditingController();
  
  int? isstage;
  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 15);
  bool isChecked = true;
  List<Map<String, Object>> routelist = [];
  String? selectedRouteList;
  int? selectedRouteId;
  List<Listdet>? existingStpdet = [];
  List<Listdet>? routeDetailslist = [];
  List<String> columns = [];
  List<String?> cells = [];
  bool respIcon=false;

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final DateFormat timeFormat = DateFormat('HH:mm');
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
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
        controller.text = timeFormat.format(formattedTime);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      routeDetailslist = await StopFunctions.instance.tripNewNameList();
      setState(() {
        routelist = routeDetailslist!.map((bus) {
         String routeDisplay = bus.tripName ?? "";
          // String viaDisplay =
          //     bus.via != null && bus.via!.isNotEmpty ? " via - ${bus.via}" : "";
          return {
            'routeId': bus.tripId!, // routeId as int
            'display': routeDisplay, // Display label
          };
        }).toList();
      });
    });
    //fetchBusregistraionList();
  }
  Future<bool?> popscreen(BuildContext context) async {
    selectedTaskNotifier.value = StatementType.collectionType;
    selectedModeNotifier.value = StatementType.both;
    context.read<DropdownProvider>().changeSelectedVal(null);
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
        log('BackButton pressed!');
      },
      child: Scaffold(
        key: _scafoldkey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.read<DropdownProvider>().changeSelectedVal(null);
              Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const Screenhome()),
                            (Route<dynamic> route) => false);
                      },
            
          ),
          title: Text(
            'Stop List',
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          ),
        ),
        body: ListView(
          children: [
                  Card(
                      margin: const EdgeInsets.all(10),
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.onSecondary),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        child:Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Theme(
                            data: MyTheme.googleFormTheme,
                            child: Column(children: [
                              Text(
                                'Search For Stop Details',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 10),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: DropdownButtonFormField(
                                    isExpanded: true,
                                    items: routelist.map((busMap) {
                                      return DropdownMenuItem<String>(
                                        value: busMap['routeId'] as String,
                                        // Use routeId as the value
                                        child: ConstrainedBox(
                                          constraints:
                                              const BoxConstraints(maxWidth: 200),
                                          child: Text(
                                            busMap['display']
                                                as String, // Display the route name and via
                                            //overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) async{
                                      //StopFunctions.instance.getExistingStopNotifier.value = []; 
                                      setState(() {
                                        selectedRouteList = newValue;
                                        selectedRouteId = int.parse(newValue!);
                                        // Store the selected routeId
                                      });

                                      existingStpdet=await StopFunctions.instance.getExistingStpFn(selectedRouteList);
                                      //existingStpdet=StopFunctions.instance.getExistingStopNotifier.value;
                                      if(existingStpdet!.isEmpty){
                                         _scafoldkey.currentContext!.read<DropdownProvider>().changeSelectedVal(false);
                                      }else{
                                        _scafoldkey.currentContext!.read<DropdownProvider>().changeSelectedVal(true);
                                      }
                                    },
                                    value: selectedRouteList,
                                    // Use the selected routeId
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onPrimary,
                                    ),
                                    icon: Theme(
                                      data: Theme.of(context),
                                      child: const Icon(
                                        Icons.arrow_drop_down,
                                      ),
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Select Trip',
                                      labelStyle: Theme.of(context).textTheme.bodySmall,
                                    ),
                                    dropdownColor:
                                        Theme.of(context).colorScheme.tertiary,
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Select Trip';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                            ],)),
                        )
                      )),
                      Consumer<DropdownProvider>(
                      builder: (context, provider, child) {
                        if (provider.selectedVal == false) {
                          return stopAddForm(context);
                          
                        } else if (provider.selectedVal == true) {
                          
                          return ScrollableWidget(child: buildExStopTbl());
                          
                        }
                        return Container();
                        
                      },
                    ),
          ],)
          )
          );
  }
  Widget stopAddForm(BuildContext context){
    return Container(
              height: MediaQuery.of(context).size.height * .7,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onSecondary),
                  borderRadius: BorderRadius.circular(12)),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Theme(
                    data: MyTheme.googleFormTheme,
                    child: Column(
                      children: [
                        const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/bus/busmaster.png'),
                          radius: 50,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _stopNameController,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                              labelText: 'Stop Name',
                              labelStyle:
                                  Theme.of(context).textTheme.bodySmall),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Stop Name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .5,
                            child: TextFormField(
                              controller: _kiloMeterController,
                              style: Theme.of(context).textTheme.bodySmall,
                              decoration: InputDecoration(
                                labelText: 'Kilo Meter',
                                labelStyle:
                                    Theme.of(context).textTheme.bodySmall,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Kilo Meter';
                                } else {
                                  return null;
                                }
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
                            style: Theme.of(context).textTheme.labelLarge,
                          )),
                        ]),
                        // const SizedBox(height: 20),

                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _arrivingController,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                              labelText: 'Arriving Time',
                              labelStyle: Theme.of(context).textTheme.bodySmall,
                              suffixIcon: Theme(
                                  data: Theme.of(context),
                                  child: const Icon(Icons.timer))),
                          onTap: () =>
                              _selectTime(context, _arrivingController),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Value';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Theme.of(context).colorScheme.primary,
                                    Theme.of(context).colorScheme.secondary,
                                  ])),
                          child: Theme(
                            data: MyTheme.buttonStyleTheme,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  stopMasterSaveFun();
                                }
                              },
                              child: Text('SAVE',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
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
                                      Color.fromARGB(255, 2, 128, 6),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink();
                        }),
                      ],
                    ),
                  ),
                )));
  }
  
  Widget buildExStopTbl() {
    return ValueListenableBuilder(
        valueListenable: StopFunctions.instance.getExistingStopNotifier,
        builder: (BuildContext context, List<Listdet> newList, Widget? _) {
          return Card(
                      margin: const EdgeInsets.all(10),
                      elevation: 3,
            child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).colorScheme.onSecondary),
              
                              borderRadius: BorderRadius.circular(12),
                            ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  

                  DataTable(
                    columns: getColumns(
                       columns = [
                                'Stop Id',
                                'Stop Name',
                                'Is Stage',
                                'Km',
                                'Arriving ',
                                'Action'
                              ]
                        ),
                    rows: getRows(newList),
                  ),
                ],
              ),
            ),
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

Map<String?, TextEditingController> kmControllers = {};
Map<String?, TextEditingController> arrivingTimeControllers = {};

  List<DataRow> getRows(List<Listdet> newList) =>
      newList.map((Listdet task) {
        if (!kmControllers.containsKey(task.stopId)) {
        kmControllers[task.stopId] = TextEditingController(text: task.km);
      }
      if (!arrivingTimeControllers.containsKey(task.stopId)) {
        arrivingTimeControllers[task.stopId] = TextEditingController(text: task.arrivingTime);
      }
      // TextEditingController kmController = TextEditingController(text: task.km);
      // TextEditingController arrivingTimeController = TextEditingController(text: task.arrivingTime);
        cells = [       
                        task.stopId,
                        task.stopName,
                        task.isStage,
                        task.km,         
                        task.arrivingTime
                        
                      ];
                    

         return DataRow(
        cells: [
          ...Utils.modelBuilder(cells, (index, cell) {
            final taskbold = index == 0;
            final val = cells[2];
            final stage = val == "y" ? "yes" : "no";
            if (index == 3) {
              // Editable field for Km (index 3) and ArrivingTime (index 4)
            //  TextEditingController controller = index == 3 ? kmController : arrivingTimeController;

              return DataCell(
                Center(
                  child: TextFormField(
                    controller: kmControllers[task.stopId],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true, // Minimize padding
                    ),
                    textAlign: TextAlign.center,
                    style: taskbold
                        ? const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 88, 147, 250),
                          )
                        : const TextStyle(fontWeight: FontWeight.normal),
                    onFieldSubmitted: (newValue) {                      
                        task.km = newValue; // Update Km                 
                      StopFunctions.instance.getExistingStopNotifier.notifyListeners();
                    },
                  ),
                ),
              );
            } else if(index == 4){
                return DataCell(
                Center(            
                  child:  TextFormField(
                          controller: arrivingTimeControllers[task.stopId],
                           decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true, 
                          ),
                          textAlign: TextAlign.center,
                          style: taskbold
                              ? const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 88, 147, 250),
                                )
                              : const TextStyle(fontWeight: FontWeight.normal),
                          onFieldSubmitted: (newValue) {                          
                              task.arrivingTime = newValue;
                            StopFunctions.instance.getExistingStopNotifier.notifyListeners();
                          },
                          onTap: () =>
                              _selectTime(context,arrivingTimeControllers[task.stopId]! ),
                         
                        ),
                ),
              ); 
            }else {
              
              return DataCell(
                Center(
                  child: Text(
                    index == 2 ? stage : '$cell',
                    style: taskbold
                        ? const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 88, 147, 250))
                        : const TextStyle(fontWeight: FontWeight.normal),
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
                      onPressed: () async{
                       await editArriveTime(context,task,kmControllers[task.stopId],arrivingTimeControllers[task.stopId]);
                      },
                      icon: Icon(
                        Provider.of<IconChangeProvider>(context).isVerified(task.stopId)?Icons.verified:Icons.add_circle_outline,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                ],
              ),
            ),
          ),
        ]
      );
    }).toList();


  Future stopMasterSaveFun() async {
    final loadingProvider = _scafoldkey.currentContext!.read<LoadingProvider>();
    //False to true
    loadingProvider.toggleLoading();

    final stopName = _stopNameController.text;
    final kiloMeter = _kiloMeterController.text;
    final arriving = _arrivingController.text;
    final routrId = selectedRouteId;

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
        arrivingTime: arriving);
    // print(stopMasReq);
    final stopMasterResp = await Busdata().stopMasterSave(stopMasReq);
    final reultAsJson = jsonDecode(stopMasterResp.toString());
    final resValue =
        StopMasterResp.fromJson(reultAsJson as Map<String, dynamic>);
    //True to false
    loadingProvider.toggleLoading();

    if (resValue.status == 'success') {
      Fluttertoast.showToast(
          msg: "Stop details saved successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
    } else if (resValue.status == 'Failed') {
      showerror(_scafoldkey.currentContext, 2);
    } else {
      showerror(_scafoldkey.currentContext, 3);
    }
  }

  showerror(BuildContext? buildContext, stat) {
    if (stat == 2) {
      Fluttertoast.showToast(
          msg: "Stop details  not saved",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
    }
  }

Future editArriveTime(
  BuildContext ctx,Listdet value,
  TextEditingController? kmcntrlr,
  TextEditingController? arvtm )async{

  String updatedKm = kmcntrlr!.text;
  String updatedArrivingTime = arvtm!.text;
  value.km = updatedKm;
  value.arrivingTime = updatedArrivingTime;
  StopFunctions.instance.getExistingStopNotifier.notifyListeners();

  String? resp=await StopFunctions.instance.editArrivingTime(value); 
   
   if(resp=='success'){
     _scafoldkey.currentContext!.read<IconChangeProvider>().setVerified(value.stopId,true);
   }else{
     _scafoldkey.currentContext!.read<IconChangeProvider>().setVerified(value.stopId,false);
   }

}

}
