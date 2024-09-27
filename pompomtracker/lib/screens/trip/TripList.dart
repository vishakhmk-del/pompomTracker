import 'package:flutter/material.dart';
import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/function/trip/TripListFun.dart';

class ScreenTripList extends StatefulWidget {
  const ScreenTripList({super.key});

  @override
  State<ScreenTripList> createState() => _ScreenTripListState();
}

class _ScreenTripListState extends State<ScreenTripList> {
  List<String> columns = [];
  List<String?> cells = [];
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await TripListFuntions.instance.getTripList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context, Approutes().homescreen);
          },
        ),
        title: Text(
          'Trip List',
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ValueListenableBuilder(
            valueListenable: TripListFuntions.instance.getTripListNotifier,
            builder: (BuildContext context, List<Listdet> newList, Widget? _) {
              return DataTable(
                columns: getColumns(columns = [
                  'S.No',
                  'Reg No',
                  'Trip',
                  'Start T',
                  'End T',
                  'Action',
                ]),
                rows: getRows(newList),
              );
            }),
      ),
    );
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

  List<DataRow> getRows(List<Listdet> newList) {
    return newList.asMap().entries.map((entry) {
      int index = entry.key + 1; // Serial number starts from 1
      Listdet task = entry.value;
      cells = [
        task.registratioNo,
        task.tripName,
        task.startTime,
        task.endTime,
      ];
      return DataRow(
        cells: [
          DataCell(
            Center(
              child: Text(
                '$index', // Display the serial number
                style: const TextStyle(fontWeight: FontWeight.bold),
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
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 88, 147, 250))
                        : const TextStyle(fontWeight: FontWeight.normal)),
              ),
            );
          }),
          DataCell(
            Center(
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScreenTrip(
                            trip_id: task.tripId,
                            regNo: task.registratioNo,
                            flag: 1),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.primary,
                  )),
            ),
          ),
        ],
      );
    }).toList();
  }
}
