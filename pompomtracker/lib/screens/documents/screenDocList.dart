import 'package:intl/intl.dart';
import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/function/documents/documentFun.dart';
import 'package:pompomtracker/model/bus_master/bus_list_resp/document_list.dart';
import 'package:pompomtracker/screens/documents/screenDoc.dart';

class ScreenDocList extends StatefulWidget {
  const ScreenDocList({super.key});

  @override
  State<ScreenDocList> createState() => _ScreenDocListState();
}

class _ScreenDocListState extends State<ScreenDocList> {
  List<String> columns = [];
  List<String?> cells = [];

// Currently selected document type
  String selectedDocType = 'All';

// Filtered list shown in the table
  List<DocumentList> filteredDocList = [];

// Dropdown values
  List<String> docTypeList = ['All'];

    Color getExpiryColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'expired':
        return Colors.red;

      case 'expiring soon':
        return Colors.orange;

      case 'active':
        return Colors.green;

      default:
        return Colors.black;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await DocumentsFun.instance.getDocList(context);

      final docList = DocumentsFun.instance.getDocListNotifier.value;

      if (mounted) {
      await showExpiryNotificationPopup(context, docList);
    }
      final types = docList
          .map((doc) => doc.docType)
          .whereType<String>()
          .where((type) => type.isNotEmpty)
          .toSet()
          .toList();

      if (!mounted) return;

