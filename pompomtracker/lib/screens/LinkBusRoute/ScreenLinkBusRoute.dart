import 'package:pompomtracker/core/hook/hook.dart';

class ScreenLinkBusRoute extends StatefulWidget {
  final String? registrationNumber;
  final String? routeId;
  final int flag;
  const ScreenLinkBusRoute(
      {super.key, this.registrationNumber, this.routeId, required this.flag});

  @override
  State<ScreenLinkBusRoute> createState() => _ScreenLinkBusRouteState();
}

class _ScreenLinkBusRouteState extends State<ScreenLinkBusRoute> {
  final _scafoldkey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  List<String> registarionlst = [];
  List<Map<String, Object>> routelist = [];
  String? selectedBusList;
  String? selectedRouteList;
  int? selectedRouteId;
  List<BusRegList>? busreglist = [];
  List<RouteList>? routeDetailslist = [];

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
        if (widget.registrationNumber != null && widget.flag == 1) {
          setState(() {
            selectedBusList = widget.registrationNumber;
            selectedRouteList = widget.routeId;
          });
        }
      });
    });
    //fetchBusregistraionList();
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
            "Link Bus Route",
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          )),
      body: Center(
        child: ListView(
          //scrollDirection: Axis.horizontal,
          // physics: const BouncingScrollPhysics(),
          // scrollDirection: Axis.vertical,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 45.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * .7,
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
                                      linkRouteMasterSave();
                                    },
                                    child: Text(
                                        widget.flag == 0 ? 'LINK' : 'UPDATE',
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
            ),
          ],
        ),
      ),
    );
  }

  Future linkRouteMasterSave() async {
    final loadingProvider = _scafoldkey.currentContext!.read<LoadingProvider>();
    loadingProvider.toggleLoading();
    final registrationNo = selectedBusList;
    final routeId = selectedRouteId;

    // print(widget.routeId);
    // print(routeId);
    final value = await SharedPrefManager.instance.getSharedData();
    final linkRouteMasterRequst = BusRouteLinkReq(
        regNo: registrationNo, routeId: routeId, userId: value!.userId);
    final linkRouteMasterRequstUpdate = BusRouteLinkReq(
        regNo: registrationNo,
        routeId: routeId,
        userId: value!.userId,
        oldRouteId: widget.routeId);
    dynamic linkRouteMasterSavevar;

    if (widget.flag == 0) {
      linkRouteMasterSavevar =
          await Busdata().busRouteLinkMasterSave(linkRouteMasterRequst);
    } else {
      linkRouteMasterSavevar =
          await Busdata().updateBusRouteList(linkRouteMasterRequstUpdate);
    }
    final resultAsjson = jsonDecode(linkRouteMasterSavevar.toString());
    // print(resultAsjson);
    final resValue =
        BusRouteLinkResp.fromJson(resultAsjson as Map<String, dynamic>);
    loadingProvider.toggleLoading();
    //print(resValue.status);
    if (resValue.status == 'success') {
      Fluttertoast.showToast(
          msg: "Details ${widget.flag == 0 ? 'saved' : 'updated'} successfully",
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
          msg: "Details  not saved",
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
