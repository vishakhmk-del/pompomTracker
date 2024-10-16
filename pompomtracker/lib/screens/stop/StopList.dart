
import 'dart:developer';
import 'package:pompomtracker/core/hook/hook.dart';



class ScreenStopList extends StatefulWidget {
  const ScreenStopList({super.key});

  @override
  State<ScreenStopList> createState() => _ScreenStopListState();
}

class _ScreenStopListState extends State<ScreenStopList> {
  final _isStagecontroller = TextEditingController();

  List<String> columns = [];
  List<String?> cells = [];
  List<Listdet>? triplist = [];
  final _formkey = GlobalKey<FormState>();
  final _formkey1 = GlobalKey<FormState>();
  String? dropdownbusvalue;
  String? display;
  String? tripId;
  List<Map<String, Object>> tripnamelst = [];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {     
      context.read<ElevatedBtnProvider>().changeSelectedVal(false);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
     triplist=await StopFunctions.instance.tripNameList();
     setState(() {
        tripnamelst = triplist!.map((trip) {
          String routeDisplay = trip.tripName ?? "";
          
          return {
            'tripId': trip.tripId!, // routeId as int
            'display': routeDisplay // Display label
          };
          }).toList(); //calling registarion list  from main model
      });
      
    });
  }
  
  Future<bool?> popscreen(BuildContext context) async {
    selectedTaskNotifier.value = StatementType.collectionType;
    selectedModeNotifier.value = StatementType.both;
    Navigator.push(context, Approutes().collectionscreen);
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
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const Screenhome()),
                            (Route<dynamic> route) => false);
                      },
            
          ),
          title: Text(
            'Stop List',
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          ),
        ),
        body: ListView(
          children: [
                  Card(
                      margin: const EdgeInsets.all(10),
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.onSecondary),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        child:Form(
                          key: _formkey,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Theme(
                              data: MyTheme.googleFormTheme,
                              child: Column(children: [
                                Text(
                                  'Search For Stop Details',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 25, left: 5, right: 5),
                                      child: DropdownButtonFormField(
                                        //controller: _selectsearchtypedropdwn,
                                        dropdownColor: Theme.of(context).colorScheme.tertiary,
                                        icon: Icon(Icons.arrow_drop_down,
                                            color: Theme.of(context).colorScheme.onSecondary),
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSecondary,
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'Select Trip Name',
                                          labelStyle: Theme.of(context).textTheme.labelLarge,
                                        ),
                                        items: tripnamelst.map((tripMap) {
                                          String combinedValue = '${tripMap['tripId']}+${tripMap['display']}';
                                          return DropdownMenuItem<String>(
                                            value: combinedValue,
                                             child: Text(
                                               tripMap['display']
                                                   as String, // Display the route name and via
                                               overflow: TextOverflow.ellipsis,
                                               style: TextStyle(
                                                 color: Theme.of(context)
                                                     .colorScheme
                                                     .onSecondary,
                                                 ),
                                               ),);
                                        }).toList(),
                                        onChanged: (newvalue) {
                                          log('Bus :$newvalue');
                                          List<String> parts=newvalue!.split('+');
                                           tripId=parts[0];
                                           display=parts[1];
                                          //  print(tripId);
                                          //  print(display);
                                          //final value=tripMap['display'] as String;

                                         context.read<ElevatedBtnProvider>().changeSelectedVal(false);

                                          setState(() {
                                            dropdownbusvalue = newvalue;
                                            //context.read<ElevatedBtnProvider>().changeSelectedVal(true);
                                          });
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Select A Trip Name';
                                          } else {
                                            return null;
                                          }
                                        },
                                        value: dropdownbusvalue,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                  padding: const EdgeInsets.all(25.0),
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
                                          
                                         if (_formkey.currentState!.validate()) {
                                             context.read<ElevatedBtnProvider>().changeSelectedVal(true);
                                            
                                            StopFunctions.instance.stopDetFn(tripId);
                                          }
                                        },
                                        child: Text(
                                          'Show',
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],)),
                          ))
                      )),
                      Consumer<ElevatedBtnProvider>(
                      builder: (context, provider, child) {
                        if (provider.selectedVal == false) {
                          return Container();
                          
                        } else if (provider.selectedVal == true) {
                          
                          return ScrollableWidget(child: buildStmntTbl());
                          
                        }
                        return Container();
                        
                      },
                    ),
          ],)
          )
          );
  }
  Widget buildStmntTbl() {
    return ValueListenableBuilder(
        valueListenable: StopFunctions.instance.getStopDetNotifier,
        builder: (BuildContext context, List<Listdet> newList, Widget? _) {
          return Card(
                      margin: const EdgeInsets.all(10),
                      elevation: 3,
            child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).colorScheme.onSecondary),
                              borderRadius: BorderRadius.circular(12),
                            ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ScreenAddNewStop(tripName: display,tripId: tripId,),
                      ),
                    );
                      },
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Theme.of(context).colorScheme.primary,
                        size: 25,
                      )),
                       Text('Add New Stop',style: Theme.of(context).textTheme.titleMedium,),
                  ],),

                  DataTable(
                    columns: getColumns(
                       columns = [
                                'Stop Name',
                                'Is Stage',
                                'Arriving ',
                                'Action'
                              ]
                        ),
                    rows: getRows(newList),
                  ),
                ],
              ),
            ),
          );
        });
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      return DataColumn(
        label: Text(
          column,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }).toList();
  }

  List<DataRow> getRows(List<Listdet> newList) =>
      newList.map((Listdet task) {
        cells = [
                        task.stopName,
                        task.isStage,
                        task.arrivingTime,
                        
                      ];
                    

        return DataRow(
          cells: [
            ...Utils.modelBuilder(cells, (index, cell) {
            
            final taskbold = index == 0;
            final val = cells[1];
            //print(val);
            // bool stg=val==cells[1]?true:false;
          final stage = val == "y" ? "yes" : "no";
            print(stage);
            
            return DataCell(
              Center(
                child: Text(index==1?stage:'$cell',
                    style: taskbold
                        ? const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 88, 147, 250))
                        : const TextStyle(fontWeight: FontWeight.normal)),
              ),
              // onTap: (){
              //   switch(index){
              //     case 1:remarkbox(context,task);
              //   }
              // }
            );
          }),
           DataCell(
            Center(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                       
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScreenStopNameChange(stopdet: task,tripName:display,),
                          ),
                        );
                        
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                      IconButton(
                      onPressed: () {
                        deleteStop(context,task.tripId,task.stopId);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                ],
              ),
            ),
          ),
          ]
        );
      }).toList();

  

