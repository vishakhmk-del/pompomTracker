import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pompomtracker/core/hook/hook.dart';

class ScreenTrip extends StatefulWidget {
  const ScreenTrip({super.key});

  @override
  State<ScreenTrip> createState() => _ScreenTriptState();
}

class _ScreenTriptState extends State<ScreenTrip> {
  final _scafoldkey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  List<String> registarionlst = [];
  List<Map<String, Object>> routelist = [];
  String? selectedBusList;
  String? selectedRouteList;
  int? selectedRouteId;
  List<BusRegList>? busreglist = [];
  List<RouteList>? routeDetailslist = [];
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
      routeDetailslist = await Wklycollectfn.instance.fetchRouteList();
      setState(() {
        registarionlst =
            busreglist!.map((bus) => bus.registrationNo ?? "").toList();
        //calling registarion list  from main model

        routelist = routeDetailslist!.map((bus) {
          String routeDisplay = bus.routeName ?? "";
          String viaDisplay =
              bus.via != null && bus.via!.isNotEmpty ? " via - ${bus.via}" : "";
          return {
            'routeId': bus.routeId!, // routeId as int
            'display': routeDisplay + viaDisplay, // Display label
          };
        }).toList();
      });
    });
    //fetchBusregistraionList();
  }

  // void fetchBusregistraionList() async {
  //   final value = await SharedPrefManager.instance.getSharedData();
  //   RegistrationReq registrationReq = RegistrationReq(userId: value!.userId);
  //   final getRegList = await Busdata().getBusRegistartionList(registrationReq);
  //   if (getRegList == null) {
  //   } else {
  //     final resultAsJson = jsonDecode(getRegList.toString());
  //     final registrationList =
  //         RegistrationResp.fromJson(resultAsJson as Map<String, dynamic>);
  //     //this is the registraion response model (main model)

  //     setState(() {
  //       registarionlst = registrationList.busList!
  //           .map((bus) => bus.registrationNo ?? "")
  //           .toList(); //calling registarion list  from main model
  //     });
  //   }
  // }

  /*void fetchRouteList() async {
    final value = await SharedPrefManager.instance.getSharedData();
    GetRouteReq routeReq = GetRouteReq(userId: value!.userId, userType: '3');
    final getRouteList = await Busdata().getRouteList(routeReq);
    final resultAsJson = jsonDecode(getRouteList.toString());
    final routeList =
        GerRouteResp.fromJson(resultAsJson as Map<String, dynamic>);

    setState(() {
      routelist = routeList.routeList!.map((bus) {
        String routeDisplay = bus.routeName ?? "";
        String viaDisplay =
            bus.via != null && bus.via!.isNotEmpty ? " via - ${bus.via}" : "";
        return {
          'routeId': bus.routeId!, // routeId as int
          'display': routeDisplay + viaDisplay, // Display label
        };
      }).toList();
    });
  }
*/
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
          //scrollDirection: Axis.horizontal,
          // physics: const BouncingScrollPhysics(),
          // scrollDirection: Axis.vertical,
          children: [
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * .9,
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
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedRouteList = newValue;
                                    selectedRouteId = int.parse(newValue!);
                                    // Store the selected routeId
                                  });
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
                            const SizedBox(height: 20),
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
                            ),
                            const SizedBox(height: 20),
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
                            ),

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
                                    tripMasterSave();
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
    final fromStation = _fromController.text;
    final toStation = _toController.text;
    final startTime = _startTimeController.text;
    final endTime = _endTimeController.text;
    final value = await SharedPrefManager.instance.getSharedData();
    final tripMasterRequst = TripMasterReq(
        routeId: selectedRouteId,
        regNo: registrationNo,
        from: fromStation,
        to: toStation,
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
}
