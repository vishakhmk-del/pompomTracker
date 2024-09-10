import 'package:pompomtracker/core/hook/hook.dart';

class ScreenConductorList extends StatefulWidget {
  const ScreenConductorList({super.key});

  @override
  State<ScreenConductorList> createState() => _ScreenConductorListState();
}

class _ScreenConductorListState extends State<ScreenConductorList> {
  final _scafoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                _scafoldkey.currentContext!, Approutes().homescreen);
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
              valueListenable: BusListFunctions.instance.getBusListNotifier,
              builder:
                  (BuildContext context, List<BusList> newList, Widget? _) {
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
}