deleteStop(BuildContext context,String? tripid,String? stopid) async => showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
              title: Container(
                 height: MediaQuery.of(context).size.height/6,
                 width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                    color: Theme.of(context).colorScheme.onSecondary),
                    borderRadius: BorderRadius.circular(12),
                  ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:20),
                      child: Text("Do you want to delete?",
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                          Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                                        child: Container(
                                          height: 30,
                                          width: 100,
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
                                              Navigator.pop(context, false);
                                            },
                                              child: Text(
                                                'No',
                                                style: Theme.of(context).textTheme.titleMedium,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                  Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                                        child: Container(
                                          height: 30,
                                          width: 100,
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
                                                   StopFunctions.instance.deleteStop(tripid, stopid);                                        
                                                   Navigator.pop(context, false);
                                              },
                                              child: Text(
                                                'yes',
                                                style: Theme.of(context).textTheme.titleMedium,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                        ],)
                  ],
                ),
              ),
              
            ),
      ));

remarkbox(BuildContext context,Listdet task)async=>
      
      showDialog<bool>(context: context,
       builder: (context)=>AlertDialog(
        title:  Container(
          decoration: BoxDecoration(
            border: Border.all(
            color: Theme.of(context).colorScheme.onSecondary),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Form(
            key: _formkey1,
            child: Center(
              child:Theme(
                data: MyTheme.googleFormTheme,
                child: Column(
                  children: [
                  const  SizedBox(height: 10,),
                  Text("Change Stage Status",style: Theme.of(context).textTheme.titleLarge,),
                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 10),
                                      child: TextFormField(
                                          controller: _isStagecontroller,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ),
                                          decoration: InputDecoration(
                                            labelText: 'Is Stage',
                                            hintText: 'Enter y/n',
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Enter valid letter";
                                            } else if (value.contains('.') ||
                                                value.contains("-") ||
                                                value.contains(" ") ||
                                                value.contains(",")) {
                                              return "Enter valid letter";
                                            }
                                            return null;
                                          }),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                                              
                                             if (_formkey1.currentState!.validate()) {
                                                 context.read<ElevatedBtnProvider>().changeSelectedVal(true);
                                                final tripid = dropdownbusvalue;
                                                print(tripid);
                                                //fetchclstatement(context, value);
                                                //StopFunctions.instance.stopDetFn(tripid);
                                              }
                                            },
                                            child: Text(
                                              'Update',
                                              style: Theme.of(context).textTheme.titleMedium,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  
                ],),
              )
            ),
          ),
        ),
       ));
}