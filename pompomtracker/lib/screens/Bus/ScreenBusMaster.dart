import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/model/bus_master/bus_master_req/bus_master_req.dart';
import 'package:pompomtracker/model/bus_master/bus_master_resp/bus_master_resp.dart';
import 'package:pompomtracker/model/bustype/bus_list.dart';
import 'package:pompomtracker/model/bustype/bustype.dart';

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
      busTypeList = busType.busList!.map((bus) => bus.typeId!).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Bus Master",
        style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
      )),
      key: _scafoldkey,
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
                                child: Text(valueItem),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedBusType = newValue;
                              });
                            },
                            value: selectedBusType,
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                            decoration: InputDecoration(
                              labelText: 'Bus Type',
                              labelStyle:
                                  Theme.of(context).textTheme.labelSmall,
                            ),
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
                              suffixIcon: const Icon(Icons.calendar_today),
                            ),
                            onTap: () =>
                                _selectDate(context, _dateValidController),
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
                              suffixIcon: const Icon(Icons.calendar_today),
                            ),
                            onTap: () =>
                                _selectDate(context, _dateToController),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              busMasterSave();
                            },
                            child: Text('SAVE'),
                          )
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
    final name = _nameControler.text;
    final shortName = _shortnameControler.text;
    final registerNo = _registartionNoControler.text;
    final permoitNo = _permitNoController.text;
    final fromDate = _dateValidController.text;
    final toDate = _dateToController.text;
    final selectedBus = selectedBusType;
    final busMasterReq = BusMasterReq.req(
        busName: name,
        shName: shortName,
        regno: registerNo,
        busType: selectedBus,
        permitno: permoitNo,
        vfrom: fromDate,
        vto: toDate,
        userId: 'OWN00001',
        active: '1');
    final busMasterResp = await Busdata().busMasterSave(busMasterReq);
    final resultAsjson = jsonDecode(busMasterResp.toString());
    final busResponseValue =
        BusMasterResp.fromJson(resultAsjson as Map<String, dynamic>);
    //print(busResponseValue.status);
    if (busResponseValue.status == 'success' &&
        busMasterResp!.statusCode == 200) {}
  }
}
