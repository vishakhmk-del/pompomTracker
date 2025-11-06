
import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/function/time/timeconvertFun.dart';

class ScreenStopPreview extends StatefulWidget {
  const ScreenStopPreview({super.key,this.tripid,this.tripName});
  final String? tripid;
  final String? tripName;


  @override
  State<ScreenStopPreview> createState() => _ScreenStopPreviewState();
}

class _ScreenStopPreviewState extends State<ScreenStopPreview> {
   List<String> columns = [];
  List<String?> cells = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await StopFunctions.instance.getPrvwStpFn(widget.tripid,0);
    });
  }

  Future<bool?> popscreen(BuildContext context) async {
    StopFunctions.instance.getPriviewStopNotifier.value=[];
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
        //  log('BackButton pressed!');
      },
      child: Stack(
        children: [
          //BackgroundColorGradient(),
          Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                      StopFunctions.instance.getPriviewStopNotifier.value=[];

                  Navigator.pop(context);
                },
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Preview',
                    style: TextStyle(color: Colors.white),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                                colors: [
                                     Colors.orange,
                                      const Color.fromARGB(255, 204, 123, 2)
                                      ],
                                  ),
                              ),
                      child: Theme(
                        data: MyTheme.buttonStyleTheme,
                        child: ElevatedButton(
                          onPressed: () async {
                            await StopFunctions.instance.updateStopdet(widget.tripid,context);

                          },
                          child: Text('Confirm', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
                          ),
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ScrollableWidget(
                    child: ValueListenableBuilder(
                        valueListenable:StopFunctions.instance.getPriviewStopNotifier,
                        builder: (BuildContext context, List<Listdet> newList,
                            Widget? _) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (newList.isNotEmpty) ...[
                                SizedBox(height: 10,),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black),
                                    //borderRadius:const BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                                  ),
                                  child:  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("${widget.tripName}",style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w800)),
                                      ),
                                      DataTable(
                                        dataRowMaxHeight: 35,
                                        dataRowMinHeight: 35,
                                        headingRowHeight: 35,
                                        columnSpacing: 15,
                                        headingRowColor: WidgetStateProperty.all(
                                            Color.fromARGB(255, 204, 123, 2)),
                                        columns: getColumns(columns = [
                                          'Stop Id',
                                          'Stop Name',
                                          'Is Stage',
                                          'Km',
                                          'Arriving',
                                          'Departure'
                                        ]),
                                        rows: getRows(newList),
                                      ),
                                    ],
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
                                              const CircularProgressIndicator(color: Color.fromARGB(255, 204, 123, 2),),
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
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color:Colors.white),
        ),
      );
    }).toList();
  }

  List<DataRow> getRows(List<Listdet> newList) {
    return newList.asMap().entries.map((entry) {
      // int index = entry.key + 1; // Serial number starts from 1
      Listdet task = entry.value;
      // String? dptime=TimeConvertFun.instance.formatTo12Hour(task.departureTime);
       cells = [
          task.stopId ?? '',
          task.stopName ?? '',
          task.isStage ?? '',
          task.km ?? '',
          TimeConvertFun.instance.formatTo12Hour(task.arrivingTime),
          TimeConvertFun.instance.formatTo12Hour(task.departureTime)
        ];
      return DataRow(
        cells: [
          // DataCell(
          //   Center(
          //     child: Text(
          //       '$index', // Display the serial number
          //       style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
          //     ),
          //   ),
          // ),
          ...Utils.modelBuilder(cells, (index, cell) {
            final taskbold = index == 0;
            final val = cells[2];
            final stage = val == "y" ? "yes" : "no";
            return DataCell(
              Center(
                child: Text(index == 2 ? stage : '$cell',
                    style: taskbold
                        ? const TextStyle(
                            fontWeight: FontWeight.bold,color: Colors.black
                          )
                        : const TextStyle(fontWeight: FontWeight.normal,color: Colors.black)),
              ),
            );
          }),
        ],
      );
    }).toList();
  }

}