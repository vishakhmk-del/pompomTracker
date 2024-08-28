import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/model/getRoute/ger_route_resp/ger_route_resp.dart';
import 'package:pompomtracker/model/getRoute/get_route_req/get_route_req.dart';

class ScreenTrip extends StatefulWidget {
  const ScreenTrip({super.key});

  @override
  State<ScreenTrip> createState() => _ScreenTriptState();
}

class _ScreenTriptState extends State<ScreenTrip> {
  final _scafoldkey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  List<String> registarionlst = [];
  List<String> routelist = [];
  String? selectedBusList;
  String? selectedRouteList;
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchBusregistraionList();
    fetchRouteList();
  }

  void fetchBusregistraionList() async {
    final value = await SharedPrefManager.instance.getSharedData();
    RegistrationReq registrationReq = RegistrationReq(userId: value!.userId);
    final getRegList = await Busdata().getBusRegistartionList(registrationReq);
    if (getRegList == null) {
    } else {
      final resultAsJson = jsonDecode(getRegList.toString());
      final registrationList =
          RegistrationResp.fromJson(resultAsJson as Map<String, dynamic>);
      //this is the registraion response model (main model)

      setState(() {
        registarionlst = registrationList.busList!
            .map((bus) => bus.registrationNo ?? "")
            .toList(); //calling registarion list  from main model
      });
    }
  }

  void fetchRouteList() async {
    final value = await SharedPrefManager.instance.getSharedData();
    GetRouteReq routeReq = GetRouteReq(userId: value!.userId, userType: '3');
    final getRouteList = await Busdata().getRouteList(routeReq);
    final resultAsJson = jsonDecode(getRouteList.toString());
    final routeList = GerRouteResp.fromJson(resultAsJson as Map<String,
        dynamic>); //this is the registraion response model (main model)
    setState(() {
      routelist = routeList.routeList!.map((bus) {
        String routeDisplay = bus.routeName ?? bus.routeId ?? "";
        String viaDisplay =
            bus.via != null && bus.via!.isNotEmpty ? "via - ${bus.via}" : "";
        return routeDisplay + viaDisplay;
      }).toList(); //calling registarion list  from main model
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
            "Trip Master",
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          )),
      body: Center(
        child: SingleChildScrollView(
          // scrollDirection: Axis.horizontal,
          child: Container(
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).colorScheme.onSecondary),
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
                                color: Theme.of(context).colorScheme.onPrimary),
                            icon: Theme(
                              data: MyTheme.appIconTheme,
                              child: const Icon(
                                Icons.arrow_drop_down,
                              ),
                            ),
                            decoration: InputDecoration(
                              labelText: 'Select Bus',
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
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButtonFormField(
                            items: routelist.map((valueItem) {
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
                                selectedRouteList = newValue;
                              });
                            },
                            value: selectedRouteList,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                            icon: Theme(
                              data: MyTheme.appIconTheme,
                              child: const Icon(
                                Icons.arrow_drop_down,
                              ),
                            ),
                            decoration: InputDecoration(
                              labelText: 'Select Route',
                              labelStyle:
                                  Theme.of(context).textTheme.labelSmall,
                            ),
                            dropdownColor:
                                Theme.of(context).colorScheme.tertiary,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Select Route';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: _fromController,
                            style: Theme.of(context).textTheme.bodySmall,
                            decoration: InputDecoration(
                                labelText: 'From Station',
                                labelStyle:
                                    Theme.of(context).textTheme.bodySmall),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter From Station';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: _toController,
                            style: Theme.of(context).textTheme.bodySmall,
                            decoration: InputDecoration(
                                labelText: 'To Station',
                                labelStyle:
                                    Theme.of(context).textTheme.bodySmall),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter To Station';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        // showTimePicker(context: _scafoldkey.currentContext, initialTime:TimeOfDay(hour: 7, minute: 15)),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
