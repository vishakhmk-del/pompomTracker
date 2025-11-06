import 'package:pompomtracker/core/hook/hook.dart';

class ScreenBusMasterNew extends StatefulWidget {
  final String? regNo;
  final int flag;
  const ScreenBusMasterNew({super.key, this.regNo, required this.flag});

  @override
  State<ScreenBusMasterNew> createState() => _ScreenBusMasterNewState();
}

class _ScreenBusMasterNewState extends State<ScreenBusMasterNew> {
  final _formkey = GlobalKey<FormState>();
  final _scafoldkey = GlobalKey<ScaffoldState>();
  final _nameControler = TextEditingController();
  final _shortnameControler = TextEditingController();
  final _registartionNoControler = TextEditingController();
  final _permitNoController = TextEditingController();
  final _dateValidController = TextEditingController();
  final _dateToController = TextEditingController();
  String? selectedBusType;
  List<String> busTypeList = [];

  @override
  void initState() {
    super.initState();
    fetchBusList();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.flag == 1 && widget.regNo != null) {
        final buslistDet =
            await BusListFunctions.instance.fetchBusEditDetails(widget.regNo!);
        _nameControler.text = buslistDet?[0].busName ?? "";
        _shortnameControler.text = buslistDet?[0].shortName ?? "";
        _registartionNoControler.text = buslistDet?[0].registrationNo ?? "";
        _permitNoController.text = buslistDet?[0].permitNo ?? "";
        _dateValidController.text = buslistDet?[0].validFrom ?? "";
        _dateToController.text = buslistDet?[0].validTo ?? "";
        selectedBusType = buslistDet?[0].busType ?? "";
        // print(selectedBusType);
      }
    });
  }

  void fetchBusList() async {
    // API call
    final getBusList = await Busdata().getBusList();
    final resultJson = jsonDecode(getBusList.toString());
    final busType = Bustype.fromJson(resultJson as Map<String, dynamic>);

    setState(() {
      busTypeList = busType.busList!.map((bus) => bus.typeId ?? "").toList();
    });
  }

  // void fetchBusEditDetails(String regNo) async {
  //   BusEditReq busEditReq = BusEditReq(regNo: regNo);
  //   final getEditDet = await Busdata().fetchBusEditDetails(busEditReq);
  //   if (getEditDet != null) {
  //     final resultJson = jsonDecode(getEditDet.toString());
  //     final Details = BusEditResp.fromJson(resultJson as Map<String, dynamic>);
  //     final buslist_det = Details.busDetails;

  //     setState(() {
  //       _nameControler.text = buslist_det?[0].busName ?? "";
  //       _shortnameControler.text = buslist_det?[0].shortName ?? "";
  //       _registartionNoControler.text = buslist_det?[0].registrationNo ?? "";
  //       _permitNoController.text = buslist_det?[0].permitNo ?? "";
  //       _dateValidController.text = buslist_det?[0].validFrom ?? "";
  //       _dateToController.text = buslist_det?[0].validTo ?? "";
  //       selectedBusType = buslist_det?[0].busType ?? "";
  //     });
  //   }
  // }

  Future<bool?> popscreen(BuildContext context) async {
    Navigator.push(context, Approutes().settingscreen);
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
        //  log('BackButton pressed!');
      },
      child: Stack(
        children: [
          BackgroundColorGradient(),
          Scaffold(
            key: _scafoldkey,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (widget.flag == 0) {
                      Navigator.pushReplacement(_scafoldkey.currentContext!,
                          Approutes().settingscreen);
                    } else {
                      Navigator.pushReplacement(_scafoldkey.currentContext!,
                          Approutes().busListNewScreen);
                    }
                  },
                ),
                title: Text(
                  "Add Bus",
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
                        margin: const EdgeInsets.only(
                            top: 10, left: 10, right: 10, bottom: 10),
                        elevation: 3,
                        child: Container(
                          // height: MediaQuery.of(context).size.height * .9,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
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
                                      const CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/bus/busmaster.png'),
                                        radius: 50,
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                          controller: _nameControler,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          decoration: InputDecoration(
                                              labelText: 'Name',
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter name';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                          controller: _shortnameControler,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          decoration: InputDecoration(
                                              labelText: 'Short Name',
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter Short Name';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                          controller: _registartionNoControler,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          decoration: InputDecoration(
                                              labelText: 'Registration No',
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter Registartion No';
                                            } else {
                                              return null;
                                            }
                                          },
                                          enabled: widget.flag == 0,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                          controller: _permitNoController,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          decoration: InputDecoration(
                                              labelText: 'Permit No',
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter Permit No';
                                            } else {
                                              return null;
                                            }
                                          },
                                          enabled: widget.flag == 0,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      DropdownButtonFormField(
                                        items: busTypeList.map((valueItem) {
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
                                            selectedBusType = newValue;
                                          });
                                        },
                                        value: selectedBusType,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                        icon: Theme(
                                            data: Theme.of(context),
                                            child: const Icon(
                                              Icons.arrow_drop_down,
                                            )),
                                        decoration: InputDecoration(
                                          labelText: 'Bus Type',
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
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                      TextFormField(
                                        controller: _dateValidController,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        decoration: InputDecoration(
                                          labelText: 'Valid From',
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          suffixIcon: Theme(
                                              data: Theme.of(context),
                                              child: const Icon(
                                                Icons.calendar_today,
                                              )),
                                        ),
                                        onTap: () => _selectDate(
                                            context, _dateValidController),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Select Date';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                      TextFormField(
                                        controller: _dateToController,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        decoration: InputDecoration(
                                          labelText: 'Valid To',
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          suffixIcon: Theme(
                                            data: Theme.of(context),
                                            child: const Icon(
                                              Icons.calendar_today,
                                            ),
                                          ),
                                        ),
                                        onTap: () => _selectDate(
                                            context, _dateToController),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Select Date';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      widget.flag == 0
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
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
                                                    data: MyTheme
                                                        .buttonStyleTheme,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                         if (_formkey.currentState!.validate()) {
                                                             busMasterSave(context);
                                                          }
                                                                             
                                                      },
                                                      child: Text('SAVE',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
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
                                                    data: MyTheme
                                                        .buttonStyleTheme,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        //busMasterSave(context);
                                                        Navigator.push(
                                                            context,
                                                            Approutes()
                                                                .busListNewScreen);
                                                      },
                                                      child: Text('VIEW',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium),
                                                    ),
                                                  ),
                                                )
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
                                                    busMasterSave(context);
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
                                                child:
                                                    CircularProgressIndicator(
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
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future busMasterSave(BuildContext context) async {
    final loadingProvider = _scafoldkey.currentContext!.read<LoadingProvider>();
    //false to true
    loadingProvider.toggleLoading();
    final name = _nameControler.text;
    final shortName = _shortnameControler.text;
    final registerNo = _registartionNoControler.text;
    final permitNo = _permitNoController.text;
    final fromDate = _dateValidController.text;
    final toDate = _dateToController.text;
    final selectedBus = selectedBusType;
    final value = await SharedPrefManager.instance.getSharedData();
    // print(value);
    dynamic busMasterResp;
    final busMasterReq = BusMasterReq.req(
        busName: name,
        shName: shortName,
        regno: registerNo,
        busType: selectedBus,
        permitno: permitNo,
        vfrom: fromDate,
        vto: toDate,
        userId: value!.userId,
        active: '1');

    if (widget.flag == 0) {
      busMasterResp = await Busdata().busMasterSave(busMasterReq);
    } else {
      //print('pdate');
      busMasterResp = await Busdata().updateBus(busMasterReq);
    }

    final resultAsjson = jsonDecode(busMasterResp.toString());
    final busResponseValue =
        BusMasterResp.fromJson(resultAsjson as Map<String, dynamic>);
    //True to false
    loadingProvider.toggleLoading();
    // print(busResponseValue.status);
    if (busMasterResp == null) {
      showerror(_scafoldkey.currentContext!, 1);
    } else if (busResponseValue.status == 'success') {
      loadingProvider.reset();

      // print('sucess');
      Fluttertoast.showToast(
          msg:
              "Bus details ${widget.flag == 0 ? 'saved' : 'updated'} successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
      if (!context.mounted) return;
      widget.flag == 0
          ? Navigator.pushReplacement(context, Approutes().busmasternewscreen)
          : Navigator.pushReplacement(context, Approutes().busListNewScreen);
    } else if (busResponseValue.status == 'failed') {
      loadingProvider.reset();

      showerror(_scafoldkey.currentContext!, 2);
    } else {
      loadingProvider.reset();

      showerror(_scafoldkey.currentContext!, 1);
    }
  }

  showerror(BuildContext? buildContext, stat) {
    if (stat == 2) {
      Fluttertoast.showToast(
          msg: "Bus details not saved",
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
