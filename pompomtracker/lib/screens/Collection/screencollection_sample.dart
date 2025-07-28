import 'dart:developer';
import 'package:pompomtracker/core/hook/hook.dart';

class ScreenCollection extends StatefulWidget {
  const ScreenCollection({super.key});

  @override
  State<ScreenCollection> createState() => _ScreenCollectionState();
}

class _ScreenCollectionState extends State<ScreenCollection> {
  final _cldateFromController = TextEditingController();
  final _cldateToController = TextEditingController();
  final _clbusFromController = TextEditingController();
  final _clbusToController = TextEditingController();
  final _expdateFromController = TextEditingController();
  final _expdateToController = TextEditingController();
  final _cashFromController = TextEditingController();
  final _cashToController = TextEditingController();
  final ScrollController _listViewController = ScrollController();
  // final ScrollController _verticalScrollController = ScrollController();
  // final ScrollController _horizontalScrollController = ScrollController();

  String? dropdownsearchvalue;
  String? dropdownbusvalue;
  String? dropdowncashvalue;
  List<BusRegList>? busreglist = [];
  List<String> registarionlst = [];
  List<String> columns = [];
  List<String?> cells = [];

  final _formkey1 = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();
  final _formkey3 = GlobalKey<FormState>();
  final _formkey4 = GlobalKey<FormState>();

  final _list = [dtWise, bsWise];
  final _list1 = [exStatmnt, chStatmnt];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(Duration.zero, () {
        if (!mounted) return;

        final loadingProvider = context.read<LoadingProvider>();
        loadingProvider.reset();

        var po = context.read<CheckProvider>();
        po.reset();

        context.read<ElevatedBtnProvider>().changeSelectedVal(false);

        context.read<RadiobuttonProvider>().reset();
      });

