import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/screens/Daily%20Collection/screenCollectionDet.dart';

class ScreenDailyCollection extends StatefulWidget {
  const ScreenDailyCollection({super.key});

  @override
  State<ScreenDailyCollection> createState() => _ScreenDailyCollectionState();
}

class _ScreenDailyCollectionState extends State<ScreenDailyCollection> {
  List<String> columns = [];
  List<String?> cells = [];
  String cDate='';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final crndt = DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd').format(crndt);
      setState(() {
      cDate = DateFormat('dd-MM-yyyy').format(crndt);
        
      });

      print(formattedDate);
      await StatementFunctions.instance.getDayCollection(formattedDate, context);
    });
  }

  Future<bool?> popscreen(BuildContext context) async {
    StatementFunctions.instance.getDayCollectionNotifier.value=null;

    Navigator.pushReplacement(context, Approutes().mainScreen);
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
          // BackgroundColorGradient(),
          Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              leading: IconButton(
                  onPressed: () {
                   StatementFunctions.instance.getDayCollectionNotifier.value=null;

                    Navigator.pushReplacement(context, Approutes().mainScreen);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white)),
              title: const Text(
                'Day Collection',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.calendar_month, color: Colors.white),
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );

                    if (pickedDate != null) {
                      final formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            cDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                          });
                           
                      if (!context.mounted) return;
                      await StatementFunctions.instance
                          .getDayCollection(formattedDate, context);
                    }
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ScrollableWidget(
                    child: ValueListenableBuilder(
                        valueListenable: StatementFunctions
                            .instance.getDayCollectionNotifier,
                        builder: (BuildContext context, DataCollection? data,Widget? _) {
                          final collectionList = data?.collection ?? [];
                          // final grandTotal = double.tryParse(data?.grandTotal??'0') ?? 0;
                          // final grandExpense = double.tryParse(data?.grandExpense??'0') ?? 0;
                          // final cash=grandTotal-grandExpense;

                          final grandTotal = parseDouble(data?.grandTotal);
                          final grandExpense = parseDouble(data?.grandExpense);
                          final cash = grandTotal - grandExpense;
                         // final cdate = data?.collection?.first.collectionDate??'';


                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (collectionList.isNotEmpty) ...[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Date: $cDate',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black),
                                  ),
                                  child: DataTable(
                                    showCheckboxColumn: false, 
                                    dataRowMaxHeight: 35,
                                    dataRowMinHeight: 35,
                                    headingRowHeight: 35,
                                    columnSpacing: 10,
                                    headingRowColor: WidgetStateProperty.all(
                                        Color.fromARGB(255, 204, 123, 2)),
                                    columns: getColumns(columns = [
                                      'S.No',
                                      'Reg No',
                                      'Bus Name',
                                      'Amount',
                                      //'Date'
                                    ]),
                                    rows: getRows(collectionList),
                                  ),
                                ),

                                // Show Grand Total
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Cash in hand: ₹$cash',
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
double parseDouble(dynamic value) {
  if (value == null) return 0;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString().trim().replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
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

  List<DataRow> getRows(List<Collection> newList) {
    return newList.asMap().entries.map((entry) {
      int index = entry.key + 1; // Serial number starts from 1
      Collection task = entry.value;
      final totAmnt=double.tryParse(task.totalAmount??'0') ?? 0;
      final expns= double.tryParse(task.totalExpense??'0') ?? 0;
      final cashinhand=totAmnt - expns;
      cells = [
        task.registrationNo ?? '',
        task.busName ?? '',
        cashinhand.toString(),
       // task.collectionDate ?? '',
      ];
      return DataRow(
        onSelectChanged: (_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScreenCollectionDet(task: task,),
          ),
        );
      },
        cells: [
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
