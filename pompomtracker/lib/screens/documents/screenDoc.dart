import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/function/documents/documentFun.dart';
import 'package:pompomtracker/model/bus_master/bus_list_resp/document_list.dart';
import 'package:pompomtracker/model/permit_master/doctypelist.dart';
import 'package:pompomtracker/model/permit_master/permit_list.dart';

class ScreenDoc extends StatefulWidget {
  final int? flag;
  final DocumentList? docData;
  const ScreenDoc({super.key, this.flag, this.docData});

  @override
  State<ScreenDoc> createState() => _ScreenDocState();
}

class _ScreenDocState extends State<ScreenDoc> {
  final _formkey = GlobalKey<FormState>();
  final _scafoldkey = GlobalKey<ScaffoldState>();
  final _dateValidFromController = TextEditingController();
  final _dateValidToController = TextEditingController();
  // String? selectedBusType;
  // List<String> busTypeList = [];
  List<PermitList>? permitlist = [];
  List<Doctypelist>? docTypelist = [];
  List<BusRegList>? busreglist = [];

  List<Map<String, Object>> permitdoclist = [];
  List<Map<String, Object>> doctypelist = [];
  List<Map<String, Object?>> registarionlst = [];

  String? selectedPermitList;
  String? selectedDocTypeList;
  String? selectedBusList;
  int? selectedFlag;

