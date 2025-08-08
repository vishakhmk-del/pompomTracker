import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pompomtracker/function/statementfns/statementFunctions.dart';
import 'package:pompomtracker/model/daycollection/collection_det/data.dart';
import 'package:pompomtracker/model/daycollection/collection_det/trip.dart';
import 'package:pompomtracker/model/daycollection/daycollectionresp/collection.dart';
import 'package:pompomtracker/widgets/scrollablewidget/scrollableWidget.dart';
import 'package:pompomtracker/widgets/statementTable_Utils/stmnt_tble_Utils.dart';

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
    // Navigator.push(context, Approutes().dailycollectionScreen);
    Navigator.pop(context);
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

                    // Navigator.pushReplacement(context, Approutes().dailycollectionScreen);
                    Navigator.pop(context);

                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white)),
              title: const Text(
                'Collection Details',
                style: TextStyle(color: Colors.white),
              ),
             
            ),
            body: Column(
              children: [
                Expanded(
                  child: ScrollableWidget(
                    child: ValueListenableBuilder(
                        valueListenable: StatementFunctions.instance.getCollectDetNotifier,
                        builder: (BuildContext context, DataDetails? data,
                            Widget? _) {
                          final collectionList = data?.trips ?? [];
                          final expnse = data?.totalExpense ?? 0;
                          final grandtotal = data?.grandTotal ?? 0;


                          return Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (collectionList.isNotEmpty) ...[
                                // Show Grand Total
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                  '${widget.task.busName?.toUpperCase()??''}-(${widget.task.registrationNo?.toUpperCase()??''})',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                // DataTable for Collection List
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black),
                                  ),
                                  child: DataTable(
                                    dataRowMaxHeight: 35,
                                    dataRowMinHeight: 35,
                                    headingRowHeight: 35,
                                    columnSpacing: 10,
                                    headingRowColor: WidgetStateProperty.all(
                                        Color.fromARGB(255, 204, 123, 2)),
                                    columns: getColumns(columns = [
                                      'S.No',
                                      'Trip Name',
                                      'Date',
                                      'Time',
                                      'Online',
                                      'Offline',
                                      'refund',
                                      'Total',
                                    ]),
                                    rows: getRows(collectionList),
                                  ),
                                ),

                                
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Total Expense: ₹$expnse',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Grand Total: ₹$grandtotal',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ] else ...[
                                FutureBuilder(
                                  future: Future.delayed(const Duration(
                                      seconds: 10)), // Add a delay of 5 seconds
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
                                ),
                              ]
                            ],
                          );
                        }),
                  ),
                ),
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