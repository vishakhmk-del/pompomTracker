import 'package:pompomtracker/core/hook/hook.dart';

class ScreenBusMater extends StatefulWidget {
  const ScreenBusMater({super.key});

  @override
  State<ScreenBusMater> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ScreenBusMater> {
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
            "Bus Master",
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          )),
      body: Center(
          child: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.all(20),
          elevation: 50,
          shadowColor: Theme.of(context).colorScheme.primary,
          child: SizedBox(
            width: 500,
            height: MediaQuery.of(context).size.height,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Theme(
                      data: MyTheme.googleFormTheme,
                      child: Column(
                        children: [
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/bus/busmaster.png'),
                            radius: 50,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: TextFormField(
                              controller: _nameControler,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                              decoration: InputDecoration(
                                labelText: 'Name',
                                labelStyle:
                                    Theme.of(context).textTheme.labelSmall,
                              ),
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
                            width: MediaQuery.of(context).size.width,
                            child: TextFormField(
                              controller: _shortnameControler,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                              decoration: InputDecoration(
                                labelText: 'Short Name',
                                labelStyle:
                                    Theme.of(context).textTheme.labelSmall,
                              ),
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
                            width: MediaQuery.of(context).size.width,
                            child: TextFormField(
                              controller: _registartionNoControler,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                              decoration: InputDecoration(
                                labelText: 'Registartion No',
                                labelStyle:
                                    Theme.of(context).textTheme.labelSmall,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Registartion No';
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
                            width: MediaQuery.of(context).size.width,
                            child: TextFormField(
                              controller: _permitNoController,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                              decoration: InputDecoration(
                                labelText: 'Permit No',
                                labelStyle:
                                    Theme.of(context).textTheme.labelSmall,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Permit No';
                                } else {
                                  return null;
                                }
                              },
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
                                color: Theme.of(context).colorScheme.onPrimary),
                            icon: Theme(
                                data: MyTheme.appIconTheme,
                                child: const Icon(
                                  Icons.arrow_drop_down,
                                )),
                            decoration: InputDecoration(
                              labelText: 'Bus Type',
                              labelStyle:
                                  Theme.of(context).textTheme.labelSmall,
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
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                          ),
                          TextFormField(
                            controller: _dateValidController,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                            decoration: InputDecoration(
                              labelText: 'Valid From',
                              labelStyle:
                                  Theme.of(context).textTheme.labelSmall,
                              suffixIcon: Theme(
                                  data: MyTheme.appIconTheme,
                                  child: const Icon(
                                    Icons.calendar_today,
                                  )),
                            ),
                            onTap: () =>
                                _selectDate(context, _dateValidController),
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
                            width: MediaQuery.of(context).size.width,
                          ),
                          TextFormField(
                            controller: _dateToController,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                            decoration: InputDecoration(
                              labelText: 'Valid To',
                              labelStyle:
                                  Theme.of(context).textTheme.labelSmall,
                              suffixIcon: Theme(
                                data: MyTheme.appIconTheme,
                                child: const Icon(
                                  Icons.calendar_today,
                                ),
                              ),
                            ),
                            onTap: () =>
                                _selectDate(context, _dateToController),
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
                          ElevatedButton(
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                await busMasterSave();
                              }
                            },
                            child: const Text('SAVE'),
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
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ),
      )),
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

  Future busMasterSave() async {
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
    final busMasterResp = await Busdata().busMasterSave(busMasterReq);
    final resultAsjson = jsonDecode(busMasterResp.toString());
    final busResponseValue =
        BusMasterResp.fromJson(resultAsjson as Map<String, dynamic>);
    //True to false
    loadingProvider.toggleLoading();
    // print(busResponseValue.status);
    if (busMasterResp == null) {
      showerror(_scafoldkey.currentContext!, 1);
    } else if (busResponseValue.status == 'success') {
      // print('sucess');
      Fluttertoast.showToast(
          msg: "Bus details saved successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
    } else if (busResponseValue.status == 'Failed') {
      showerror(_scafoldkey.currentContext!, 2);
    } else {
      showerror(_scafoldkey.currentContext!, 1);
    }
  }

  showerror(BuildContext? buildContext, stat) {
    if (stat == 2) {
      Fluttertoast.showToast(
          msg: "Bus details  not saved",
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
