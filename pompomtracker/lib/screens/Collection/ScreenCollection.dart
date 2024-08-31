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
  String? dropdownsearchvalue;
  String? dropdownbusvalue;
  String? dropdowncashvalue;
  final _list = [dtWise, bsWise];
  final _list1 = [exStatmnt, chStatmnt];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
                title: Text(
              "Statements",
              style: Theme.of(context).textTheme.titleLarge,
            )),
            body: ListView(
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
                                Theme.of(context).colorScheme.onPrimaryFixed
                              ])),
                      child: Column(
                        children: [
                          const RadioButton(
                              title: 'Collection Statement',
                              type: StatementType.collectionType),
                          const RadioButton(
                              title: 'Cash Statement',
                              type: StatementType.cashType),
                          Card(
                            margin: const EdgeInsets.only(
                                top: 10, left: 10, right: 10),
                            elevation: 3,
                            child: Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 1.63,
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
                    ))
              ],
            ))
      ],
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

                setState(() {
                  dropdownsearchvalue = newvalue;
                });
              },
              value: dropdownsearchvalue,
            ),
          ),
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
                  Navigator.push(context, Approutes().collectionscreen);
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
    );
  }

  Widget datewiseForm(BuildContext context) {
    return Form(
        child: Theme(
      data: MyTheme.googleFormTheme,
      child: Column(
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
        ],
      ),
    ));
  }

  Widget buswiseForm(BuildContext context) {
    return Form(
        child: Theme(
      data: MyTheme.googleFormTheme,
      child: Column(
        children: [
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
                  labelText: 'Select Bus',
                  labelStyle: Theme.of(context).textTheme.labelLarge,
                ),
                items: _list.map((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),
                onChanged: (newvalue) {
                  log('Bus :$newvalue');

                  context
                      .read<CollectionDrpDwnProvider>()
                      .changeSelectedVal(newvalue);

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
        ],
      ),
    ));
  }

  /// **********************************************************************

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
        Form(
            child: Theme(
          data: MyTheme.googleFormTheme,
          child: Column(
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
                        Navigator.push(context, Approutes().collectionscreen);
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
        )),
        // Consumer<CashstmntDrpDwnProvider>(
        //                   builder: (context, provider, child) {
        //                     if (provider.selectedVal ==
        //                         exStatmnt) {
        //                       return  expensestmtForm(context);  // Replace with your Collection Form widget
        //                     } else if (provider.selectedVal ==
        //                         chStatmnt) {
        //                       return  cashstmtForm(context);  // Replace with your Cash Form widget
        //                     }
        //                     return Container();  // Or some default widget
        //                   },
        //               ),
      ],
    );
  }

  Widget expensestmtForm(BuildContext context) {
    return Form(
        child: Theme(
      data: MyTheme.googleFormTheme,
      child: Column(
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
        ],
      ),
    ));
  }

  Widget cashstmtForm(BuildContext context) {
    return Form(
        child: Theme(
      data: MyTheme.googleFormTheme,
      child: Column(
        children: [
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
        ],
      ),
    ));
  }

  /// **********************************************************************

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
}
