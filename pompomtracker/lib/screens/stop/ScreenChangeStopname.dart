import 'package:intl/intl.dart';
import 'package:pompomtracker/core/hook/hook.dart';

class ScreenStopNameChange extends StatefulWidget {
  const ScreenStopNameChange({super.key,required this.tripName,required this.stopdet});
  final String? tripName;
  final Listdet stopdet;
  @override
  State<ScreenStopNameChange> createState() => _ScreenStopNameChangeState();
}

class _ScreenStopNameChangeState extends State<ScreenStopNameChange> {
  final _scafoldkey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _tripNameController = TextEditingController();
  final _stopNameController = TextEditingController();
  final _newstopNameController = TextEditingController();
  final _kilometerController = TextEditingController();
  final _arrivingController = TextEditingController();
   String? stopId;
   String? tripID;

  int? isstage;
  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 15);
  bool isChecked = true;
  List<Map<String, Object>> routelist = [];
  String? selectedRouteList;
  int? selectedRouteId;
  List<RouteList>? routeDetailslist = [];

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final DateFormat timeFormat = DateFormat('HH:mm');
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        final now = DateTime.now();
        final DateTime formattedTime = DateTime(
          now.year,
          now.month,
          now.day,
          newTime.hour,
          newTime.minute,
        );
        controller.text = timeFormat.format(formattedTime);
        
      });
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _tripNameController.text=widget.tripName??"";
        _stopNameController.text=widget.stopdet.stopName??"";
        _kilometerController.text=widget.stopdet.km??"";
        _arrivingController.text=widget.stopdet.arrivingTime??"";
        tripID=widget.stopdet.tripId;
        stopId=widget.stopdet.stopId;
        //print(_tripNameController);
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
              onPressed: () {
                Navigator.pushReplacement(
                    _scafoldkey.currentContext!, Approutes().stopListScreen);
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(
            'Change Stop Name',
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height*.83,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onSecondary),
                  borderRadius: BorderRadius.circular(12)),
              child: Form(
                key: _formKey,
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
                      
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                            child: TextFormField(
                              readOnly: true,
                              controller: _tripNameController,
                              style: Theme.of(context).textTheme.bodySmall,
                              decoration: InputDecoration(
                                  labelText: 'Route Name',
                                  labelStyle:
                                      Theme.of(context).textTheme.bodySmall),
                              
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                            child: TextFormField(
                              readOnly: true,
                              controller: _stopNameController,
                              style: Theme.of(context).textTheme.bodySmall,
                              decoration: InputDecoration(
                                  labelText: 'Stop Name',
                                  labelStyle:
                                      Theme.of(context).textTheme.bodySmall),
                              
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                            child: TextFormField(
                              controller: _newstopNameController,
                              style: Theme.of(context).textTheme.bodySmall,
                              decoration: InputDecoration(
                                  labelText: 'New Stop Name',
                                  labelStyle:
                                      Theme.of(context).textTheme.bodySmall),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter New Stop Name';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .5,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                            child: TextFormField(
                              controller: _kilometerController,
                              style: Theme.of(context).textTheme.bodySmall,
                              decoration: InputDecoration(
                                labelText: 'Kilo Meter',
                                hintText: 'KM',
                                hintStyle:  Theme.of(context).textTheme.bodySmall,
                                labelStyle:
                                    Theme.of(context).textTheme.bodySmall,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Kilo Meter';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        
                        SizedBox(
                          width: MediaQuery.of(context).size.width ,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                            child: TextFormField(
                              controller: _arrivingController,
                              style: Theme.of(context).textTheme.bodySmall,
                              decoration: InputDecoration(
                                  labelText: 'Arriving Time',
                                  labelStyle: Theme.of(context).textTheme.bodySmall,
                                  suffixIcon: Theme(
                                      data: Theme.of(context),
                                      child:  Icon(Icons.timer,
                                      color: Theme.of(context).colorScheme.primary,))),
                              onTap: () =>
                                  _selectTime(context, _arrivingController),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Value';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),

                        Padding(
                                  padding: const EdgeInsets.only(top:50.0,bottom: 20),
                                  child: Container(
                                    height: 45,
                                    width: 200,
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
                                          
                                         if (_formKey.currentState!.validate()) {
                                             //context.read<ElevatedBtnProvider>().changeSelectedVal(true);
                                            stopNameChangeFun(context);
                                          }
                                        },
                                        child: Text(
                                          'UPDATE',
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        //const SizedBox(height: 10),
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
                ),
              ),
            ),
          ),
        ));
  }

  Future stopNameChangeFun(BuildContext ctx) async {
    final loadingProvider = ctx.read<LoadingProvider>();
    //False to true
    loadingProvider.reset();
    loadingProvider.toggleLoading();
    
    final stopName = _newstopNameController.text;
    final oldName=_stopNameController.text;
    final kiloMeter = _kilometerController.text;
    final arriving = _arrivingController.text;

    final stopMasReq = MasterListReq(
      arrivingTime: arriving,
      stopId: stopId,
      stopName: stopName,
      stopNameOld: oldName,
      km:kiloMeter,
        tripId: tripID,        
        );
   
    final stopMasterResp = await Busdata().stopNameChang(stopMasReq);
    final reultAsJson = jsonDecode(stopMasterResp.toString());
    final resValue =
        StopMasterResp.fromJson(reultAsJson as Map<String, dynamic>);
    //True to false
    loadingProvider.toggleLoading();

    if (resValue.status == 'success') {
      Fluttertoast.showToast(
          msg: "Stop name changed successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
           Navigator.pushReplacement(
                    _scafoldkey.currentContext!, Approutes().stopListScreen);
              

    } else if (resValue.status == 'Failed') {
      showerror(_scafoldkey.currentContext, 2);
    } else {
      showerror(_scafoldkey.currentContext, 3);
    }
  }

  showerror(BuildContext? buildContext, stat) {
    if (stat == 2) {
      Fluttertoast.showToast(
          msg: "Stop name  not changed",
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
