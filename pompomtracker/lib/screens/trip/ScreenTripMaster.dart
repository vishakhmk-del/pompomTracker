import 'package:intl/intl.dart';
import 'package:pompomtracker/core/hook/hook.dart';


class ScreenTripMaster extends StatefulWidget {
  const ScreenTripMaster({super.key});

  @override
  State<ScreenTripMaster> createState() => _ScreenTripMasterState();
}

class _ScreenTripMasterState extends State<ScreenTripMaster> {
  final _scafoldkey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  List<String> registarionlst = [];
  List<Map<String, Object>> routelist = [];
  String? selectedBusList;
  String? selectedRouteList;
  String? selectedFromList;
  String? selectedToList;
  int? selectedRouteId;
  List<String> stnlst = [];
  List<BusRegList>? busreglist = [];
  List<Listdet>? routeDetailslist = [];
  List<Listdet>? stationlist = [];
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 15);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // fetchRouteList();
      busreglist = await Wklycollectfn.instance.busReglistfn();
      setState(() {
        registarionlst =
            busreglist!.map((bus) => bus.registrationNo ?? "").toList();
      });
    });
    //fetchBusregistraionList();
  }

  
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
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldkey,
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                  _scafoldkey.currentContext!, Approutes().homescreen);
            },
          ),
          title: Text(
            "Trip Master",
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          )),
      body: Center(
        child: ListView(
          
          children: [
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height*1.05,
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onSecondary),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Theme(
                        data: MyTheme.googleFormTheme,
                        child: Column(
                          children: [
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/bus/busmaster.png'),
                              radius: 50,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
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
                                  });
                                  selectedRouteList=null;
                                  fetchroute(newValue);
                                },
                                value: selectedBusList,
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
                                  labelStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                                dropdownColor:
                                    Theme.of(context).colorScheme.tertiary,
                                    
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Select Bus Type';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                items: routelist.map((busMap) {
                                  final routeText = (busMap['display'] as String).split(' - via - ');
                                  final routeName = routeText[0]; // First part
                                  final viaPart = routeText.length > 1 ? '- via - ${routeText[1]}' : '';
                                  return DropdownMenuItem<String>(
                                    
                                    value: busMap['routeId'] as String,
                                    // Use routeId as the value
                                    child: RichText(
                                      text:TextSpan(
                                      style: TextStyle(
                                       color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ), children: [
                                      TextSpan(
                                        text: '$routeName\n', // Route name on the first line
                                      ),
                                      TextSpan(
                                        text: viaPart, // "via" part on the second line
                                        style: TextStyle(
                                          color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                        ),
                                      ),
                                    ],
                                    ),)
                                   
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedRouteList = newValue;
                                    selectedRouteId = int.parse(newValue!);
                                    // Store the selected routeId
                                  });
                                  fetchfromtostn(selectedRouteId);
                                  //selectedRouteList ?? 'Others';
                                },
                                value: selectedRouteList,
                                // Use the selected routeId
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                                icon: Theme(
                                  data: Theme.of(context),
                                  child: const Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Select Route',
                                  labelStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                                dropdownColor:
                                    Theme.of(context).colorScheme.tertiary,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Select Route';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: DropdownButtonFormField(
                                items:[ ...stnlst.map((valueItem) {
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
                                const DropdownMenuItem(
                                  value: 'Others',
                                  child: Text('Others'),
                                ),],
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedFromList = newValue;
                                  });
                                  //selectedRouteList=null;
                                 // fetchroute(newValue);
                                },
                                value: selectedFromList,
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
                                  labelText: 'From Station',
                                  labelStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                                dropdownColor:
                                    Theme.of(context).colorScheme.tertiary,
                                    
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Select From Station';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                          selectedFromList=='Others' ? 
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: _fromController,
                                style: Theme.of(context).textTheme.bodySmall,
                                decoration: InputDecoration(
                                    labelText: 'From Station',
                                    labelStyle:
                                        Theme.of(context).textTheme.bodySmall),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter From Station';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ):const SizedBox.shrink(),
                            const SizedBox(height: 20),
                             SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: DropdownButtonFormField(
                                items:[ ...stnlst.map((valueItem) {
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
                                const DropdownMenuItem(
                                  value: 'Others',
                                  child: Text('Others'),
                                ),],
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedToList = newValue;
                                  });
                                  //selectedRouteList=null;
                                 // fetchroute(newValue);
                                },
                                value: selectedToList,
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
                                  labelText: 'To Station',
                                  labelStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                                dropdownColor:
                                    Theme.of(context).colorScheme.tertiary,
                                    
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Select To Station';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            selectedToList=='Others'?
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: _toController,
                                style: Theme.of(context).textTheme.bodySmall,
                                decoration: InputDecoration(
                                    labelText: 'To Station',
                                    labelStyle:
                                        Theme.of(context).textTheme.bodySmall),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter To Station';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ):const SizedBox.shrink(),

                            const SizedBox(height: 20),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: _startTimeController,
                                style: Theme.of(context).textTheme.bodySmall,
                                decoration: InputDecoration(
                                  labelText: 'Starting Time',
                                  labelStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                  suffixIcon: Theme(
                                      data: Theme.of(context),
                                      child: const Icon(Icons.timer)),
                                ),
                                onTap: () =>
                                    _selectTime(context, _startTimeController),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Starting Time';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: _endTimeController,
                                style: Theme.of(context).textTheme.bodySmall,
                                decoration: InputDecoration(
                                    labelText: 'End Time',
                                    labelStyle:
                                        Theme.of(context).textTheme.bodySmall,
                                    suffixIcon: Theme(
                                        data: Theme.of(context),
                                        child: const Icon(Icons.timer))),
                                onTap: () =>
                                    _selectTime(context, _endTimeController),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter End Time';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
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
                                  ],
                                ),
                              ),
                              child: Theme(
                                data: MyTheme.buttonStyleTheme,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                                  tripMasterSave();
                                              }
                                   
                                  },
                                  child: Text('SAVE',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Consumer<LoadingProvider>(
                                builder: (context, loadingProvider, child) {
                              return loadingProvider.isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Color.fromARGB(255, 2, 128, 6),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink();
                            }),
                            // showTimePicker(context: _scafoldkey.currentContext, initialTime:TimeOfDay(hour: 7, minute: 15)),
                          ],
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future tripMasterSave() async {
    final loadingProvider = _scafoldkey.currentContext!.read<LoadingProvider>();
    loadingProvider.toggleLoading();
    final registrationNo = selectedBusList;
    // final routeId = selectedRouteList;
    // print(routeId);
    String? fromStn;
    String? toStn;
    fromStn=selectedFromList=='Others'? _fromController.text:selectedFromList;
    toStn=selectedToList=='Others'? _toController.text:selectedToList;
    // final fromStation = _fromController.text;
    // final toStation = _toController.text;
    final startTime = _startTimeController.text;
    final endTime = _endTimeController.text;
    final value = await SharedPrefManager.instance.getSharedData();
    final tripMasterRequst = TripMasterReq(
        routeId: selectedRouteId,
        regNo: registrationNo,
        from: fromStn,
        to: toStn,
        ftime: startTime,
        ttime: endTime,
        userId: value!.userId);
    final tripMasterSave = await Busdata().tripMasterSave(tripMasterRequst);
    final resultAsjson = jsonDecode(tripMasterSave.toString());
    // print(resultAsjson);
    final resValue =
        TripMasterResp.fromJson(resultAsjson as Map<String, dynamic>);
    loadingProvider.toggleLoading();
    //print(resValue.status);
    if (resValue.status == 'success') {
      Fluttertoast.showToast(
          msg: "Trip details saved successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
          Navigator.pushReplacement(
                  _scafoldkey.currentContext!, Approutes().homescreen);
    } else if (resValue.status == 'Failed') {
      showerror(_scafoldkey.currentContext, 2);
    } else {
      showerror(_scafoldkey.currentContext, 3);
    }
  }

  showerror(BuildContext? buildContext, stat) {
    if (stat == 2) {
      Fluttertoast.showToast(
          msg: "Trip details  not saved",
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

  fetchroute(String? regid)async{
      routeDetailslist = await TripListFuntions.instance.sortedrouteList(regid);
      setState(() {
        
        routelist = routeDetailslist!.map((bus) {
          String routeDisplay = bus.routeName ?? "";
          String viaDisplay =
              bus.via != null && bus.via!.isNotEmpty ? "- via - ${bus.via}" : "";
          return {
            'routeId': bus.routeId!, // routeId as int
            'display': routeDisplay + viaDisplay, // Display label
          };
        }).toList();
        routelist.isEmpty?linkRoute(context):routelist;
      });
  }

   fetchfromtostn(int? routeid)async{
      stationlist = await TripListFuntions.instance.stationList(routeid);
      setState(() {
        
        stnlst =
                stationlist!.map((bus) => bus.station ?? "").toList();
      });
  }
  
  linkRoute(BuildContext context) async => showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
              title: Container(
                 height: MediaQuery.of(context).size.height/5,
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
                      padding: const EdgeInsets.symmetric(vertical:20,horizontal: 10),
                      child: Text("Please link your bus with Route",
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                        Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                                                        // StopFunctions.instance.deleteStop(tripid, stopid); 
                                                        Navigator.pushReplacement(context, Approutes().linkbusroutescreen);                                       
                                                        //  Navigator.pop(context, false);
                                                    },
                                                    child: Text(
                                                      'OK',
                                                      style: Theme.of(context).textTheme.titleMedium,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                  ],
                ),
              ),
              
            ),
      ));
}
