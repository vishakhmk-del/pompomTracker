import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pompomtracker/core/hook/hook.dart';

class BusRouteList extends StatefulWidget {
  const BusRouteList({super.key});

  @override
  State<BusRouteList> createState() => _BusRouteListState();
}

class _BusRouteListState extends State<BusRouteList> {
  List<String> columns = [];
  List<String?> cells = [];
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await BusRouteListFunctions.instance.getBusRouteList();
    });
  }

  Future<bool?> popscreen(BuildContext context) async {
    Navigator.push(context, Approutes().homescreen);
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
              onPressed: () {
                Navigator.pushReplacement(context, Approutes().homescreen);
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text('Bus Route List'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ValueListenableBuilder(
              valueListenable:
                  BusRouteListFunctions.instance.getBusRouteListNotifier,
              builder:
                  (BuildContext context, List<Listdet> newList, Widget? _) {
                return DataTable(
                  columns: getColumns(columns = [
                    'S.No',
                    'Reg No',
                    'Route',
                    'Via',
                    'Action',
                  ]),
                  rows: getRows(newList),
                );
              }),
        ),
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
        task.routeName,
        task.via,
      ];
      return DataRow(cells: [
        //
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
                        builder: (context) => ScreenLinkBusRoute(
                            registrationNumber: task.registratioNo,
                            routeId: task.routeId,
                            flag: 1)),
                  );
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                )),
          ),
        ),
      ]);
    }).toList();
  }
}
