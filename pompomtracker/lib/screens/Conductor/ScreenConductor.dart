import 'package:flutter/material.dart';
import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/model/conductor_master/conductor_req/conductor_req.dart';
import 'package:pompomtracker/model/conductor_master/conductor_resp/conductor_resp.dart';

class ScreenConductor extends StatefulWidget {
  const ScreenConductor({super.key});

  @override
  State<ScreenConductor> createState() => _ScreenconductorState();
}

class _ScreenconductorState extends State<ScreenConductor> {
  final _scafoldkey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  List<String> registarionlst = [];

  String? selectedBusList;
  String? selectedStatus;

  List<BusRegList>? busreglist = [];
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _accountNosController = TextEditingController();
  final _mobileNosController = TextEditingController();
  final _emailController = TextEditingController();

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
            "Add Conductor",
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
                              child: TextFormField(
                                controller: _nameController,
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
                                controller: _addressController,
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
                                controller: _accountNosController,
                                style: Theme.of(context).textTheme.bodySmall,
                                decoration: InputDecoration(
                                    labelText: 'Account No',
                                    labelStyle:
                                        Theme.of(context).textTheme.bodySmall),
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
                              child: TextFormField(
                                controller: _mobileNosController,
                                style: Theme.of(context).textTheme.bodySmall,
                                decoration: InputDecoration(
                                    labelText: 'Mobile No',
                                    labelStyle:
                                        Theme.of(context).textTheme.bodySmall),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Mobile No';
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
                                controller: _emailController,
                                style: Theme.of(context).textTheme.bodySmall,
                                decoration: InputDecoration(
                                    labelText: 'Email ID',
                                    labelStyle:
                                        Theme.of(context).textTheme.bodySmall),
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: DropdownButtonFormField(
                                items: <String>['Active', 'Inactive']
                                    .map((String value) {
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
                                  labelText: 'Select Status',
                                  labelStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                                dropdownColor:
                                    Theme.of(context).colorScheme.tertiary,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Select Status';
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
                                    conductorMasterSave();
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

  Future conductorMasterSave() async {
    final loadingProvider = _scafoldkey.currentContext!.read<LoadingProvider>();
    loadingProvider.toggleLoading();
    final busRegNo = selectedBusList;
    final status = selectedStatus;
    final cname = _nameController.text;
    final caddress = _addressController.text;
    final accNo = _accountNosController.text;
    final mobNo = _mobileNosController.text;
    final emailId = _emailController.text;
    //print(routeId);
    final value = await SharedPrefManager.instance.getSharedData();
    final conductorMasterRequst = ConductorReq(
        cname: cname,
        caddress: caddress,
        mobNo: mobNo,
        busRegNo: busRegNo,
        emailId: emailId,
        status: status,
        accNo: accNo,
        userId: value!.userId,
        ownerId: value.userId);
    final conductorMasterSavevar =
        await Busdata().conductorMasterSave(conductorMasterRequst);
    final resultAsjson = jsonDecode(conductorMasterSavevar.toString());
    // print(resultAsjson);
    final resValue =
        ConductorResp.fromJson(resultAsjson as Map<String, dynamic>);
    loadingProvider.toggleLoading();
    //print(resValue.status);
    final message = resValue.message.toString();
    if (resValue.status == 'success') {
      Fluttertoast.showToast(
          msg: 'Saved Succesfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
    } else if (resValue.status == 'Failed') {
      showerror(_scafoldkey.currentContext, 2, message);
    } else {
      showerror(_scafoldkey.currentContext, 3, message);
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
