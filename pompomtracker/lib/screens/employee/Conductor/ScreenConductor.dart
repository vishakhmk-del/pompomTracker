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
  final _formKey = GlobalKey<FormState>();
  List<String> registarionlst = [];
  bool isVisible = true;

  String? selectedBusList;
  String? selectedStatus;

  List<BusRegList>? busreglist = [];
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _accountNosController = TextEditingController();
  final _mobileNosController = TextEditingController();
  final _emailController = TextEditingController();
  final _licenceNoController = TextEditingController();

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
        isVisible=!isVisible;
        
        final buslistDet = await ConductorListFunctions.instance
            .fetchCondcutorEditDetails(
                widget.conductor_id!, widget.flag, context);

        if (!mounted) return;
        setState(() {
          selectedBusList = buslistDet?[0].registrationNo ?? "";
          _nameController.text = buslistDet?[0].name ?? "";
          _addressController.text = buslistDet?[0].address ?? "";
          _accountNosController.text = buslistDet?[0].accountNo ?? "";
          _mobileNosController.text = buslistDet?[0].mobileNo ?? "";
          _emailController.text = buslistDet?[0].emailId ?? "";
        });
      } else if (widget.conductor_id != null && widget.flag == 2) {
        isVisible=!isVisible;

        final buslistDet = await ConductorListFunctions.instance
            .fetchCondcutorEditDetails(
                widget.conductor_id!, widget.flag, context);

        if (!mounted) return;
        setState(() {
          selectedBusList = buslistDet?[0].registrationNo ?? "";
          _nameController.text = buslistDet?[0].name ?? "";
          _addressController.text = buslistDet?[0].address ?? "";
          _accountNosController.text = buslistDet?[0].accountNo ?? "";
          _mobileNosController.text = buslistDet?[0].mobileNo ?? "";
          _emailController.text = buslistDet?[0].emailId ?? "";
          _licenceNoController.text = buslistDet[0].lisenceNo ?? "";
        });
      }
    });
    isVisible=isVisible;

  }

  Future<bool?> popscreen(BuildContext context) async {
    if (widget.flag == 0) {
      selectedEmployerNotifier.value = StatementType.conductor;
      Navigator.pushReplacement(context, Approutes().homescreen);
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
    _nameController.dispose();
    _addressController.dispose();
    _accountNosController.dispose();
    _mobileNosController.dispose();
    _emailController.dispose();
    _licenceNoController.dispose();
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
                  Navigator.pushReplacement(context, Approutes().homescreen);
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
        body: Center(
          child: ListView(
            //scrollDirection: Axis.horizontal,
            // physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              if (widget.flag == 0) ...[
                const EmployerRadioButton(
                    title: 'Add Conductor', type: StatementType.conductor),
                const EmployerRadioButton(
                    title: 'Add Driver', type: StatementType.driver),
                Column(
                  children: [
                    Container(
                      // height: MediaQuery.of(context).size.height /
                      //     1.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Consumer<RadiobuttonProvider>(
                          builder: (context, provider, child) {
                            if (provider.selectedEmployer ==
                                StatementType.conductor) {
                              return conductorForm(context);
                              // Replace with your Collection Form widget
                            } else if (provider.selectedEmployer ==
                                StatementType.driver) {
                              return driverForm(context);
                              // Replace with your Cash Form widget
                            }
                            return Container();
                            // Or some default widget
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ] else if (widget.flag == 1) ...[
                conductorForm(context),
              ] else if (widget.flag == 2) ...[
                driverForm(context),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget conductorForm(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.onSecondary),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Theme(
                data: MyTheme.googleFormTheme,
                child: Column(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/bus/busmaster.png'),
                      radius: 50,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: _nameController,
                        style: Theme.of(context).textTheme.bodySmall,
                        decoration: InputDecoration(
                            labelText: 'Conductor Name',
                            labelStyle: Theme.of(context).textTheme.bodySmall),
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
                        controller: _addressController,
                        style: Theme.of(context).textTheme.bodySmall,
                        decoration: InputDecoration(
                            labelText: 'Address',
                            labelStyle: Theme.of(context).textTheme.bodySmall),
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
                        controller: _accountNosController,
                        style: Theme.of(context).textTheme.bodySmall,
                        decoration: InputDecoration(
                            labelText: 'Account No',
                            labelStyle: Theme.of(context).textTheme.bodySmall),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Account No';
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
                            color: Theme.of(context).colorScheme.onPrimary),
                        icon: Theme(
                          data: Theme.of(context),
                          child: const Icon(
                            Icons.arrow_drop_down,
                          ),
                        ),
                        decoration: InputDecoration(
                          labelText: 'Select Bus',
                          labelStyle: Theme.of(context).textTheme.bodySmall,
                        ),
                        dropdownColor: Theme.of(context).colorScheme.tertiary,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Select Bus ';
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
                        controller: _mobileNosController,
                        style: Theme.of(context).textTheme.bodySmall,
                        decoration: InputDecoration(
                            labelText: 'Mobile No',
                            labelStyle: Theme.of(context).textTheme.bodySmall),
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
                          } else if (_mobileNosController.text.length < 10 ||
                              _mobileNosController.text.length > 10) {
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
                        controller: _emailController,
                        style: Theme.of(context).textTheme.bodySmall,
                        decoration: InputDecoration(
                            labelText: 'Email ID',
                            labelStyle: Theme.of(context).textTheme.bodySmall),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Email ID';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: isVisible,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButtonFormField(
                          items:
                              <String>['Active', 'Inactive'].map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedStatus = newValue;
                            });
                          },
                          value: selectedStatus,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                          icon: Theme(
                            data: Theme.of(context),
                            child: const Icon(
                              Icons.arrow_drop_down,
                            ),
                          ),
                          decoration: InputDecoration(
                            labelText: 'Select Status',
                            labelStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                          dropdownColor: Theme.of(context).colorScheme.tertiary,
                          validator: (value) {
                            if (value == null) {
                              return 'Select Status';
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
    );
  }

  Widget driverForm(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.onSecondary),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Theme(
                data: MyTheme.googleFormTheme,
                child: Column(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/bus/busmaster.png'),
                      radius: 50,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: _nameController,
                        style: Theme.of(context).textTheme.bodySmall,
                        decoration: InputDecoration(
                            labelText: 'Driver Name',
                            labelStyle: Theme.of(context).textTheme.bodySmall),
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
                        controller: _addressController,
                        style: Theme.of(context).textTheme.bodySmall,
                        decoration: InputDecoration(
                            labelText: 'Address',
                            labelStyle: Theme.of(context).textTheme.bodySmall),
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
                        controller: _accountNosController,
                        style: Theme.of(context).textTheme.bodySmall,
                        decoration: InputDecoration(
                            labelText: 'Account No',
                            labelStyle: Theme.of(context).textTheme.bodySmall),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Account No';
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
                            color: Theme.of(context).colorScheme.onPrimary),
                        icon: Theme(
                          data: Theme.of(context),
                          child: const Icon(
                            Icons.arrow_drop_down,
                          ),
                        ),
                        decoration: InputDecoration(
                          labelText: 'Select Bus',
                          labelStyle: Theme.of(context).textTheme.bodySmall,
                        ),
                        dropdownColor: Theme.of(context).colorScheme.tertiary,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
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
                      child: TextFormField(
                        controller: _mobileNosController,
                        style: Theme.of(context).textTheme.bodySmall,
                        decoration: InputDecoration(
                            labelText: 'Mobile No',
                            labelStyle: Theme.of(context).textTheme.bodySmall),
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
                          } else if (_mobileNosController.text.length < 10 ||
                              _mobileNosController.text.length > 10) {
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
                        controller: _licenceNoController,
                        style: Theme.of(context).textTheme.bodySmall,
                        decoration: InputDecoration(
                            labelText: 'Licence No',
                            labelStyle: Theme.of(context).textTheme.bodySmall),
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
                          } else if (_licenceNoController.text.length < 16 ||
                              _licenceNoController.text.length > 16) {
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
                        controller: _emailController,
                        style: Theme.of(context).textTheme.bodySmall,
                        decoration: InputDecoration(
                            labelText: 'Email ID',
                            labelStyle: Theme.of(context).textTheme.bodySmall),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Email ID';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: isVisible,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButtonFormField(
                          items:
                              <String>['Active', 'Inactive'].map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedStatus = newValue;
                            });
                          },
                          value: selectedStatus,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                          icon: Theme(
                            data: Theme.of(context),
                            child: const Icon(
                              Icons.arrow_drop_down,
                            ),
                          ),
                          decoration: InputDecoration(
                            labelText: 'Select Status',
                            labelStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Select Status';
                            } else {
                              return null;
                            }
                          },
                          dropdownColor: Theme.of(context).colorScheme.tertiary,
                        ),
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
    );
  }

  Future conductorMasterSave(BuildContext context) async {
    final loadingProvider = context.read<LoadingProvider>();
    loadingProvider.toggleLoading();
    final busRegNo = selectedBusList;
    final status = selectedStatus;
    final cname = _nameController.text;
    final caddress = _addressController.text;
    final accNo = _accountNosController.text;
    final mobNo = _mobileNosController.text;
    final emailId = _emailController.text;
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
          busRegNo: busRegNo,
          emailId: emailId,
          status: status,
          accNo: accNo,
          userId: value!.userId,
          ownerId: value.userId,
          role:"conductor");
      conductorMasterSavevar =
          await Busdata().conductorMasterSave(conductorMasterRequst);
    } else if (widget.flag == 1) {
      conductorMasterRequst = MasterListReq(
          conductorId: widget.conductor_id,
          cname: cname,
          caddress: caddress,
          mobNo: mobNo,
          busRegNo: busRegNo,
          emailId: emailId,
          status: status,
          accNo: accNo,
          userId: value!.userId,
          ownerId: value.userId,
          role:"conductor");
      conductorMasterSavevar =
          await Busdata().updateConductortDetails(conductorMasterRequst);
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
          msg:"Conductor details ${widget.flag == 0 ? 'saved' : 'updated'} successfully",
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
      if(resValue.flag=='exists'){
       if (!context.mounted) return;

      warningMessage(message,conductorMasterRequst,context); 
      }else{
      if (!context.mounted) return;

      showerror(context, 2, message);

      }
    } else {
      if (!context.mounted) return;

      showerror(context, 3, message);
    }
  }

  Future driverMasterSave(BuildContext context) async {
    final loadingProvider = context.read<LoadingProvider>();
    loadingProvider.toggleLoading();
    final busRegNo = selectedBusList;
    final status = selectedStatus;
    final cname = _nameController.text;
    final caddress = _addressController.text;
    final accNo = _accountNosController.text;
    final mobNo = _mobileNosController.text;
    final emailId = _emailController.text;
    final licenceNo = _licenceNoController.text;
    //print(routeId);
    dynamic conductorMasterSavevar;
    late MasterListReq conductorMasterRequst;
    final value = await SharedPrefManager.instance.getSharedData();
    if (widget.flag == 0) {
      conductorMasterRequst = MasterListReq(
          cname: cname,
          caddress: caddress,
          mobNo: mobNo,
          busRegNo: busRegNo,
          emailId: emailId,
          status: status,
          accNo: accNo,
          userId: value!.userId,
          ownerId: value.userId,
          licenceNo: licenceNo,
          role:"driver");
      conductorMasterSavevar =
          await Busdata().driverMasterSave(conductorMasterRequst);
    } else {
      conductorMasterRequst = MasterListReq(
          driverId: widget.conductor_id,
          cname: cname,
          caddress: caddress,
          mobNo: mobNo,
          busRegNo: busRegNo,
          emailId: emailId,
          status: status,
          accNo: accNo,
          userId: value!.userId,
          ownerId: value.userId,
          licenceNo: licenceNo,
          role:"driver");
      conductorMasterSavevar =
          await Busdata().updatedriverDetails(conductorMasterRequst);
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

        Navigator.push(context, Approutes().conductoscreen);
      } else if (widget.flag == 2) {
        Navigator.pushReplacement(context, Approutes().screenDriverView);
      }
    } else if (resValue.status == 'failed') {
      if(resValue.flag=='exists'){
       if (!context.mounted) return;

      warningMessage(message,conductorMasterRequst,context); 
      }else{
      if (!context.mounted) return;

      showerror(context, 2, message);

      }

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

  warningMessage(String? message,MasterListReq employeeReq, BuildContext context) async {
 

  await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: StatefulBuilder(builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text(message??'An active employee already exists for this bus', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 20,
                    width: MediaQuery.of(context).size.width / 3.2,
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
                          if(widget.flag==0){
                              final updatedReq = employeeReq.copyWith(flag: "keep");
                          ConductorListFunctions.instance.employeeStatus(updatedReq, context);
                          }else{
                            final updatedReq = employeeReq.copyWith(flag: "keep");
                          ConductorListFunctions.instance.employeeUpdateStatus(updatedReq,widget.flag, context);
                          }
                          
                        },
                        child: Text(
                          'Keep it',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 20,
                    width: MediaQuery.of(context).size.width / 3.2,
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
                          if(widget.flag==0){
                              final updatedReq = employeeReq.copyWith(flag: "change");

                              ConductorListFunctions.instance.employeeStatus(updatedReq, context);
                          }else{
                            final updatedReq = employeeReq.copyWith(flag: "change");

                            ConductorListFunctions.instance.employeeUpdateStatus(updatedReq,widget.flag, context);
                          }
                         
                        },
                        child: Text(
                          'Change',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      }),
    ),
  );
}
}