  @override
  void initState() {
    super.initState();
    // fetchBusList();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var po = context.read<CheckProvider>();
      po.reset();
      docTypelist = await Wklycollectfn.instance.fetchDocTypeList(context);
      if (!mounted) return;

      permitlist = await Wklycollectfn.instance.fetchPermitList(context);
      if (!mounted) return;

      busreglist = await Wklycollectfn.instance.busReglistfn(context);

      setState(() {
        doctypelist = docTypelist!.map((doc) {
          String permitDisplay = doc.docType ?? "";
          return {
            'id': doc.id!, // routeId as int
            'display': permitDisplay, // Display label
            'flag': doc.docFlag!, // Display label
          };
        }).toList();

        permitdoclist = permitlist!.map((bus) {
          String permitDisplay = bus.permitNo ?? "";
          // String viaDisplay =
          //     bus.via != null && bus.via!.isNotEmpty ? " via - ${bus.via}" : "";
          return {
            'permitId': bus.permitId!,
            'display': permitDisplay // Display label
          };
        }).toList();

        registarionlst = busreglist?.map((bus) {
              return <String, Object?>{
                'busId': bus.busId,
                'display': bus.registrationNo,
              };
            }).toList() ??
            [];
      });

      if (widget.docData != null && widget.flag == 1) {
        final doc = widget.docData!;

        final selectedDoc = doctypelist.firstWhere(
          (item) => item['id'].toString() == doc.docTypeId?.toString(),
          orElse: () => <String, Object>{},
        );

        setState(() {
          // Document Type
          selectedDocTypeList = doc.docTypeId?.toString();

          // Automatically get document type flag
          selectedFlag = selectedDoc['flag'] as int?;

          // Bus
          // IMPORTANT: keep null if this document has no bus
          selectedBusList = doc.busId;

          // Permit
          // IMPORTANT: keep null if this document has no permit
          selectedPermitList = doc.permitId;

          // Valid From
          if (doc.validFrom != null && doc.validFrom!.isNotEmpty) {
            _dateValidFromController.text = DateFormat('dd-MM-yyyy').format(
              DateTime.parse(doc.validFrom!),
            );
          }

          // Valid To
          if (doc.validTo != null && doc.validTo!.isNotEmpty) {
            _dateValidToController.text = DateFormat('dd-MM-yyyy').format(
              DateTime.parse(doc.validTo!),
            );
          }

          // Notify Expiry
          final notifyExpiry =
              int.tryParse(doc.notifyExpiry?.toString() ?? '') ?? 0;

          final check = context.read<CheckProvider>();

          if (notifyExpiry > 0) {
            check.setNeeded(true);
            check.setNotificationDays(notifyExpiry);
          } else {
            check.setNeeded(false);
            check.setNotificationDays(null);
          }
        });
      }
    });
  }

  Future<bool?> popscreen(BuildContext context) async {
    Navigator.pushReplacement(context, Approutes().docListScreen);
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
            backgroundColor: Color(0xFFE0F7F1),
            appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // if (widget.flag == 0) {
                    //   Navigator.pushReplacement(_scafoldkey.currentContext!,
                    //       Approutes().mainScreen);
                    // } else {
                    //   Navigator.pushReplacement(_scafoldkey.currentContext!,
                    //       Approutes().busListNewScreen);
                    // }

                    Navigator.pushReplacement(
                        context, Approutes().docListScreen);
                  },
                ),
                title: Text(
                  "Documents",
                  style: TextStyle(color: Colors.white),
                )),
            body: Center(
              child: ListView(children: [
                SingleChildScrollView(
                  child: Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Colors.black.withOpacity(0.25), // light black
                        width: 1,
                      ),
                    ),
                    child: Container(
                      // height: MediaQuery.of(context).size.height * .9,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
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
                                  Center(
                                    child: Text(
                                      widget.flag == 1
                                          ? "Update Document"
                                          : "Add Documents",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: DropdownButtonFormField(
                                      dropdownColor: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      items: doctypelist.map((busMap) {
                                        final routeText =
                                            (busMap['display'] as String);

                                        return DropdownMenuItem<String>(
                                            value:
                                                busMap['id']?.toString() ?? '',
                                            child: RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: '$routeText\n',
                                                  ),
                                                ],
                                              ),
                                            ));
                                      }).toList(),
                                      onChanged: widget.flag == 1
                                          ? null
                                          : (String? newValue) {
                                              setState(() {
                                                selectedDocTypeList = newValue;
                                                // selectedRouteId = int.parse(newValue!);
                                                // Store the selected routeId
                                                final selectedDoc =
                                                    doctypelist.firstWhere(
                                                  (doc) =>
                                                      doc['id'].toString() ==
                                                      newValue,
                                                  orElse: () => {},
                                                );
                                                // Update flag
                                                selectedFlag =
                                                    selectedDoc['flag'] as int?;
                                                print(
                                                    'Selected Document ID: $selectedDocTypeList');
                                                print(
                                                    'Selected Document Flag: $selectedFlag');
                                              });
                                            },
                                      value: selectedDocTypeList,
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
                                        labelText: 'Select Document Type',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(color: Colors.black),
                                      ),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Select Document Type';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Visibility(
                                    visible: selectedFlag == 1 ? false : true,
                                    child: SizedBox(
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

                                        onChanged: widget.flag == 1
                                            ? null
                                            : (newValue) {
                                                setState(() {
                                                  selectedBusList = newValue;
                                                });
                                              },

                                        // Selected bus ID
                                        value: selectedBusList,

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
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Visibility(
                                    visible: selectedFlag == 1 ? true : false,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: DropdownButtonFormField(
                                        dropdownColor: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        items: permitdoclist.map((busMap) {
                                          final routeText =
                                              (busMap['display'] as String);
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
                                                  ],
                                                ),
                                              ));
                                        }).toList(),
                                        onChanged: widget.flag == 1
                                            ? null
                                            : (String? newValue) {
                                                setState(() {
                                                  selectedPermitList = newValue;
                                                });
                                              },
                                        value: selectedPermitList,
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
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: TextFormField(
                                      controller: _dateValidFromController,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(color: Colors.black),
                                      decoration: InputDecoration(
                                        labelText: 'Valid From',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(color: Colors.black),
                                        suffixIcon: Icon(Icons.calendar_today,
                                            color: Colors.black),
                                      ),
                                      onTap: () => _selectDate(
                                          context, _dateValidFromController),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Select Date';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: TextFormField(
                                      controller: _dateValidToController,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(color: Colors.black),
                                      decoration: InputDecoration(
                                        labelText: 'Valid To',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(color: Colors.black),
                                        suffixIcon: Icon(Icons.calendar_today,
                                            color: Colors.black),
                                      ),
                                      onTap: () => _selectDate(
                                          context, _dateValidToController),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Select Date';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Consumer<CheckProvider>(
                                    builder: (context, check, _) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                value: check.isNeeded,
                                                side: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.5,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                ),
                                                fillColor: WidgetStateProperty
                                                    .resolveWith<Color?>(
                                                  (states) {
                                                    if (states.contains(
                                                        WidgetState.selected)) {
                                                      return Colors.black;
                                                    }
                                                    return Colors.transparent;
                                                  },
                                                ),
                                                checkColor: Colors.white,
                                                onChanged: (value) {
                                                  check.setNeeded(
                                                      value ?? false);
                                                },
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "Do you want to receive an expiry notification?",
                                                  textAlign: TextAlign.left,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge
                                                      ?.copyWith(
                                                        color: Colors.black,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          if (check.isNeeded)
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child:
                                                  DropdownButtonFormField<int>(
                                                value: check.notificationDays,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      'Notify before expiry',
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        color: Colors.black,
                                                      ),
                                                  border:
                                                      const OutlineInputBorder(),
                                                ),
                                                items: const [
                                                  DropdownMenuItem(
                                                    value: 1,
                                                    child: Text('1 day before'),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 3,
                                                    child:
                                                        Text('3 days before'),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 7,
                                                    child:
                                                        Text('7 days before'),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 15,
                                                    child:
                                                        Text('15 days before'),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 30,
                                                    child:
                                                        Text('30 days before'),
                                                  ),
                                                ],
                                                onChanged: (value) {
                                                  check.setNotificationDays(
                                                      value);
                                                },
                                                validator: (value) {
                                                  if (check.isNeeded &&
                                                      value == null) {
                                                    return 'Select notification days';
                                                  }

                                                  return null;
                                                },
                                              ),
                                            ),
                                          const SizedBox(height: 20),
                                        ],
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  widget.flag == 0
                                      ? Container(
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
                                              onPressed: () async {
                                                if (_formkey.currentState!
                                                    .validate()) {
                                                  final doctype =
                                                      selectedDocTypeList;
                                                  final busid = selectedBusList;
                                                  final permitId =
                                                      selectedPermitList;
                                                  final fromDate =
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(
                                                    DateFormat('dd-MM-yyyy').parse(
                                                        _dateValidFromController
                                                            .text),
                                                  );

                                                  final toDate =
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(
                                                    DateFormat('dd-MM-yyyy')
                                                        .parse(
                                                            _dateValidToController
                                                                .text),
                                                  );
                                                  final check = context
                                                      .read<CheckProvider>();

                                                  final int? notificationDays =
                                                      check.notificationDays;

                                                  final value =
                                                      await SharedPrefManager
                                                          .instance
                                                          .getSharedData();

                                                  final busMasterReq =
                                                      BusMasterReq(
                                                          docType: doctype,
                                                          busId: busid,
                                                          permitId: permitId,
                                                          vfrom: fromDate,
                                                          vto: toDate,
                                                          userId: value!.userId,
                                                          notifyExpiry:
                                                              notificationDays);

                                                  if (!context.mounted) return;

                                                  await DocumentsFun.instance
                                                      .documentSave(
                                                          busMasterReq,
                                                          context);

                                                  // busMasterSave(context);
                                                }
                                              },
                                              child: Text('SAVE',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium),
                                            ),
                                          ),
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
                                              onPressed: () async{
                                                if (_formkey.currentState!.validate()) {
                          
                                                  final fromDate =
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(
                                                    DateFormat('dd-MM-yyyy').parse(
                                                        _dateValidFromController
                                                            .text),
                                                  );

                                                  final toDate =
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(
                                                    DateFormat('dd-MM-yyyy')
                                                        .parse(
                                                            _dateValidToController
                                                                .text),
                                                  );
                                                  final check = context
                                                      .read<CheckProvider>();

                                                  final int? notificationDays =
                                                      check.notificationDays;

                                                  final value =
                                                      await SharedPrefManager
                                                          .instance
                                                          .getSharedData();

                                                  final busMasterReq =
                                                      BusMasterReq(
                                                          documentId:widget.docData?.documentId??'',
                                                          vfrom: fromDate,
                                                          vto: toDate,
                                                          userId: value!.userId,
                                                          notifyExpiry:notificationDays,
                                                          );

                                                  if (!context.mounted) return;

                                                  await DocumentsFun.instance
                                                      .documentUpdate(
                                                          busMasterReq,
                                                          context);

                                                  // busMasterSave(context);
                                                }
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

  // Future<void> _selectDate(
  //     BuildContext context, TextEditingController controller) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );
  //   if (picked != null) {
  //     setState(() {
  //       controller.text = "${picked.toLocal()}".split(' ')[0];
  //     });
  //   }
  // }
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 5)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked == null) {
      return;
    } else {
      setState(() {
        controller.text =
            "${picked.toLocal().day}-${picked.toLocal().month}-${picked.toLocal().year}";
        log(controller.text);
      });
    }
  }

  Future busMasterSave(BuildContext context) async {
    final loadingProvider = _scafoldkey.currentContext!.read<LoadingProvider>();
    loadingProvider.toggleLoading();
    final fromDate = _dateValidFromController.text;
    final toDate = _dateValidToController.text;
    // final selectedBus = selectedBusType;
    final value = await SharedPrefManager.instance.getSharedData();
    // print(value);
    dynamic busMasterResp;
    final busMasterReq = BusMasterReq(
        vfrom: fromDate, vto: toDate, userId: value!.userId, active: '0');

    if (widget.flag == 0) {
      busMasterResp = await Busdata().busMasterSave(busMasterReq);
    } else {
      //print('pdate');
      busMasterResp = await Busdata().updateBus(busMasterReq);
    }
    loadingProvider.reset();

    final resultAsjson = jsonDecode(busMasterResp.toString());
    final busResponseValue =
        BusMasterResp.fromJson(resultAsjson as Map<String, dynamic>);
    //True to false
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
