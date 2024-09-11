import 'package:pompomtracker/core/hook/hook.dart';

class ScreenBusList extends StatefulWidget {
  const ScreenBusList({super.key});

  @override
  State<ScreenBusList> createState() => _ScreenBusListState();
}

class _ScreenBusListState extends State<ScreenBusList> {
  List<String> columns = [];
  List<String?> cells = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await BusListFunctions.instance.getBusDetails();
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
          'Bus List',
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ValueListenableBuilder(
              valueListenable: BusListFunctions.instance.getBusListNotifier,
              builder:
                  (BuildContext context, List<BusList> newList, Widget? _) {
                return DataTable(
                  columns: getColumns(columns = [
                    'S.No',
                    'Reg No',
                    'Permit No',
                    'Valid To',
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

  List<DataRow> getRows(List<BusList> newList) {
    return newList.asMap().entries.map((entry) {
      int index = entry.key + 1; // Serial number starts from 1
      BusList task = entry.value;
      cells = [
        task.registrationNo,
        task.permitNo,
        task.validTo,
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
                        builder: (context) =>
                            ScreenBusMater(regNo: task.registrationNo, flag: 1),
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
