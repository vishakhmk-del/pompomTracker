import 'package:pompomtracker/core/hook/hook.dart';

class ScreenConductor extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final String? conductor_id;
  final int flag;

  const ScreenConductor({super.key, this.conductor_id, required this.flag});

  @override
  State<ScreenConductor> createState() => _ScreenconductorState();
}

class _ScreenconductorState extends State<ScreenConductor> {
  final _scafoldkey = GlobalKey<ScaffoldState>();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  List<String> registarionlst = [];
  bool isVisible = true;

  String? selectedBusList;
  String? selectedStatus;

  List<BusRegList>? busreglist = [];
  final _condnameController = TextEditingController();
  final _condaddressController = TextEditingController();
  final _condaccountNosController = TextEditingController();
  final _condmobileNosController = TextEditingController();
  final _condemailController = TextEditingController();
  final _condlicenceNoController = TextEditingController();

  final _drvnameController = TextEditingController();
  final _drvaddressController = TextEditingController();
  final _drvaccountNosController = TextEditingController();
  final _drvmobileNosController = TextEditingController();
  final _drvemailController = TextEditingController();
  final _drvlicenceNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Fetch the bus registration list
      busreglist = await Wklycollectfn.instance.busReglistfn(context);

      Future.delayed(Duration.zero, () {
        if (mounted) {
          context.read<RadiobuttonProvider>().reset();
        }
      });

      if (!mounted) return;
      setState(() {
        registarionlst =
            busreglist!.map((bus) => bus.registrationNo ?? "").toList();
      });