      busreglist = await Wklycollectfn.instance.busReglistfn(context);
      setState(() {
        registarionlst = busreglist!
            .map((bus) => bus.registrationNo ?? "")
            .toList(); //calling registarion list  from main model
      });
    });
  }

  Future<bool?> popscreen(BuildContext context) async {
    selectedTaskNotifier.value = StatementType.collectionType;
    selectedModeNotifier.value = StatementType.both;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Screenhome()),
        (Route<dynamic> route) => false);
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
          Scaffold(
              appBar: AppBar(
                title: Text(
                  "Statements",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                leading: IconButton(
                    onPressed: () {
                      selectedTaskNotifier.value = StatementType.collectionType;
                      selectedModeNotifier.value = StatementType.both;

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const Screenhome()),
                          (Route<dynamic> route) => false);
                    },
                    icon: const Icon(Icons.arrow_back)),
              ),
              body: ListView(
                controller: _listViewController,
                children: [
                  Card(
                      margin: const EdgeInsets.all(10),
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Theme.of(context).colorScheme.onPrimaryFixed,
                                  Theme.of(context).colorScheme.onPrimary,
                                ])),
                        child: Column(
                          children: [
                            const StmntRadioButton(
                                title: 'Collection Statement',
                                type: StatementType.collectionType),
                            const StmntRadioButton(
                                title: 'Cash Statement',
                                type: StatementType.cashType),
                            Card(
                              margin: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              elevation: 3,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Consumer<RadiobuttonProvider>(
                                        builder: (context, provider, child) {
                                          if (provider.selectedType ==
                                              StatementType.collectionType) {
                                            return collectionForm(context);
                                            // Replace with your Collection Form widget
                                          } else if (provider.selectedType ==
                                              StatementType.cashType) {
                                            return cashForm(context);
                                            // Replace with your Cash Form widget
                                          }
                                          return Container();
                                          // Or some default widget
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                  Column(
                    children: [
                      Consumer<ElevatedBtnProvider>(
                        builder: (context, provider, child) {
                          if (provider.selectedVal == false) {
                            return Container();
                            // Replace with your Collection Form widget
                          } else if (provider.selectedVal == true) {
                            //   WidgetsBinding.instance.addPostFrameCallback((_) {
                            //   _scrollToBottom(); // Call the function to scroll down
                            // });
                            return ScrollableWidget(child: buildStmntTbl());
                            // Replace with your Cash Form widget
                          }
                          return Container();
                          // Or some default widget
                        },
                      ),
                    ],
                  ),
                ],
              ))
        ],
      ),
    );
  }

  /// ************************ Collection Form *************************

  Widget collectionForm(BuildContext context) {
    return Column(
      children: [
        Text(
          'Collection Statement',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 5, right: 5),
            child: DropdownButtonFormField(
              //controller: _selectsearchtypedropdwn,
              dropdownColor: Theme.of(context).colorScheme.tertiary,
              icon: Icon(Icons.arrow_drop_down,
                  color: Theme.of(context).colorScheme.onSecondary),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE1E1E1), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE1E1E1), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE1E1E1), width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE1E1E1), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                labelText: 'Select Search Type',
                labelStyle: Theme.of(context).textTheme.labelLarge,
              ),
              items: _list.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
              onChanged: (newvalue) {
                log('Collection Statement:$newvalue');

                context
                    .read<CollectionDrpDwnProvider>()
                    .changeSelectedVal(newvalue);

                context.read<ElevatedBtnProvider>().changeSelectedVal(false);
                _clbusFromController.clear();

                setState(() {
                  dropdownsearchvalue = newvalue;
                  _clbusFromController.clear();
                  _clbusToController.clear();
                  _cldateFromController.clear();
                  _cldateToController.clear();
                });
              },
              value: dropdownsearchvalue,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ModeRadioButton(title: 'Both', type: StatementType.both),
            ModeRadioButton(title: 'Online', type: StatementType.on),
            ModeRadioButton(title: 'Offline', type: StatementType.off),
          ],
        ),
        Consumer<CollectionDrpDwnProvider>(
          builder: (context, provider, child) {
            if (provider.selectedVal == dtWise) {
              return datewiseForm(
                  context); // Replace with your Collection Form widget
            } else if (provider.selectedVal == bsWise) {
              return buswiseForm(context); // Replace with your Cash Form widget
            }
            return Container(); // Or some default widget
          },
        ),
      ],
    );
  }

  Widget datewiseForm(BuildContext context) {
    return Form(
        key: _formkey1,
        child: Theme(
          data: MyTheme.googleFormTheme,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                  child: TextFormField(
                    controller: _cldateFromController,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(
                      labelText: 'From Date',
                      labelStyle: Theme.of(context).textTheme.labelLarge,
                      suffixIcon: Icon(Icons.calendar_today,
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                    onTap: () => _selectDate(context, _cldateFromController),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Select Date';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                  child: TextFormField(
                    controller: _cldateToController,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(
                      labelText: 'To Date',
                      labelStyle: Theme.of(context).textTheme.labelLarge,
                      suffixIcon: Icon(Icons.calendar_today,
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                    onTap: () => _selectDate(context, _cldateToController),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Select Date';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    Theme(
                      data: Theme.of(context),
                      child: Consumer<CheckProvider>(
                        builder: (context, check, _) => Checkbox(
                            value: check.isAccepted,
                            onChanged: (value) {
                              check.setAccepted(value);
                            }),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      "Summary",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.labelLarge,
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  height: 45,
                  width: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Theme(
                    data: MyTheme.buttonStyleTheme,
                    child: ElevatedButton(
                      onPressed: () async {
                        context
                            .read<ElevatedBtnProvider>()
                            .changeSelectedVal(true);

                        if (_formkey1.currentState!.validate()) {
                          final frmdt = _cldateFromController.text;
                          final todt = _cldateToController.text;
                          var pro = context.read<CheckProvider>();
                          final val = pro.isAccepted;

                          var proval = context.read<RadiobuttonProvider>();
                          final mode = proval.selectedMode;
                          String? stmntmode;
                          if (mode == StatementType.both) {
                            stmntmode = stmntall;
                          } else if (mode == StatementType.on) {
                            stmntmode = stmntonline;
                          } else if (mode == StatementType.off) {
                            stmntmode = stmntoffline;
                          }

                          final value = Stmntfnparameter(
                              fromdate: frmdt,
                              todate: todt,
                              summary: val,
                              mode: stmntmode);

                          fetchclstatement(context, value);
                        }
                      },
                      child: Text(
                        'Show',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget buswiseForm(BuildContext context) {
    return Form(
        key: _formkey2,
        child: Theme(
          data: MyTheme.googleFormTheme,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                  child: DropdownButtonFormField(
                    //controller: _selectsearchtypedropdwn,
                    dropdownColor: Theme.of(context).colorScheme.tertiary,
                    icon: Icon(Icons.arrow_drop_down,
                        color: Theme.of(context).colorScheme.onSecondary),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Select Bus',
                      labelStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    items: registarionlst.map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    onChanged: (newvalue) {
                      log('Bus :$newvalue');

                      //context.read<CollectionDrpDwnProvider>().changeSelectedVal(newvalue);

                      setState(() {
                        dropdownbusvalue = newvalue;
                      });
                    },
                    value: dropdownbusvalue,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                  child: TextFormField(
                    controller: _clbusFromController,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(
                      labelText: 'From Date',
                      labelStyle: Theme.of(context).textTheme.labelLarge,
                      suffixIcon: Icon(Icons.calendar_today,
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                    onTap: () => _selectDate(context, _clbusFromController),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Select Date';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                  child: TextFormField(
                    controller: _clbusToController,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(
                      labelText: 'To Date',
                      labelStyle: Theme.of(context).textTheme.labelLarge,
                      suffixIcon: Icon(Icons.calendar_today,
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                    onTap: () => _selectDate(context, _clbusToController),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Select Date';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  height: 45,
                  width: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Theme(
                    data: MyTheme.buttonStyleTheme,
                    child: ElevatedButton(
                      onPressed: () async {
                        context
                            .read<ElevatedBtnProvider>()
                            .changeSelectedVal(true);

                        if (_formkey2.currentState!.validate()) {
                          final frmdt = _clbusFromController.text;
                          final todt = _clbusToController.text;
                          final regno = dropdownbusvalue;

                          final value = Stmntfnparameter(
                            fromdate: frmdt,
                            todate: todt,
                            type: regno,
                          );

                          fetchclstatement(context, value);
                        }
                      },
                      child: Text(
                        'Show',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  /// ************************* Collection Form end ****************************

  /// ************************ Cash Form *************************

  Widget cashForm(BuildContext context) {
    return Column(
      children: [
        Text(
          'Cash Statement',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 5, right: 5),
            child: DropdownButtonFormField(
              //controller: _selectsearchtypedropdwn,
              dropdownColor: Theme.of(context).colorScheme.tertiary,
              icon: Icon(Icons.arrow_drop_down,
                  color: Theme.of(context).colorScheme.onSecondary),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE1E1E1), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE1E1E1), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE1E1E1), width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE1E1E1), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                labelText: 'Select Search Type',
                labelStyle: Theme.of(context).textTheme.labelLarge,
              ),
              items: _list1.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
              onChanged: (newvalue) {
                log('Collection Statement:$newvalue');

                context
                    .read<CashstmntDrpDwnProvider>()
                    .changeSelectedVal(newvalue);

                setState(() {
                  dropdowncashvalue = newvalue;
                });
              },
              value: dropdowncashvalue,
            ),
          ),
        ),
        Consumer<CashstmntDrpDwnProvider>(
          builder: (context, provider, child) {
            if (provider.selectedVal == exStatmnt) {
              return expensestmtForm(
                  context); // Replace with your Collection Form widget
            } else if (provider.selectedVal == chStatmnt) {
              return cashstmtForm(
                  context); // Replace with your Cash Form widget
            }
            return Container(); // Or some default widget
          },
        ),
      ],
    );
  }

  Widget expensestmtForm(BuildContext context) {
    return Form(
        key: _formkey3,
        child: Theme(
          data: MyTheme.googleFormTheme,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                  child: DropdownButtonFormField(
                    //controller: _selectsearchtypedropdwn,
                    dropdownColor: Theme.of(context).colorScheme.tertiary,
                    icon: Icon(Icons.arrow_drop_down,
                        color: Theme.of(context).colorScheme.onSecondary),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Select Bus',
                      labelStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    items: [
                      ...registarionlst.map((e) {
                        return DropdownMenuItem(value: e, child: Text(e));
                      }).toList(),
                      const DropdownMenuItem(
                        value: 'all',
                        child: Text('All'),
                      ),
                    ],
                    onChanged: (newvalue) {
                      log('Bus :$newvalue');

                      //context.read<CollectionDrpDwnProvider>().changeSelectedVal(newvalue);

                      setState(() {
                        dropdownbusvalue = newvalue;
                      });
                    },
                    value: dropdownbusvalue,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                  child: TextFormField(
                    controller: _expdateFromController,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(
                      labelText: 'From Date',
                      labelStyle: Theme.of(context).textTheme.labelLarge,
                      suffixIcon: Icon(Icons.calendar_today,
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                    onTap: () => _selectDate(context, _expdateFromController),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Select Date';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                  child: TextFormField(
                    controller: _expdateToController,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(
                      labelText: 'To Date',
                      labelStyle: Theme.of(context).textTheme.labelLarge,
                      suffixIcon: Icon(Icons.calendar_today,
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                    onTap: () => _selectDate(context, _expdateToController),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Select Date';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    Theme(
                      data: Theme.of(context),
                      child: Consumer<CheckProvider>(
                        builder: (context, check, _) => Checkbox(
                            value: check.isAccepted,
                            onChanged: (value) {
                              check.setAccepted(value);
                            }),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      "Summary",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.labelLarge,
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  height: 45,
                  width: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Theme(
                    data: MyTheme.buttonStyleTheme,
                    child: ElevatedButton(
                      onPressed: () async {
                        context
                            .read<ElevatedBtnProvider>()
                            .changeSelectedVal(true);

                        if (_formkey3.currentState!.validate()) {
                          final frmdt = _expdateFromController.text;
                          final todt = _expdateToController.text;
                          var pro = context.read<CheckProvider>();
                          final val = pro.isAccepted;
                          final regno = dropdownbusvalue;

                          final value = Stmntfnparameter(
                              fromdate: frmdt,
                              todate: todt,
                              summary: val,
                              type: regno);

                          fetchcashstatement(context, value);
                        }
                      },
                      child: Text(
                        'Show',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget cashstmtForm(BuildContext context) {
    return Form(
        key: _formkey4,
        child: Theme(
          data: MyTheme.googleFormTheme,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                  child: TextFormField(
                    controller: _cashFromController,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(
                      labelText: 'From Date',
                      labelStyle: Theme.of(context).textTheme.labelLarge,
                      suffixIcon: Icon(Icons.calendar_today,
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                    onTap: () => _selectDate(context, _cashFromController),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Select Date';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                  child: TextFormField(
                    controller: _cashToController,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(
                      labelText: 'To Date',
                      labelStyle: Theme.of(context).textTheme.labelLarge,
                      suffixIcon: Icon(Icons.calendar_today,
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                    onTap: () => _selectDate(context, _cashToController),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Select Date';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  height: 45,
                  width: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Theme(
                    data: MyTheme.buttonStyleTheme,
                    child: ElevatedButton(
                      onPressed: () async {
                        context
                            .read<ElevatedBtnProvider>()
                            .changeSelectedVal(true);

                        if (_formkey4.currentState!.validate()) {
                          final frmdt = _cashFromController.text;
                          final todt = _cashToController.text;
                          // var pro = context.read<CheckProvider>();
                          // final val = pro.isAccepted;
                          // final regno=dropdownbusvalue;

                          final value = Stmntfnparameter(
                            fromdate: frmdt,
                            todate: todt,
                          );

                          fetchcashstatement(context, value);
                        }
                      },
                      child: Text(
                        'Show',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  /// **************************** Cash Form end *********************************

  /// ****************************Collection Statement Table **********************************

  Widget buildStmntTbl() {
    return ValueListenableBuilder(
        valueListenable: StatementFunctions.instance.getDatewiseStmntNotifier,
        builder: (BuildContext context, List<TicketList> newList, Widget? _) {
          return DataTable(
            columns: getColumns(Provider.of<RadiobuttonProvider>(context,
                            listen: false)
                        .selectedType ==
                    StatementType.collectionType
                ? Provider.of<CollectionDrpDwnProvider>(context, listen: false)
                            .selectedVal ==
                        dtWise
                    ? Provider.of<CheckProvider>(context, listen: false)
                                .isAccepted ==
                            false
                        ? columns = [
                            'Reg No',
                            'Date',
                            'Mode',
                            'Amount',
                          ]
                        : columns = [
                            'Payment Date',
                            'Amount',
                          ]
                    : columns = [
                        'Reg No',
                        'Date',
                        'Amount',
                      ]
                : Provider.of<CashstmntDrpDwnProvider>(context, listen: false)
                            .selectedVal ==
                        exStatmnt
                    ? Provider.of<CheckProvider>(context, listen: false)
                                .isAccepted ==
                            false
                        ? columns = [
                            'Date',
                            'Reg No',
                            'Category',
                            'Expense',
                          ]
                        : columns = [
                            'Date',
                            'Expense',
                          ]
                    : columns = [
                        'Date',
                        'Income',
                        'Expense',
                      ]),
            rows: getRows(newList),
          );
        });
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

  List<DataRow> getRows(List<TicketList> newList) =>
      newList.map((TicketList task) {
        Provider.of<RadiobuttonProvider>(context, listen: false).selectedType ==
                StatementType.collectionType
            ? Provider.of<CollectionDrpDwnProvider>(context, listen: false)
                        .selectedVal ==
                    dtWise
                ? Provider.of<CheckProvider>(context, listen: false)
                            .isAccepted ==
                        false
                    ? cells = [
                        task.regNo ?? '',
                        task.payDate ?? '',
                        task.mode ?? '',
                        task.amount,
                      ]
                    : cells = [
                        task.payDate ?? '',
                        task.amount ?? '',
                      ]
                : cells = [
                    task.regNo ?? '',
                    task.payDate ?? '',
                    task.amount ?? '',
                  ]
            : Provider.of<CashstmntDrpDwnProvider>(context, listen: false)
                        .selectedVal ==
                    exStatmnt
                ? Provider.of<CheckProvider>(context, listen: false)
                            .isAccepted ==
                        false
                    ? cells = [
                        task.payDate ?? '',
                        task.regNo ?? '',
                        task.expensehead ?? '',
                        task.expense ?? '',
                      ]
                    : cells = [
                        task.payDate ?? '',
                        task.expense ?? '',
                      ]
                : cells = [
                    task.payDate ?? '',
                    task.totalIncome ?? '',
                    task.totalExpense ?? '',
                  ];

        return DataRow(
          cells: Utils.modelBuilder(cells, (index, cell) {
            bool modpay = false;
            final taskbold = index == 0;
            final val = cells[1];
            //print(val);
            modpay = val == "Off" ? modpay : !modpay;
            print(modpay);
            //final remarkclr = index == 6;
            return DataCell(
              Center(
                child: Text('$cell',
                    style: taskbold
                        ? const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 88, 147, 250))
                        : const TextStyle(fontWeight: FontWeight.normal)),
              ),
              //onTap: () {}
            );
          }),
        );
      }).toList();

  /// ***************************** Statement Table end ***************************************

  /// ************************ Date selection function *************************

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 100)),
      lastDate: DateTime.now(),
    );
    if (picked == null) {
      return;
    } else {
      setState(() {
        controller.text =
            "${picked.toLocal().day}-${picked.toLocal().month}-${picked.toLocal().year}";
        log(controller.text);
      });
    }
  }

  /// ************************ Date selection Function end *******************************

  /// ************************ Statement fetch function *************************

  Future<void> fetchclstatement(
      BuildContext context, Stmntfnparameter val) async {
    String? selectedValue =
        Provider.of<CollectionDrpDwnProvider>(context, listen: false)
            .selectedVal;

    log('collection type=$selectedValue');

    await StatementFunctions.instance.collectionStmntFn(selectedValue, val);
  }

  Future<void> fetchcashstatement(
      BuildContext context, Stmntfnparameter val) async {
    String? selectedValue =
        Provider.of<CashstmntDrpDwnProvider>(context, listen: false)
            .selectedVal;

    log('cash type=$selectedValue');

    await StatementFunctions.instance.collectionStmntFn(selectedValue, val);
  }

  /// ************************ Statement fetch Function end *******************************
}
