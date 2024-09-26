import 'package:pompomtracker/core/hook/hook.dart';


class ScreenConductorList extends StatefulWidget {
  const ScreenConductorList({super.key});

  @override
  State<ScreenConductorList> createState() => _ScreenConductorListState();
}

class _ScreenConductorListState extends State<ScreenConductorList> {
  List<String> columns = [];
  List<String?> cells = [];
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ConductorListFunctions.instance.getConductorList();
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
          'Conductor List',
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ValueListenableBuilder(
              valueListenable:
                  ConductorListFunctions.instance.getConductoristNotifier,
              builder:
                  (BuildContext context, List<Listdet> newList, Widget? _) {
                return DataTable(
                  columns: getColumns(columns = [
                    'S.No',
                    'Name',
                    'Phone',
                    'Active',
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
        task.cname,
        task.mobileNo,
        task.status,
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
                        builder: (context) => ScreenConductor(
                            conductor_id: task.conductorId, flag: 1),
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
