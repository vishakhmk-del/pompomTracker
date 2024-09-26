
import 'dart:developer';
import 'package:pompomtracker/core/hook/hook.dart';


class ScreenStopList extends StatefulWidget {
  const ScreenStopList({super.key});

  @override
  State<ScreenStopList> createState() => _ScreenStopListState();
}

class _ScreenStopListState extends State<ScreenStopList> {

  List<String> columns = [];
  List<String?> cells = [];
  List<Listdet>? triplist = [];
 // List<String> tripnamelst = [];
  final _formkey = GlobalKey<FormState>();
  String? dropdownbusvalue;
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
                                          return DropdownMenuItem<String>(
                                            value: tripMap['tripId'] as String,
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

                                         context.read<ElevatedBtnProvider>().changeSelectedVal(false);

                                          setState(() {
                                            dropdownbusvalue = newvalue;
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
                                            final tripid = dropdownbusvalue;
                                            print(tripid);
                                            //fetchclstatement(context, value);
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
                          // Replace with your Collection Form widget
                        } else if (provider.selectedVal == true) {
                          //   WidgetsBinding.instance.addPostFrameCallback((_) {
                          //   _scrollToBottom(); // Call the function to scroll down
                          // });
                          return ScrollableWidget(child: buildStmntTbl());
                          // Replace with your Cash Form widget
                        }
                        return Container();
                        // Or some default widget
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
              child: DataTable(
                columns: getColumns(
                   columns = [
                            'Stop Name',
                            'Is Stage',
                            'Arriving ',
                          ]
                    ),
                rows: getRows(newList),
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
          cells: Utils.modelBuilder(cells, (index, cell) {
            
            final taskbold = index == 0;
            final val = cells[1];
            //print(val);
          final stage = val == "y" ? "yes" : "no";
            print(stage);
            //final remarkclr = index == 6;
            return DataCell(
              Center(
                child: Text('$cell',
                    style: taskbold
                        ? const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 88, 147, 250))
                        : const TextStyle(fontWeight: FontWeight.normal)),
              ),
              //onTap: () {}
            );
          }),
        );
      }).toList();
}