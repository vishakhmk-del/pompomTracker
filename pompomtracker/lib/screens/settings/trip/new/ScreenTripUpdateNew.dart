import 'package:intl/intl.dart';
import 'package:pompomtracker/core/hook/hook.dart';

class ScreenTripUpdateNew extends StatefulWidget {
  final String? trip_id;
  final String? regNo;
  final String? bus;

  final int flag;
  const ScreenTripUpdateNew(
      {super.key, this.trip_id, this.regNo, this.bus, required this.flag});

  @override
  State<ScreenTripUpdateNew> createState() => _ScreenTripUpdateNewState();
}

class _ScreenTripUpdateNewState extends State<ScreenTripUpdateNew> {
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
      busreglist = await Wklycollectfn.instance.busReglistfn(context);
      if (!mounted) return;

      routeDetailslist = await Wklycollectfn.instance.fetchRouteList(context);
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
      if (widget.regNo != null && widget.flag == 1) {
        final triplistDet = await TripListFuntions.instance
            .tripEditFun(widget.regNo, widget.trip_id);
        setState(() {
          // print(widget.regNo);
          // print(triplistDet?[0].routeId);
          selectedBusList = widget.regNo;
          selectedRouteList = triplistDet?[0].routeId ?? "";
          _fromController.text = triplistDet?[0].fromStation ?? "";
          _toController.text = triplistDet?[0].toStation ?? "";
          _startTimeController.text = triplistDet?[0].startTime ?? "";
          _endTimeController.text = triplistDet?[0].endTime ?? "";
          selectedRouteId = int.parse(triplistDet?[0].routeId ?? "");
        });
      }
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

  Future<bool?> popscreen(BuildContext context) async {
    if (widget.flag == 0) {
      Navigator.pushReplacement(context, Approutes().settingscreen);
      return true;
    } else {
      Navigator.push(context, Approutes().tripListNewScreen);
      return true;
    }
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
                    if (widget.flag == 0) {
                      Navigator.pushReplacement(
                          context, Approutes().settingscreen);
                    } else {
                      Navigator.push(context, Approutes().tripListNewScreen);
                    }
                  },
                ),
                title: Text(
                  "Trip Master",
                  style: TextStyle(color: Colors.white),
                )),
            body: Center(
              child: ListView(
                children: [
                  SingleChildScrollView(
                    child: Card(
                      margin: const EdgeInsets.all(5),
                      elevation: 5,
                      child: Container(
                        // height: MediaQuery.of(context).size.height * .8,
                        margin: const EdgeInsets.all(10),
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
                                      backgroundImage: AssetImage(
                                          'assets/bus/busmaster.png'),
                                      radius: 50,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: IgnorePointer(
                                        ignoring:
                                            widget.flag == 0 ? false : true,
                                        child: DropdownButtonFormField(
                                          items:
                                              registarionlst.map((valueItem) {
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
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: IgnorePointer(
                                        ignoring:
                                            widget.flag == 0 ? false : true,
                                        child: DropdownButtonFormField(
                                          items: routelist.map((busMap) {
                                            return DropdownMenuItem<String>(
                                              value:
                                                  busMap['routeId'] as String,
                                              // Use routeId as the value
                                              child: ConstrainedBox(
                                                constraints:
                                                    const BoxConstraints(
                                                        maxWidth: 200),
                                                child: Text(
                                                  busMap['display']
                                                      as String, // Display the route name and via
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                              selectedRouteId =
                                                  int.parse(newValue!);
                                              // Store the selected routeId
                                            });
                                          },
                                          value: selectedRouteList,
                                          // Use the selected routeId
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ),
                                          icon: Theme(
                                            data: Theme.of(context),
                                            child: const Icon(
                                              Icons.arrow_drop_down,
                                            ),
                                          ),
                                          decoration: InputDecoration(
                                            labelText: 'Select Route',
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          dropdownColor: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Select Route';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: TextFormField(
                                        readOnly: true,
                                        controller: _fromController,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        decoration: InputDecoration(
                                            labelText: 'From Station',
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
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
                                        readOnly: true,
                                        controller: _toController,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        decoration: InputDecoration(
                                            labelText: 'To Station',
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        decoration: InputDecoration(
                                          labelText: 'Starting Time',
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          suffixIcon: Theme(
                                              data: Theme.of(context),
                                              child: const Icon(Icons.timer)),
                                        ),
                                        onTap: () => _selectTime(
                                            context, _startTimeController),
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        decoration: InputDecoration(
                                            labelText: 'End Time',
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                            suffixIcon: Theme(
                                                data: Theme.of(context),
                                                child:
                                                    const Icon(Icons.timer))),
                                        onTap: () => _selectTime(
                                            context, _endTimeController),
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
                                            Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ],
                                        ),
                                      ),
                                      child: Theme(
                                        data: MyTheme.buttonStyleTheme,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            tripMasterSave(context);
                                          },
                                          child: Text(
                                              widget.flag == 0
                                                  ? 'SAVE'
                                                  : 'UPDATE',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Consumer<LoadingProvider>(builder:
                                        (context, loadingProvider, child) {
                                      return loadingProvider.isLoading
                                          ? const Center(
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  Color.fromARGB(
                                                      255, 2, 128, 6),
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future tripMasterSave(BuildContext context) async {
    final loadingProvider = _scafoldkey.currentContext!.read<LoadingProvider>();
    loadingProvider.toggleLoading();
    final registrationNo = selectedBusList;
    final routeId = selectedRouteId;
    print(routeId);
    final fromStation = _fromController.text;
    final toStation = _toController.text;
    final startTime = _startTimeController.text;
    final endTime = _endTimeController.text;
    final value = await SharedPrefManager.instance.getSharedData();
    dynamic tripMasterSave;
    late TripMasterReq tripMasterRequst;
    if (widget.flag == 0) {
      tripMasterRequst = TripMasterReq(
          routeId: routeId,
          regNo: registrationNo,
          from: fromStation,
          to: toStation,
          ftime: startTime,
          ttime: endTime,
          userId: value!.userId);
      tripMasterSave = await Busdata().tripMasterSave(tripMasterRequst);
    } else {
      tripMasterRequst = TripMasterReq(
          routeId: routeId,
          regNo: registrationNo,
          from: fromStation,
          to: toStation,
          ftime: startTime,
          ttime: endTime,
          userId: value!.userId,
          tripId: widget.trip_id);
      tripMasterSave = await Busdata().tripMasterUpdate(tripMasterRequst);
    }

    final resultAsjson = jsonDecode(tripMasterSave.toString());
    // print(resultAsjson);
    final resValue =
        TripMasterResp.fromJson(resultAsjson as Map<String, dynamic>);
    loadingProvider.toggleLoading();
    //print(resValue.status);
    if (resValue.status == 'success') {
      Fluttertoast.showToast(
          msg:
              "Trip details ${widget.flag == 0 ? 'saved' : 'updated'} successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
      await TripListFuntions.instance.getTripList(widget.bus);
      if (!context.mounted) return;
      Navigator.push(context, Approutes().tripListNewScreen);
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
