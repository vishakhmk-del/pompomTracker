import 'dart:developer';

import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/model/permit_master/permit_list.dart';

class ScreenLinkBusRouteNew extends StatefulWidget {
  final String? registrationNumber;
  final String? busId;
  final String? permitId;

  final String? routeId;
  final int flag;
  const ScreenLinkBusRouteNew(
      {super.key,
      this.registrationNumber,
      this.permitId,
      this.routeId,
      this.busId,
      required this.flag});

  @override
  State<ScreenLinkBusRouteNew> createState() => _ScreenLinkBusRouteNewState();
}

class _ScreenLinkBusRouteNewState extends State<ScreenLinkBusRouteNew> {
  final _scafoldkey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  List<Map<String, Object?>> registarionlst = [];
  List<Map<String, Object>> routelist = [];
  String? selectedBusList;
  String? selectedRouteList;
  int? selectedRouteId;
  List<BusRegList>? busreglist = [];
  List<PermitList>? permitlist = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // fetchRouteList();

      busreglist = await Wklycollectfn.instance.busReglistfn(context);
      if (!mounted) return;

      permitlist = await Wklycollectfn.instance.fetchPermitList(context);
      setState(() {
        registarionlst = busreglist?.map((bus) {
              return <String, Object?>{
                'busId': bus.busId,
                'display': bus.registrationNo,
              };
            }).toList() ??
            [];
        //calling registarion list  from main model

        routelist = permitlist!.map((bus) {
          String routeDisplay = bus.permitNo ?? "";
          // String viaDisplay =
          //     bus.via != null && bus.via!.isNotEmpty ? " via - ${bus.via}" : "";
          return {
            'permitId': bus.permitId!, // routeId as int
            'display': routeDisplay // Display label
          };
        }).toList();
        if (widget.registrationNumber != null && widget.flag == 1) {
          setState(() {
            selectedBusList = widget.busId;
            selectedRouteList = widget.permitId;
          });
        }
      });
    });
  }

  Future<bool?> popscreen(BuildContext context) async {
    if (widget.flag == 0) {
      Navigator.pushReplacement(context, Approutes().settingscreen);
    } else {
      Navigator.pushReplacement(context, Approutes().busRouteListNewScreen);
    }
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
            // key: _scafoldkey,
            backgroundColor: Color(0xFFE0F7F1),
            appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    if (widget.flag == 0) {
                      Navigator.pushReplacement(
                          context, Approutes().settingscreen);
                    } else {
                      Navigator.pushReplacement(
                          context, Approutes().busRouteListNewScreen);
                    }
                  },
                ),
                title: Text(
                  "Link Bus Permit",
                  style: TextStyle(color: Colors.white),
                )),
            body: Center(
              child: ListView(
                //scrollDirection: Axis.horizontal,
                // physics: const BouncingScrollPhysics(),
                // scrollDirection: Axis.vertical,
                children: [
                  SingleChildScrollView(
                    child: Card(
                      color: Colors.white,
                      margin: const EdgeInsets.all(10),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Colors.black.withOpacity(0.25), // light black
                          width: 1,
                        ),
                      ),
                      child: Container(
                        //height: MediaQuery.of(context).size.height * .7,
                        margin: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
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
                                      child: DropdownButtonFormField<String>(
                                        dropdownColor: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        items: registarionlst.map((busMap) {
                                          final busText =
                                              busMap['display'] as String? ??
                                                  '';

                                          return DropdownMenuItem<String>(
                                            // enabled: widget.flag==0?false:true,
                                            value: busMap['busId'] as String,
                                            child: Text(
                                              busText,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        // onChanged: (newValue) {
                                        //   setState(() {
                                        //     selectedBusList = newValue;
                                        //   });
                                        // },
                                        // value: selectedBusList,
                                        onChanged: widget.flag == 1
                                            ? null
                                            : (newValue) {
                                                setState(() {
                                                  selectedBusList = newValue;
                                                });
                                              },

                                        // Selected bus ID
                                        value: registarionlst.any(
                                          (bus) =>
                                              bus['busId'] == selectedBusList,
                                        )
                                            ? selectedBusList
                                            : null,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                        icon: Theme(
                                          data: Theme.of(context),
                                          child: const Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black,
                                          ),
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'Select Bus',
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(color: Colors.black),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Select Bus';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: DropdownButtonFormField(
                                        dropdownColor: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        items: routelist.map((busMap) {
                                          final routeText =
                                              (busMap['display'] as String);
                                          // First part
                                          // final viaPart = routeText.length > 1
                                          //     ? 'via - ${routeText[1]}'
                                          //     : '';
                                          return DropdownMenuItem<String>(
                                              value:
                                                  busMap['permitId'] as String,
                                              // Use routeId as the value
                                              child: RichText(
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          '$routeText\n', // Route name on the first line
                                                    ),
                                                    // TextSpan(
                                                    //   text:
                                                    //       viaPart, // "via" part on the second line
                                                    //   style: TextStyle(
                                                    //     color: Theme.of(context)
                                                    //         .colorScheme
                                                    //         .onSecondary,
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ));
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedRouteList = newValue;
                                            // selectedRouteId = int.parse(newValue!);
                                            // Store the selected routeId
                                          });
                                        },
                                        value: selectedRouteList,
                                        // Use the selected routeId
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                        icon: Theme(
                                          data: Theme.of(context),
                                          child: const Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black,
                                          ),
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'Select Permit No',
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(color: Colors.black),
                                        ),

                                        validator: (value) {
                                          if (value == null) {
                                            return 'Select Permit No';
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
                                    widget.flag == 0
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                                  data:
                                                      MyTheme.buttonStyleTheme,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      linkRouteMasterSave(
                                                          context);
                                                    },
                                                    child: Text('LINK',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                                  data:
                                                      MyTheme.buttonStyleTheme,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          Approutes()
                                                              .busRouteListNewScreen);
                                                    },
                                                    child: Text(
                                                      'VIEW',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                                  linkRouteMasterSave(context);
                                                },
                                                child: Text('UPDATE',
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

  Future linkRouteMasterSave(BuildContext context) async {
    if (!context.mounted) return;
    final loadingProvider = context.read<LoadingProvider>();
    loadingProvider.toggleLoading();
    final busid = selectedBusList;
    final permitid = selectedRouteList;

    // print(widget.routeId);
    // print(routeId);
    final value = await SharedPrefManager.instance.getSharedData();
    final linkRouteMasterRequst = BusRouteLinkReq(
        userId: value!.userId, permitId: permitid, busId: busid);
    final linkRouteMasterRequstUpdate = BusRouteLinkReq(
      busId: busid,
      permitId: permitid,
      userId: value.userId,
      oldRouteId: widget.routeId,
      // permitId:
    );
    dynamic linkRouteMasterSavevar;

    if (widget.flag == 0) {
      linkRouteMasterSavevar =
          await Busdata().permitBusLinkSave(linkRouteMasterRequst);
    } else {
      linkRouteMasterSavevar =
          await Busdata().permitBusLinkUpdate(linkRouteMasterRequstUpdate);
    }
    final resultAsjson = jsonDecode(linkRouteMasterSavevar.toString());
    // print(resultAsjson);
    final resValue =
        BusRouteLinkResp.fromJson(resultAsjson as Map<String, dynamic>);
    loadingProvider.toggleLoading();
    //print(resValue.status);
    if (resValue.status == 'success') {
      loadingProvider.reset();

      Fluttertoast.showToast(
          msg: "Details ${widget.flag == 0 ? 'saved' : 'updated'} successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
      if (!context.mounted) return;
      widget.flag == 0
          ? Navigator.push(context, Approutes().settingscreen)
          : Navigator.push(context, Approutes().busRouteListNewScreen);
    } else if (resValue.status == 'failed') {
      loadingProvider.reset();

      showerror(_scafoldkey.currentContext, 2, resValue.message);
    } else {
      loadingProvider.reset();

      showerror(_scafoldkey.currentContext, 3, resValue.message);
    }
  }

  showerror(BuildContext? buildContext, stat, msg) {
    if (stat == 2) {
      Fluttertoast.showToast(
          msg: msg ?? "Already exist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
    } else {
      Fluttertoast.showToast(
          msg: msg ?? "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
    }
  }
}