      setState(() {
        docTypeList = ['All', ...types];
        selectedDocType = 'All';
      });
    });
  }

  Future<bool?> popscreen(BuildContext context) async {
    DocumentsFun.instance.getDocListNotifier.value = [];
    // Navigator.pop(context);
      Navigator.pushReplacement(
                      context, Approutes().mainScreen);
    return true;
  }

  Future<void> showExpiryNotificationPopup(
  BuildContext context,
  List<DocumentList> docList,
) async {
  final expiredDocuments = docList
      .where(
        (doc) => doc.expiryStatus?.toLowerCase() == 'expired',
      )
      .toList();

  final expiringSoonDocuments = docList
      .where(
        (doc) => doc.expiryStatus?.toLowerCase() == 'expiring soon',
      )
      .toList();

  // Nothing to show
  if (expiredDocuments.isEmpty && expiringSoonDocuments.isEmpty) {
    return;
  }

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        titlePadding: const EdgeInsets.fromLTRB(20, 18, 20, 5),
        contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
        actionsPadding: const EdgeInsets.fromLTRB(15, 0, 15, 12),

        title: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Colors.red,
              size: 28,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Document Expiry Alert',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),

        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =========================
                // EXPIRED DOCUMENTS
                // =========================
                if (expiredDocuments.isNotEmpty) ...[
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 7),
                      Text(
                        'Expired Documents',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  ...expiredDocuments.asMap().entries.map(
                    (entry) {
                      final index = entry.key + 1;
                      final document = entry.value;

                      return _expiryDocumentItem(
                        document,
                        index,
                        Colors.red,
                      );
                    },
                  ),

                  const SizedBox(height: 15),
                ],

                // =========================
                // EXPIRING SOON DOCUMENTS
                // =========================
                if (expiringSoonDocuments.isNotEmpty) ...[
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 7),
                      Text(
                        'Expiring Soon',
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  ...expiringSoonDocuments.asMap().entries.map(
                    (entry) {
                      final index = entry.key + 1;
                      final document = entry.value;

                      return _expiryDocumentItem(
                        document,
                        index,
                        Colors.orange,
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        ),

        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                'OK',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
Widget _expiryDocumentItem(
  DocumentList document,
  int index,
  Color warningColor,
) {
  String validTo = '';

  if (document.validTo != null &&
      document.validTo!.isNotEmpty) {
    try {
      validTo = DateFormat('dd-MM-yyyy').format(
        DateFormat('yyyy-MM-dd').parse(document.validTo!),
      );
    } catch (_) {
      validTo = document.validTo!;
    }
  }

  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: warningColor.withOpacity(0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: warningColor.withOpacity(0.35),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Number
        Container(
          width: 25,
          height: 25,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: warningColor,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$index',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),

        const SizedBox(width: 10),

        // Document details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                document.docType ?? 'Document',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),

              const SizedBox(height: 3),

              if ((document.regno ?? document.permitNo) != null)
                Text(
                  'No: ${document.regno ?? document.permitNo}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                ),

              if (validTo.isNotEmpty)
                Text(
                  'Valid To: $validTo',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: warningColor,
                  ),
                ),
            ],
          ),
        ),

        // Warning icon
        Icon(
          Icons.warning_amber_rounded,
          color: warningColor,
          size: 22,
        ),
      ],
    ),
  );
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
                  DocumentsFun.instance.getDocListNotifier.value = [];
                  Navigator.pushReplacement(
                      context, Approutes().mainScreen);
                  // Navigator.pop(context);
                },
              ),
              title: Text(
                'Documents List',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Theme(
                    data: MyTheme.googleFormTheme,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isSmallScreen = constraints.maxWidth < 360;
                    
                        if (isSmallScreen) {
                          return Row(
                            children: [
                              // Add New Document
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => const ScreenDoc(),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Add New Document',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Icon(
                                        Icons.add_circle_outline,
                                        size: 27,
                                        color:Color(0xff13bc91),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                    
                              const SizedBox(width: 6),
                    
                              // Small Filter label
                              const Text(
                                'Filter',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                    
                              const SizedBox(width: 4),
                    
                              // Small but usable dropdown
                              SizedBox(
                                width: 95,
                                child: DropdownButtonFormField<String>(
                                  value: selectedDocType,
                                  isExpanded: true,
                                  dropdownColor:
                                      Theme.of(context).colorScheme.onPrimary,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 7,
                                      vertical: 5,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  items: docTypeList.map((type) {
                                    return DropdownMenuItem<String>(
                                      value: type,
                                      child: Text(
                                        type,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value == null) return;
                    
                                    setState(() {
                                      selectedDocType = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                    
                        // Normal / larger mobile screens
                        return Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const ScreenDoc(flag:0),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'Add New Document',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Icon(
                                      Icons.add_circle_outline,
                                      size: 30,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 140,
                              child: DropdownButtonFormField<String>(
                                dropdownColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                value: selectedDocType,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                icon: Theme(
                                  data: Theme.of(context),
                                  child: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  ),
                                ),
                                isExpanded: true,
                                decoration: InputDecoration(
                                  labelText: 'Filter',
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.black),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                items: docTypeList.map((type) {
                                  return DropdownMenuItem<String>(
                                    value: type,
                                    child: Text(
                                      type,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value == null) return;
                    
                                  setState(() {
                                    selectedDocType = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ScrollableWidget(
                    child: ValueListenableBuilder(
                        valueListenable:
                            DocumentsFun.instance.getDocListNotifier,
                        builder: (BuildContext context,
                            List<DocumentList> newList, Widget? _) {
                          final displayList = selectedDocType == 'All'
                              ? newList
                              : newList
                                  .where(
                                    (doc) => doc.docType == selectedDocType,
                                  )
                                  .toList();
                          return Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (newList.isNotEmpty) ...[
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    //borderRadius:const BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                                  ),
                                  child: DataTable(
                                    dataRowMaxHeight: 35,
                                    dataRowMinHeight: 35,
                                    headingRowHeight: 35,
                                    columnSpacing: 15,
                                    headingRowColor: WidgetStateProperty.all(
                                        Color.fromARGB(255, 204, 123, 2)),
                                    columns: getColumns(columns = [
                                      'S.No',
                                      'Document Type',
                                      'Document No',
                                      'Valid From',
                                      'Valid To',
                                      'Action',
                                    ]),
                                    rows: getRows(displayList),
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
                                                255, 204, 123, 2),
                                          ),
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
                                            style:
                                                TextStyle(color: Colors.black),
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

  List<DataRow> getRows(List<DocumentList> newList) {
    return newList.asMap().entries.map((entry) {
      int index = entry.key + 1; // Serial number starts from 1
      DocumentList task = entry.value;
      final fromDate = DateFormat('dd-MM-yyyy')
          .format(DateFormat('yyyy-MM-dd').parse(task.validFrom!));
      final toDate = DateFormat('dd-MM-yyyy')
          .format(DateFormat('yyyy-MM-dd').parse(task.validTo!));

      cells = [
        task.docType ?? '',
        task.regno ?? task.permitNo,
        fromDate,
        toDate,
      ];

      final expiryColor = getExpiryColor(task.expiryStatus);
      
      return DataRow(
        color: WidgetStateProperty.resolveWith<Color?>(
        (states) {
          return expiryColor.withOpacity(0.15);
        },
      ),

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
            final taskbold = index == 1;
            return DataCell(
              Center(
                child: Text('$cell',
                    style: taskbold
                        ? const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)
                        : const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
              ),
            );
          }),
          DataCell(
            Row(
              children: [
                Center(
                  child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScreenDoc(
                                docData: task, flag: 1),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 204, 123, 2),
                      )),
                ),
                Center(
                  child: IconButton(
                      onPressed: () async{
                        await showWarning(task,context);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: const Color.fromARGB(255, 213, 20, 6),
                      )),
                ),
              ],
            ),
          ),
        ],
      );
    }).toList();
  }

  Future<bool?> showWarning(DocumentList task,BuildContext context) async => showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: Text("Do you want to delete document?",
                style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () => Navigator.pop(context, false),
                child: Text("No",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: ()async{
                    final value = await SharedPrefManager.instance.getSharedData();

                        final busMasterReq =BusMasterReq(
                            documentId:task.documentId??'',
                            userId: value!.userId
                            );

                        if (!context.mounted) return;
                        await DocumentsFun.instance.documentDelete(busMasterReq,context);

                        if (!context.mounted) return;
                        // Navigator.pop(context, false);
                },
                child: Text("Yes",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary)),
              ),
            ],
          ));
}
