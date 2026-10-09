import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:pompomtracker/core/hook/hook.dart';

class ScreenCollectionDet extends StatefulWidget {
  const ScreenCollectionDet({super.key, required this.task});
  final Collection task;
  @override
  State<ScreenCollectionDet> createState() => _ScreenCollectionDetState();
}

class _ScreenCollectionDetState extends State<ScreenCollectionDet> {
  final Set<int> _expandedTrips = {};
  List<String> columns = [];
  List<String?> cells = [];
  String? cDate;

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
      final datecollect = outputFormat.format(date);
      setState(() {
        cDate = widget.task.collectionDate;
      });
      await StatementFunctions.instance
          .getCollectionDet(widget.task.busId, datecollect, context);
    });
  }

  Future<bool?> popscreen(BuildContext context) async {
    StatementFunctions.instance.getCollectDetNotifier.value = null;
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
                    StatementFunctions.instance.getCollectDetNotifier.value =
                        null;
                    // Navigator.pop(context);
                    Navigator.pushReplacement(
                        context, Approutes().dailycollectionScreen);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white)),
              title: const Text(
                'Collection Details',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: ListView(
              children: [
                ValueListenableBuilder(
                  valueListenable:
                      StatementFunctions.instance.getCollectDetNotifier,
                  builder:
                      (BuildContext context, DataDetails? data, Widget? _) {
                    final collectionList = data?.trips ?? [];
                    final expnse =
                        double.tryParse(data?.totalExpense ?? '0') ?? 0;
                    final grandtotal =
                        double.tryParse(data?.grandTotal ?? '0') ?? 0;
                    final cashInHand = grandtotal - expnse;

                    if (collectionList.isEmpty) {
                      return FutureBuilder(
                        future: Future.delayed(const Duration(
                            seconds: 10)), // Add a delay of 5 seconds
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height / 2.5,
                                  horizontal:
                                      MediaQuery.of(context).size.width / 2.3,
                                ),
                                child: const CircularProgressIndicator(
                                    color: Color.fromARGB(255, 204, 123, 2)),
                              ),
                            );
                          } else {
                            // After 5 seconds, show the No Data Found image
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height / 2.5,
                                  horizontal:
                                      MediaQuery.of(context).size.width / 2.7,
                                ),
                                child: Text(
                                  'No data found',
                                  style: TextStyle(color: Colors.black),
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
                            width: MediaQuery.of(context).size.width,
                            color: Color.fromARGB(255, 204, 123, 2),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Bus name & Reg No
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${widget.task.busName?.toUpperCase() ?? ''} - (${widget.task.registrationNo?.toUpperCase() ?? ''})',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.calendar_month,
                                            size: 30, color: Colors.white),
                                        onPressed: () async {
                                          final DateTime? pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime.now(),
                                          );

                                          if (pickedDate != null) {
                                            final formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(pickedDate);
                                            setState(() {
                                              cDate = DateFormat('dd-MM-yyyy')
                                                  .format(pickedDate);
                                            });

                                            if (!context.mounted) return;
                                            await StatementFunctions.instance
                                                .getCollectionDet(
                                                    widget.task.busId,
                                                    formattedDate,
                                                    context);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Cash in Hand: ₹$cashInHand",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Date: ${cDate ?? ''}",
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
                          // ...collectionList.asMap().entries.map((entry) {
                          //   final index = entry.key + 1;
                          //   final trip = entry.value;

                          //   return Padding(
                          //     padding: const EdgeInsets.all(10.0),
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         // Trip name + time
                          //         Text(
                          //           '$index. ${trip.tripName ?? ''}   ${trip.startTime ?? ''}-${trip.endTime ?? ''}',
                          //           style: const TextStyle(
                          //               fontWeight: FontWeight.bold, fontSize: 14,color: Colors.black),
                          //         ),
                          //         const SizedBox(height: 4),
                          //         // Row for Online/Offline
                          //         Row(
                          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //           children: [
                          //             Text('Online: ₹${trip.online ?? '0'}',style: const TextStyle(
                          //               fontWeight: FontWeight.w500, fontSize: 14,color: Colors.black),),
                          //             Text('Offline:₹${trip.offline ?? '0'}',style: const TextStyle(
                          //               fontWeight: FontWeight.w500, fontSize: 14,color: Colors.black),),
                          //           ],
                          //         ),
                          //         // Row for Refund/Total
                          //         Row(
                          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //           children: [
                          //             Text('Refund: ₹${trip.refund ?? '0'}',style: const TextStyle(
                          //               fontWeight: FontWeight.w500, fontSize: 14,color: Colors.black),),
                          //             Text('Total: ₹${trip.totalCollection ?? '0'}',style: const TextStyle(
                          //               fontWeight: FontWeight.w500, fontSize: 14,color: Colors.black),),
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //   );
                          // }),
                          ...collectionList.asMap().entries.map((entry) {
                            final index = entry.key + 1;
                            final trip = entry.value;
                            final isExpanded = _expandedTrips.contains(index);

                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Trip title (tappable)
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     setState(() {
                                  //       if (isExpanded) {
                                  //         _expandedTrips.remove(index);
                                  //       } else {
                                  //         _expandedTrips.add(index);
                                  //       }
                                  //     });
                                  //   },
                                  //   child: Text(
                                  //     '$index. ${trip.tripName ?? ''}   ${trip.startTime ?? ''}-${trip.endTime ?? ''}',
                                  //     style: const TextStyle(
                                  //       fontWeight: FontWeight.bold,
                                  //       fontSize: 14,
                                  //       color: Colors.black,
                                  //     ),
                                  //   ),
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (isExpanded) {
                                          _expandedTrips.remove(index);
                                        } else {
                                          _expandedTrips.add(index);
                                        }
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '$index. ${trip.tripName ?? ''}   ${trip.startTime ?? ''}-${trip.endTime ?? ''}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        AnimatedRotation(
                                          turns: isExpanded
                                              ? 0.5
                                              : 0.0, // Rotates 180° when expanded
                                          duration:
                                              const Duration(milliseconds: 200),
                                          child: const Icon(
                                            Icons.expand_more,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 4),
                                  if (isExpanded) ...[
                                    const SizedBox(height: 8),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Table(
                                          columnWidths: const {
                                            0: IntrinsicColumnWidth(),
                                            1: FlexColumnWidth(1.2),
                                            2: IntrinsicColumnWidth(),
                                            3: FlexColumnWidth(1.2),
                                          },
                                          defaultVerticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          children: [
                                            TableRow(
                                              children: [
                                                _buildTableCell(
                                                    'Adults (${trip.adultCount ?? '0'})'),
                                                _buildTableCell(
                                                    '₹${trip.adultTotelAmt ?? '0'}',
                                                    isValue: true),
                                                _buildTableCell(
                                                    'Kids (${trip.kidsCount ?? '0'})'),
                                                _buildTableCell(
                                                    '₹${trip.kidsTotelAmt ?? '0'}',
                                                    isValue: true),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                _buildTableCell(
                                                    'Student (${trip.studentCount ?? '0'})'),
                                                _buildTableCell(
                                                    '₹${trip.studentTotelAmt ?? '0'}',
                                                    isValue: true),
                                                _buildTableCell(
                                                    'Handicapped (${trip.handiCount ?? '0'})'),
                                                _buildTableCell(
                                                    '₹${trip.handiTotelAmt ?? '0'}',
                                                    isValue: true),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                _buildTableCell(
                                                    'Luggage (${trip.luggageCount ?? '0'})'),
                                                _buildTableCell(
                                                    '₹${trip.luggageTotelAmt ?? '0'}',
                                                    isValue: true),
                                                _buildTableCell(
                                                    'Concession (${trip.concessionCount ?? '0'})'),
                                                _buildTableCell(
                                                    '₹${trip.concession ?? '0'}',
                                                    isValue: true),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    child: Center(
                                      child: Table(
                                        columnWidths: const {
                                          0: IntrinsicColumnWidth(),
                                          1: FlexColumnWidth(1.2),
                                          2: IntrinsicColumnWidth(),
                                          3: FlexColumnWidth(1.2),
                                        },
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        children: [
                                          TableRow(
                                            children: [
                                              _buildTableCell(
                                                  'Online (${trip.onlineCount ?? '0'})'),
                                              _buildTableCell(
                                                  '₹${trip.online ?? '0'}',
                                                  isValue: true),
                                              _buildTableCell(
                                                  'Offline (${trip.offlineCount ?? '0'})'),
                                              _buildTableCell(
                                                  '₹${trip.offline ?? '0'}',
                                                  isValue: true),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              _buildTableCell(
                                                  'Refund (${trip.refundCount ?? '0'})'),
                                              _buildTableCell(
                                                  '₹${trip.refund ?? '0'}',
                                                  isValue: true),
                                              _buildTableCell('Total'),
                                              _buildTableCell(
                                                  '₹${trip.totalCollection ?? '0'}',
                                                  isValue: true),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // if (isExpanded) ...[
                                  //   const SizedBox(height: 8),
                                  //   Container(
                                  //     width: double.infinity,
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.grey.shade200,
                                  //       borderRadius: BorderRadius.circular(5),
                                  //     ),
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: Column(
                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                  //       children: [
                                  //         Row(
                                  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //           children: [
                                  //             Text('Adults(${trip.adultCount ?? '0'}): ₹${trip.adultTotelAmt ?? '0'}',
                                  //                 style: const TextStyle(
                                  //                     fontWeight: FontWeight.w500,
                                  //                     fontSize: 14,
                                  //                     color: Colors.black)),
                                  //             Text('Kids(${trip.kidsCount ?? '0'}): ₹${trip.kidsTotelAmt ?? '0'}',
                                  //                 style: const TextStyle(
                                  //                     fontWeight: FontWeight.w500,
                                  //                     fontSize: 14,
                                  //                     color: Colors.black)),
                                  //           ],
                                  //         ),
                                  //         Row(
                                  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //           children: [
                                  //             Text('Student(${trip.studentCount ?? '0'}): ₹${trip.studentTotelAmt ?? '0'}',
                                  //                 style: const TextStyle(
                                  //                     fontWeight: FontWeight.w500,
                                  //                     fontSize: 14,
                                  //                     color: Colors.black)),
                                  //             Text('Handicapped(${trip.handiCount ?? '0'}): ₹${trip.handiTotelAmt ?? '0'}',
                                  //                 style: const TextStyle(
                                  //                     fontWeight: FontWeight.w500,
                                  //                     fontSize: 14,
                                  //                     color: Colors.black)),
                                  //           ],
                                  //         ),
                                  //         Row(
                                  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //           children: [
                                  //             Text('Luggage(${trip.luggageCount ?? '0'}): ₹${trip.luggageTotelAmt ?? '0'}',
                                  //                 style: const TextStyle(
                                  //                     fontWeight: FontWeight.w500,
                                  //                     fontSize: 14,
                                  //                     color: Colors.black)),
                                  //             Text('Concession(${trip.concessionCount ?? '0'}): ₹${trip.concession ?? '0'}',
                                  //                 style: const TextStyle(
                                  //                     fontWeight: FontWeight.w500,
                                  //                     fontSize: 14,
                                  //                     color: Colors.black)),
                                  //           ],
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ],
                                  // Basic info (always visible)

                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //   children: [
                                  //     Text('Online(${trip.onlineCount ?? '0'}): ₹${trip.online ?? '0'}',
                                  //         style: const TextStyle(
                                  //             fontWeight: FontWeight.w500,
                                  //             fontSize: 14,
                                  //             color: Colors.black)),
                                  //     Text('Offline(${trip.offlineCount ?? '0'}): ₹${trip.offline ?? '0'}',
                                  //         style: const TextStyle(
                                  //             fontWeight: FontWeight.w500,
                                  //             fontSize: 14,
                                  //             color: Colors.black)),
                                  //   ],
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //   children: [
                                  //     Text('Refund(${trip.refundCount ?? '0'}): ₹${trip.refund ?? '0'}',
                                  //         style: const TextStyle(
                                  //             fontWeight: FontWeight.w500,
                                  //             fontSize: 14,
                                  //             color: Colors.black)),
                                  //     Text('Total: ₹${trip.totalCollection ?? '0'}',
                                  //         style: const TextStyle(
                                  //             fontWeight: FontWeight.w500,
                                  //             fontSize: 14,
                                  //             color: Colors.black)),
                                  //   ],
                                  // ),

                                  // const Divider(thickness: 0.8, color: Colors.black12),
                                ],
                              ),
                            );
                          }),
                          const Divider(
                            thickness: 1,
                            color: Colors.black54,
                          ),

                          Center(
                            child: Table(
                              columnWidths: const {
                                0: IntrinsicColumnWidth(), // Label column (auto width)
                                1: FixedColumnWidth(40), // Value column
                                2: IntrinsicColumnWidth(), // Next label
                                3: FixedColumnWidth(40),
                              },
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              children: [
                                TableRow(
                                  children: [
                                    _buildTableCell('Grand Total',
                                        isTotal: true),
                                    _buildTableCell(':', isTotal: true),
                                    _buildTableCell('₹$grandtotal',
                                        isTotal: true),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    _buildTableCell('Total Expense',
                                        isTotal: true),
                                    _buildTableCell(':', isTotal: true),
                                    _buildTableCell('₹$expnse', isTotal: true),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    _buildTableCell('Cash in Hand',
                                        isTotal: true),
                                    _buildTableCell(':', isTotal: true),
                                    _buildTableCell('₹$cashInHand',
                                        isTotal: true),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Totals
                          // Text(
                          //   'Grand Total: ₹$grandtotal',
                          //   style: const TextStyle(
                          //       fontWeight: FontWeight.bold, fontSize: 18,color: Colors.black),
                          // ),
                          // Text(
                          //   'Total Expense: ₹$expnse',
                          //   style: const TextStyle(
                          //       fontWeight: FontWeight.bold, fontSize: 18,color: Colors.black),
                          // ),
                          // Text(
                          //   'Cash in Hand: ₹$cashInHand',
                          //   style: const TextStyle(
                          //       fontWeight: FontWeight.bold, fontSize: 18,color: Colors.black),
                          // ),
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
        task.travelDate ?? '',
        '${task.startTime ?? ''}-${task.endTime ?? ''}',
        task.online ?? '0',
        task.offline ?? '0',
        task.refund ?? '0',
        task.totalCollection ?? '0',
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

  Widget _buildTableCell(
    String text, {
    bool isValue = false,
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Text(
        text,
        textAlign: isValue ? TextAlign.right : TextAlign.left,
        style: TextStyle(
          fontWeight: isTotal
              ? FontWeight.bold
              : (isValue ? FontWeight.w600 : FontWeight.w500),
          fontSize: isTotal ? 18 : 14,
          color: Colors.black,
        ),
      ),
    );
  }
}
