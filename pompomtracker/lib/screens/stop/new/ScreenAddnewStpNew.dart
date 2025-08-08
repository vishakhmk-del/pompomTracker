import 'package:intl/intl.dart';
import 'package:pompomtracker/core/hook/hook.dart';

class ScreenAddNewStopNew extends StatefulWidget {
  const ScreenAddNewStopNew(
      {super.key, required this.tripName, required this.tripId});
  final String? tripName;
  final String? tripId;
  @override
  State<ScreenAddNewStopNew> createState() => _ScreenAddNewStopNewState();
}

class _ScreenAddNewStopNewState extends State<ScreenAddNewStopNew> {
  final _scafoldkey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _tripNameController = TextEditingController();
  final _stopNameController = TextEditingController();
  final _kilometerController = TextEditingController();
  final _arrivingController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  int? modeval;
  int? isstage;
  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 15);
  bool isChecked = true;
  List<Map<String, Object>> routelist = [];
  String? selectedRouteList;
  int? selectedRouteId;
  List<Listdet>? routeDetailslist = [];

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
      routeDetailslist =
          await StopFunctions.instance.stopNameList(widget.tripId);
      setState(() {
        _tripNameController.text = widget.tripName ?? "";
        routelist = routeDetailslist!.map((bus) {
          String routeDisplay = bus.stopName ?? "";

          return {
            'stopId': bus.stopId!, // routeId as int
            'display': routeDisplay, // Display label
          };
        }).toList();
      });
      if (!mounted) return;
      final checkProvider = context.read<CheckProvider>();
      checkProvider.reset();
    });

    //fetchBusregistraionList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundColorGradient(),
        Scaffold(
            backgroundColor: Colors.transparent,
            key: _scafoldkey,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              title: Text(
                'Add New Stop',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Card(
                  margin: const EdgeInsets.all(5),
                  elevation: 3,
                  child: Container(
                    //height: MediaQuery.of(context).size.height * .85,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.onSecondary),
                        borderRadius: BorderRadius.circular(12)),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 0),
                        child: Theme(
                          data: MyTheme.googleFormTheme,
                          child: Column(
                            children: [
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/bus/busmaster.png'),
                                radius: 50,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 5, right: 5),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: _tripNameController,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    decoration: InputDecoration(
                                        labelText: 'Route Name',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Route Name';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 0, right: 0),
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      FormatRadioButton(
                                        title: 'Before',
                                        type: StatementType.before,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        txtstyl: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                      FormatRadioButton(
                                        title: 'After',
                                        type: StatementType.after,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        txtstyl: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          // width: MediaQuery.of(context).size.width / 2,
                                          child: DropdownButtonFormField(
                                            items: routelist.map((busMap) {
                                              return DropdownMenuItem<String>(
                                                value:
                                                    busMap['stopId'] as String,
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
                                              labelText: 'Stop Name',
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                            dropdownColor: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Select Stop Name';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 5, right: 5),
                                  child: TextFormField(
                                    controller: _stopNameController,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    decoration: InputDecoration(
                                        labelText: 'Stop Name',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Stop Name';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 5, right: 5),
                                  child: TextFormField(
                                    controller: _arrivingController,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    decoration: InputDecoration(
                                        labelText: 'Arriving Time',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        suffixIcon: Theme(
                                            data: Theme.of(context),
                                            child: Icon(Icons.timer,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary))),
                                    onTap: () => _selectTime(
                                        context, _arrivingController),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Value';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 5, right: 5),
                                      child: TextFormField(
                                        controller: _kilometerController,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        decoration: InputDecoration(
                                          labelText: 'Kilo Meter',
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
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
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 5, right: 5),
                                      child: TextFormField(
                                        controller: _latitudeController,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        decoration: InputDecoration(
                                          labelText: 'Latitude',
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 5, right: 5),
                                      child: TextFormField(
                                        controller: _longitudeController,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        decoration: InputDecoration(
                                          labelText: 'Longitude',
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30.0, bottom: 20),
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
                                        if (_formKey.currentState!.validate()) {
                                          final tripid = widget.tripId;
                                          final stopid = selectedRouteList;
                                          var proval = context
                                              .read<RadiobuttonProvider>();
                                          final mode = proval.selectedFormat;

                                          if (mode == StatementType.after) {
                                            modeval = flag1;
                                          } else {
                                            modeval = flag0;
                                          }
                                          // var pro = context.read<CheckProvider>();
                                          // final val = pro.isAccepted;
                                          //   if(val==true){
                                          //     isstage=flag1;
                                          //   }else{
                                          //     isstage=flag0;
                                          //   }
                                          final stpname =
                                              _stopNameController.text;
                                          final arvtime =
                                              _arrivingController.text;
                                          final km = _kilometerController.text;
                                          final lat = _latitudeController.text;
                                          final long =
                                              _longitudeController.text;
                                          final sharevalue =
                                              await SharedPrefManager.instance
                                                  .getSharedData();
                                          final usrid = sharevalue!.userId;
                                          final value = MasterListReq(
                                            tripId: tripid,
                                            after: modeval,
                                            stopId: stopid,
                                            stopName: stpname,
                                            arrivingTime: arvtime,
                                            km: km,
                                            latitude: lat,
                                            longitude: long,
                                            userId: usrid,
                                            //isStage: isstage
                                          );
                                          if (!context.mounted) return;
                                          stopSaveFun(context, value);
                                        }
                                      },
                                      child: Text(
                                        'SAVE',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Future stopSaveFun(BuildContext context, MasterListReq val) async {
    final loadingProvider = context.read<LoadingProvider>();
    //False to true
    loadingProvider.reset();
    loadingProvider.toggleLoading();
    final stopMasterResp = await StopFunctions.instance.addstopName(val);
    //True to false
    loadingProvider.toggleLoading();

    if (stopMasterResp == 'success') {
      StopFunctions.instance.stopDetFn(widget.tripId);
      if (!context.mounted) return;
      Navigator.pop(context, false);
      // Navigator.pushReplacement(
      //     _scafoldkey.currentContext!, Approutes().stopListScreenNew);
    }
  }
}