      final loadingProvider = context.read<LoadingProvider>();
      loadingProvider.reset();
      // Conductor edit display
      if (widget.conductor_id != null && widget.flag == 1) {
        isVisible = !isVisible;

        final buslistDet = await ConductorListFunctions.instance
            .fetchCondcutorEditDetails(
                widget.conductor_id!, widget.flag, context);

        if (!mounted) return;
        setState(() {
          // selectedBusList = buslistDet?[0].registrationNo ?? "";
          _condnameController.text = buslistDet?[0].name ?? "";
          _condaddressController.text = buslistDet?[0].address ?? "";
          _condaccountNosController.text = buslistDet?[0].accountNo ?? "";
          _condlicenceNoController.text = buslistDet?[0].lisenceNo ?? "";
          _condmobileNosController.text = buslistDet?[0].mobileNo ?? "";
          _condemailController.text = buslistDet?[0].emailId ?? "";
        });
      } else if (widget.conductor_id != null && widget.flag == 2) {
        isVisible = !isVisible;

        final buslistDet = await ConductorListFunctions.instance
            .fetchCondcutorEditDetails(
                widget.conductor_id!, widget.flag, context);

        if (!mounted) return;
        setState(() {
          selectedBusList = buslistDet?[0].registrationNo ?? "";
          _drvnameController.text = buslistDet?[0].name ?? "";
          _drvaddressController.text = buslistDet?[0].address ?? "";
          _drvaccountNosController.text = buslistDet?[0].accountNo ?? "";
          _drvmobileNosController.text = buslistDet?[0].mobileNo ?? "";
          _drvemailController.text = buslistDet?[0].emailId ?? "";
          _drvlicenceNoController.text = buslistDet[0].lisenceNo ?? "";
        });
      }
    });
    isVisible = isVisible;
  }

  Future<bool?> popscreen(BuildContext context) async {
    if (widget.flag == 0) {
      selectedEmployerNotifier.value = StatementType.conductor;
      Navigator.pushReplacement(context, Approutes().mainScreen);
      return true;
    } else if (widget.flag == 1) {
      Navigator.pushReplacement(context, Approutes().conductorListScreen);
      return true;
    } else if (widget.flag == 2) {
      Navigator.pushReplacement(context, Approutes().screenDriverView);
      return true;
    }
    return true;
  }

  @override
  void dispose() {
    _condnameController.dispose();
    _condaddressController.dispose();
    _condaccountNosController.dispose();
    _condmobileNosController.dispose();
    _condemailController.dispose();
    _condlicenceNoController.dispose();

    _drvnameController.dispose();
    _drvaddressController.dispose();
    _drvaccountNosController.dispose();
    _drvmobileNosController.dispose();
    _drvemailController.dispose();
    _drvlicenceNoController.dispose();
    super.dispose();
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
      child: Scaffold(
        key: _scafoldkey,
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (widget.flag == 0) {
                  selectedEmployerNotifier.value = StatementType.conductor;
                  Navigator.pushReplacement(context, Approutes().mainScreen);
                } else if (widget.flag == 1) {
                  Navigator.pushReplacement(
                      context, Approutes().conductorListScreen);
                } else if (widget.flag == 2) {
                  Navigator.pushReplacement(
                      context, Approutes().screenDriverView);
                }
              },
            ),
            title: Text(
              "Add Employee",
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onSecondary),
            )),
        body: widget.flag == 0
            ? DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      labelColor: Theme.of(context).colorScheme.onPrimary,
                      unselectedLabelColor:
                          Theme.of(context).colorScheme.onSurface,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.onPrimaryFixed,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: const [
                        Tab(text: "Conductor"),
                        Tab(text: "Driver"),
                        Tab(text: "Assign Employee"),
                      ],
                    ),
                    Expanded(
                      child: Card(
                        margin: const EdgeInsets.only(
                            top: 3, left: 10, right: 10, bottom: 10),
                        elevation: 3,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Theme.of(context)
                                        .colorScheme
                                        .onPrimaryFixed,
                                    Theme.of(context).colorScheme.onPrimary,
                                  ])),
                          child: TabBarView(
                            children: [
                              conductorForm(context),
                              driverForm(context),
                              const ScreenEmployeeAssign()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    if (widget.flag == 1)
                      Card(
                          margin: const EdgeInsets.only(
                              top: 3, left: 10, right: 10),
                          elevation: 3,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Theme.of(context)
                                            .colorScheme
                                            .onPrimaryFixed,
                                        Theme.of(context).colorScheme.onPrimary,
                                      ])),
                              child: conductorForm(context))),
                    if (widget.flag == 2)
                      Card(
                          margin: const EdgeInsets.only(
                              top: 3, left: 10, right: 10),
                          elevation: 3,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Theme.of(context)
                                            .colorScheme
                                            .onPrimaryFixed,
                                        Theme.of(context).colorScheme.onPrimary,
                                      ])),
                              child: driverForm(context))),
                  ],
                ),
              ),
      ),
    );
  }

  Widget conductorForm(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
        child: Container(
          // height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            border:
                Border.all(color: Theme.of(context).colorScheme.onSecondary),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Form(
              key: _formKey1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Theme(
                  data: MyTheme.googleFormTheme,
                  child: Column(
                    children: [
                      Text("Add Conductor",
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: _condnameController,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                              labelText: 'Conductor Name',
                              labelStyle:
                                  Theme.of(context).textTheme.bodySmall),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Conductor Name';
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
                        child: TextFormField(
                          controller: _condaddressController,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                              labelText: 'Address',
                              labelStyle:
                                  Theme.of(context).textTheme.bodySmall),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Address';
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
                        child: TextFormField(
                          controller: _condaccountNosController,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                              labelText: 'Account No',
                              labelStyle:
                                  Theme.of(context).textTheme.bodySmall),
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Enter Account No';
                          //   } else {
                          //     return null;
                          //   }
                          // },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: _condlicenceNoController,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                              labelText: 'Licence No',
                              labelStyle:
                                  Theme.of(context).textTheme.bodySmall),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(16),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: _condmobileNosController,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                              labelText: 'Mobile No',
                              labelStyle:
                                  Theme.of(context).textTheme.bodySmall),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Mobile Number";
                            } else if (value.contains('.') ||
                                value.contains("-") ||
                                value.contains(" ") ||
                                value.contains(",")) {
                              return "Enter valid Mobile Number";
                            } else if (_condmobileNosController.text.length <
                                    10 ||
                                _condmobileNosController.text.length > 10) {
                              return "Enter valid Mobile number";
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
                        child: TextFormField(
                          controller: _condemailController,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                              labelText: 'Email ID',
                              labelStyle:
                                  Theme.of(context).textTheme.bodySmall),
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Enter Email ID';
                          //   } else {
                          //     return null;
                          //   }
                          // },
                        ),
                      ),

                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // Visibility(
                      //   visible: isVisible,
                      //   child: SizedBox(
                      //     width: MediaQuery.of(context).size.width,
                      //     child: DropdownButtonFormField(
                      //       items:
                      //           <String>['Active', 'Inactive'].map((String value) {
                      //         return DropdownMenuItem(
                      //           value: value,
                      //           child: Text(
                      //             value,
                      //             style: TextStyle(
                      //                 color: Theme.of(context)
                      //                     .colorScheme
                      //                     .onSecondary),
                      //           ),
                      //         );
                      //       }).toList(),
                      //       onChanged: (newValue) {
                      //         setState(() {
                      //           selectedStatus = newValue;
                      //         });
                      //       },
                      //       value: selectedStatus,
                      //       style: TextStyle(
                      //           color: Theme.of(context).colorScheme.onPrimary),
                      //       icon: Theme(
                      //         data: Theme.of(context),
                      //         child: const Icon(
                      //           Icons.arrow_drop_down,
                      //         ),
                      //       ),
                      //       decoration: InputDecoration(
                      //         labelText: 'Select Status',
                      //         labelStyle: Theme.of(context).textTheme.bodySmall,
                      //       ),
                      //       dropdownColor: Theme.of(context).colorScheme.tertiary,
                      //       validator: (value) {
                      //         if (value == null) {
                      //           return 'Select Status';
                      //         } else {
                      //           return null;
                      //         }
                      //       },
                      //     ),
                      //   ),
                      // ),
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
                              if (_formKey1.currentState!.validate()) {
                                conductorMasterSave(context);
                              }
                            },
                            child: Text(widget.flag == 0 ? 'SAVE' : 'UPDATE',
                                style: Theme.of(context).textTheme.titleMedium),
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
                      // showTimePicker(context: _scafoldkey.currentContext, initialTime:TimeOfDay(hour: 7, minute: 15)),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  Widget driverForm(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
        child: Container(
          // height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            border:
                Border.all(color: Theme.of(context).colorScheme.onSecondary),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Form(
              key: _formKey2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Theme(
                  data: MyTheme.googleFormTheme,
                  child: Column(
                    children: [
                      Text("Add Driver",
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: _drvnameController,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                              labelText: 'Driver Name',
                              labelStyle:
                                  Theme.of(context).textTheme.bodySmall),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Driver Name';
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
                        child: TextFormField(
                          controller: _drvaddressController,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                              labelText: 'Address',
                              labelStyle:
                                  Theme.of(context).textTheme.bodySmall),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Address';
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
                        child: TextFormField(
                          controller: _drvaccountNosController,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                              labelText: 'Account No',
                              labelStyle:
                                  Theme.of(context).textTheme.bodySmall),
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Enter Account No';
                          //   } else {
                          //     return null;
                          //   }
                          // },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: _drvmobileNosController,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                              labelText: 'Mobile No',
                              labelStyle:
                                  Theme.of(context).textTheme.bodySmall),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Mobile Number";
                            } else if (value.contains('.') ||
                                value.contains("-") ||
                                value.contains(" ") ||
                                value.contains(",")) {
                              return "Enter valid Mobile Number";
                            } else if (_drvmobileNosController.text.length <
                                    10 ||
                                _drvmobileNosController.text.length > 10) {
                              return "Enter valid Mobile number";
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
                        child: TextFormField(
                          controller: _drvlicenceNoController,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                              labelText: 'Licence No',
                              labelStyle:
                                  Theme.of(context).textTheme.bodySmall),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(16),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Licence Number";
                            } else if (value.contains('.') ||
                                value.contains("-") ||
                                value.contains(" ") ||
                                value.contains(",")) {
                              return "Enter valid Licence Number";
                            } else if (_drvlicenceNoController.text.length <
                                    16 ||
                                _drvlicenceNoController.text.length > 16) {
                              return "Enter valid Licence number";
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
                        child: TextFormField(
                          controller: _drvemailController,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                              labelText: 'Email ID',
                              labelStyle:
                                  Theme.of(context).textTheme.bodySmall),
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Enter Email ID';
                          //   } else {
                          //     return null;
                          //   }
                          // },
                        ),
                      ),

                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // Visibility(
                      //   visible: isVisible,
                      //   child: SizedBox(
                      //     width: MediaQuery.of(context).size.width,
                      //     child: DropdownButtonFormField(
                      //       items:
                      //           <String>['Active', 'Inactive'].map((String value) {
                      //         return DropdownMenuItem(
                      //           value: value,
                      //           child: Text(
                      //             value,
                      //             style: TextStyle(
                      //                 color: Theme.of(context)
                      //                     .colorScheme
                      //                     .onSecondary),
                      //           ),
                      //         );
                      //       }).toList(),
                      //       onChanged: (newValue) {
                      //         setState(() {
                      //           selectedStatus = newValue;
                      //         });
                      //       },
                      //       value: selectedStatus,
                      //       style: TextStyle(
                      //           color: Theme.of(context).colorScheme.onPrimary),
                      //       icon: Theme(
                      //         data: Theme.of(context),
                      //         child: const Icon(
                      //           Icons.arrow_drop_down,
                      //         ),
                      //       ),
                      //       decoration: InputDecoration(
                      //         labelText: 'Select Status',
                      //         labelStyle: Theme.of(context).textTheme.bodySmall,
                      //       ),
                      //       validator: (value) {
                      //         if (value == null) {
                      //           return 'Select Status';
                      //         } else {
                      //           return null;
                      //         }
                      //       },
                      //       dropdownColor: Theme.of(context).colorScheme.tertiary,
                      //     ),
                      //   ),
                      // ),
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
                              if (_formKey2.currentState!.validate()) {
                                driverMasterSave(context);
                              }
                            },
                            child: Text(widget.flag == 0 ? 'SAVE' : 'UPDATE',
                                style: Theme.of(context).textTheme.titleMedium),
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
                      // showTimePicker(context: _scafoldkey.currentContext, initialTime:TimeOfDay(hour: 7, minute: 15)),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  Future conductorMasterSave(BuildContext context) async {
    final loadingProvider = context.read<LoadingProvider>();
    loadingProvider.toggleLoading();
    //final status = selectedStatus;
    final cname = _condnameController.text;
    final caddress = _condaddressController.text;
    final accNo = _condaccountNosController.text;
    final mobNo = _condmobileNosController.text;
    final emailId = _condemailController.text;
    final lsncNO = _condlicenceNoController.text;

    //final licenceNo = _licenceNoController.text;
    //print(routeId);
    dynamic conductorMasterSavevar;
    late MasterListReq conductorMasterRequst;
    final value = await SharedPrefManager.instance.getSharedData();
    if (widget.flag == 0) {
      conductorMasterRequst = MasterListReq(
          cname: cname,
          caddress: caddress,
          mobNo: mobNo,
          emailId: emailId,
          accNo: accNo,
          licenceNo: lsncNO,
          ownerId: value!.userId,
          role: 3);
      conductorMasterSavevar = await Busdata().empSave(conductorMasterRequst);
    } else if (widget.flag == 1) {
      conductorMasterRequst = MasterListReq(
          empId: widget.conductor_id,
          cname: cname,
          caddress: caddress,
          mobNo: mobNo,
          emailId: emailId,
          accNo: accNo,
          licenceNo: lsncNO,
          ownerId: value!.userId,
          role: 3);
      conductorMasterSavevar =
          await Busdata().updateEmpDetails(conductorMasterRequst);
    }

    final resultAsjson = jsonDecode(conductorMasterSavevar.toString());
    // print(resultAsjson);
    final resValue =
        ConductorResp.fromJson(resultAsjson as Map<String, dynamic>);
    //print(resValue.status);
    loadingProvider.toggleLoading();
    //print(resValue.status);
    final message = resValue.message.toString();
    if (resValue.status == 'success') {
      Fluttertoast.showToast(
          msg:
              "Conductor details ${widget.flag == 0 ? 'saved' : 'updated'} successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
      if (!context.mounted) return;
      if (widget.flag == 0) {
        selectedEmployerNotifier.value = StatementType.conductor;

        Navigator.pushReplacement(context, Approutes().conductoscreen);
      } else if (widget.flag == 1) {
        Navigator.pushReplacement(context, Approutes().conductorListScreen);
      }
    } else if (resValue.status == 'failed') {
      if (!context.mounted) return;

      showerror(context, 2, message);
    } else {
      if (!context.mounted) return;

      showerror(context, 3, message);
    }
  }

  Future driverMasterSave(BuildContext context) async {
    final loadingProvider = context.read<LoadingProvider>();
    loadingProvider.toggleLoading();
    // final status = selectedStatus;
    final cname = _drvnameController.text;
    final caddress = _drvaddressController.text;
    final accNo = _drvaccountNosController.text;
    final mobNo = _drvmobileNosController.text;
    final emailId = _drvemailController.text;
    final licenceNo = _drvlicenceNoController.text;
    //print(routeId);
    dynamic conductorMasterSavevar;
    late MasterListReq conductorMasterRequst;
    final value = await SharedPrefManager.instance.getSharedData();
    if (widget.flag == 0) {
      conductorMasterRequst = MasterListReq(
          cname: cname,
          caddress: caddress,
          mobNo: mobNo,
          emailId: emailId,
          //   status: status,
          accNo: accNo,
          ownerId: value!.userId,
          licenceNo: licenceNo,
          role: 5);
      conductorMasterSavevar = await Busdata().empSave(conductorMasterRequst);
    } else {
      conductorMasterRequst = MasterListReq(
          empId: widget.conductor_id,
          cname: cname,
          caddress: caddress,
          mobNo: mobNo,
          emailId: emailId,
          //  status: status,
          accNo: accNo,
          ownerId: value!.userId,
          licenceNo: licenceNo,
          role: 5);
      conductorMasterSavevar =
          await Busdata().updateEmpDetails(conductorMasterRequst);
    }

    //print(conductorMasterSavevar);
    final resultAsjson = jsonDecode(conductorMasterSavevar.toString());
    // print(resultAsjson);
    final resValue =
        ConductorResp.fromJson(resultAsjson as Map<String, dynamic>);
    //print(resValue.status);
    loadingProvider.toggleLoading();
    //print(resValue.status);
    final message = resValue.message.toString();
    if (resValue.status == 'success') {
      Fluttertoast.showToast(
          msg:
              "Driver details ${widget.flag == 0 ? 'saved' : 'updated'} successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
      if (!context.mounted) return;
      if (widget.flag == 0) {
        selectedEmployerNotifier.value = StatementType.conductor;

        Navigator.pushReplacement(context, Approutes().conductoscreen);
      } else if (widget.flag == 2) {
        Navigator.pushReplacement(context, Approutes().screenDriverView);
      }
    } else if (resValue.status == 'failed') {
      if (!context.mounted) return;

      showerror(context, 2, message);
    } else {
      if (!context.mounted) return;

      showerror(context, 3, message);
    }
  }

  showerror(BuildContext? buildContext, stat, msg) {
    if (stat == 2) {
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
    }
  }
}
