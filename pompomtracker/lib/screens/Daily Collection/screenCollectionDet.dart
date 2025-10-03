import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:pompomtracker/core/hook/hook.dart';

class ScreenCollectionDet extends StatefulWidget {
  const ScreenCollectionDet({super.key,required this.task});
  final Collection task;
  @override
  State<ScreenCollectionDet> createState() => _ScreenCollectionDetState();
}

class _ScreenCollectionDetState extends State<ScreenCollectionDet> {
   List<String> columns = [];
  List<String?> cells = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final crndt = DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd').format(crndt);
      print(formattedDate);
      final inputFormat = DateFormat('dd-MM-yyyy');
      final outputFormat = DateFormat('yyyy-MM-dd');
      final date = inputFormat.parse(widget.task.collectionDate!);
      final datecollect=outputFormat.format(date);
      await StatementFunctions.instance.getCollectionDet(widget.task.busId,datecollect,context);
    });
  }

  Future<bool?> popscreen(BuildContext context) async {
    StatementFunctions.instance.getCollectDetNotifier.value=null;
    // Navigator.pop(context);
    Navigator.pushReplacement(context, Approutes().dailycollectionScreen);

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
      child: Stack(
        children: [
          //BackgroundColorGradient(),
          Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              leading: IconButton(
                  onPressed: () {
                  StatementFunctions.instance.getCollectDetNotifier.value=null;
                    // Navigator.pop(context);
                    Navigator.pushReplacement(context, Approutes().dailycollectionScreen);


                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white)),
              title: const Text(
                'Collection Details',
                style: TextStyle(color: Colors.white),
              ),
             
            ),
            body: Column(
              children: [
                
                ValueListenableBuilder(
                  valueListenable: StatementFunctions.instance.getCollectDetNotifier,
                  builder: (BuildContext context, DataDetails? data, Widget? _) {
                    final collectionList = data?.trips ?? [];
                    final expnse = double.tryParse(data?.totalExpense??'0') ?? 0;
                    final grandtotal = double.tryParse(data?.grandTotal??'0') ?? 0;
                   final cashInHand = grandtotal-expnse;

                    if (collectionList.isEmpty) {
                      return FutureBuilder(
                                  future: Future.delayed(const Duration(seconds: 10)), // Add a delay of 5 seconds
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2.5,
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.3,
                                          ),
                                          child:
                                              const CircularProgressIndicator(
                                                  color: Color.fromARGB(
                                                      255, 204, 123, 2)),
                                        ),
                                      );
                                    } else {
                                      // After 5 seconds, show the No Data Found image
                                      return Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2.5,
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.7,
                                          ),
                                          child: Text(
                                            'No data found',
                                            style: TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                );
                    }

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Date
                          Container(
                            width:  MediaQuery.of(context).size.width,
                           color:  Color.fromARGB(255, 204, 123, 2),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Bus name & Reg No
                                  Text(
                                    '${widget.task.busName?.toUpperCase() ?? ''} - (${widget.task.registrationNo?.toUpperCase() ?? ''})',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 15,),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                       "Date: ${ widget.task.collectionDate ?? ''}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      Text(
                                       "Cash in Hand: ₹$cashInHand",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                ],
                              ),
                            ),
                          ),
                    
                          
                    
                          const SizedBox(height: 10),
                    
                          // Trip List
                          ...collectionList.asMap().entries.map((entry) {
                            final index = entry.key + 1;
                            final trip = entry.value;
                    
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Trip name + time
                                  Text(
                                    '$index. ${trip.tripName ?? ''}   ${trip.startTime ?? ''}-${trip.endTime ?? ''}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 14,color: Colors.black),
                                  ),
                                  const SizedBox(height: 4),
                                  // Row for Online/Offline
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('Online: ₹${trip.online ?? '0'}',style: const TextStyle(
                                        fontWeight: FontWeight.w500, fontSize: 14,color: Colors.black),),
                                      Text('Offline:₹${trip.offline ?? '0'}',style: const TextStyle(
                                        fontWeight: FontWeight.w500, fontSize: 14,color: Colors.black),),
                                    ],
                                  ),
                                  // Row for Refund/Total
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('Refund: ₹${trip.refund ?? '0'}',style: const TextStyle(
                                        fontWeight: FontWeight.w500, fontSize: 14,color: Colors.black),),
                                      Text('Total: ₹${trip.totalCollection ?? '0'}',style: const TextStyle(
                                        fontWeight: FontWeight.w500, fontSize: 14,color: Colors.black),),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    
                          const Divider(thickness: 1,color: Colors.black54,),
                    
                          // Totals
                          Text(
                            'Grand Total: ₹$grandtotal',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18,color: Colors.black),
                          ),
                          Text(
                            'Total Expense: ₹$expnse',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18,color: Colors.black),
                          ),
                          Text(
                            'Cash in Hand: ₹$cashInHand',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18,color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  },
                )

              ],
            ),
          ),
        ],
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      return DataColumn(
        label: Text(
          column,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white),
        ),
      );
    }).toList();
  }

  List<DataRow> getRows(List<Trip> newList) {
    return newList.asMap().entries.map((entry) {
      int index = entry.key + 1; // Serial number starts from 1
      Trip task = entry.value;
      cells = [
        task.tripName ?? '',
        task.travelDate??'',
        '${task.startTime??''}-${task.endTime??''}' ,
        task.online ?? '0',
        task.offline ?? '0',
        task.refund ?? '0',
        task.totalCollection??'0',
      ];
      return DataRow(cells: [
        //
        DataCell(
          Center(
            child: Text(
              '$index', // Display the serial number
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
        ...Utils.modelBuilder(cells, (index, cell) {
          final taskbold = index == 0;
          return DataCell(
            Center(
              child: Text('$cell',
                  style: taskbold
                      ? const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)
                      : const TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.black)),
            ),
          );
        }),
      ]);
    }).toList();
  }
}