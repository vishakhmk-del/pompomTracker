import 'dart:developer';
import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/provider/collectiondropdown/collectiondrpdwn_provider.dart';



class ScreenCollection extends StatefulWidget {
   const ScreenCollection({super.key});

  @override
  State<ScreenCollection> createState() => _ScreenCollectionState();
}

class _ScreenCollectionState extends State<ScreenCollection> {
  final _dateFromoController = TextEditingController();
  final _dateToController = TextEditingController();
  String? dropdownvalue;
  final _list=[
    Dtwise,
    Bswise
  ];

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Scaffold(
          appBar: AppBar(
                title: Text(
              "Statements",
              style: Theme.of(context).textTheme.titleLarge,
            )),
          body:ListView(
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
                               const RadioButton(title: 'Collection Statement', type: StatementType.collectionType),
                               const RadioButton(title: 'Cash Statement', type: StatementType.cashType),

                                Card(
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  elevation: 3,

                                  child: Column(
                                    children: [
                                      Container(
                                        height: MediaQuery.of(context).size.height / 2,
                                        decoration: BoxDecoration(
                                          // border: Border.all(
                                          //   color:
                                          //       Theme.of(context).colorScheme.secondaryFixed),
                                            borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Consumer<RadiobuttonProvider>(
                                              builder: (context, provider, child) {
                                                if (provider.selectedType ==
                                                    StatementType.collectionType) {
                                                  return  collectionForm(context);  // Replace with your Collection Form widget
                                                } else if (provider.selectedType ==
                                                    StatementType.cashType) {
                                                  return  cashForm();  // Replace with your Cash Form widget
                                                }
                                                return Container();  // Or some default widget
                                              },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                           ),
                                        
                  )
              )
            ],
          )
        )

      ],
    );
  }
/// ************************ Collection Form *************************


  Widget collectionForm(BuildContext context){
    return Theme(
      data: MyTheme.googleFormTheme,
      child: Column(
        children: [
          Text('Collection Statement',
          style: Theme.of(context).textTheme.titleLarge,),
          SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                        padding: const EdgeInsets.only(
                        top: 30, left: 5,right: 5),
                        child: DropdownButtonFormField(
                          //controller: _selectsearchtypedropdwn,
                          //dropdownColor: Colors.blueGrey,
                          icon: Icon(
                            Icons.arrow_drop_down,
                              color:Theme.of(context).colorScheme.onSecondary),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Select Search Type',
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .labelLarge,
                                  ),
                                  items: _list.map((e){
                                    return DropdownMenuItem(value:e,child: Text(e));
                                  }).toList(),
                                  onChanged: (newvalue){
                                    log('Collection Statement:$newvalue');
    
                                    context.read<CollectionDrpDwnProvider>().changeSelectedVal(newvalue);
    
                                    setState(() {
                                      dropdownvalue=newvalue;
                                    });
                                  },
                                  value:dropdownvalue,
                                  ),
                            ),
                          ),
    
                          Consumer<CollectionDrpDwnProvider>(
                                            builder: (context, provider, child) {
                                              if (provider.selectedVal ==
                                                  Dtwise) {
                                                return  datewiseForm(context);  // Replace with your Collection Form widget
                                              } else if (provider.selectedVal ==
                                                  Bswise) {
                                                return  buswiseForm(context);  // Replace with your Cash Form widget
                                              }
                                              return Container();  // Or some default widget
                                            },
                                        ),
        ],
          ),
    );
  }

  Widget datewiseForm(BuildContext context){
   return Form(
    child: Theme(
      data: MyTheme.googleFormTheme,
      child: Column(
        children: [
          SizedBox(
            width:MediaQuery.of(context).size.width,
             child:Padding(
               padding: const EdgeInsets.only(
                        top: 30, left: 5,right: 5),
               child: GestureDetector(onTap: () =>
                                    _selectDate(context, _dateFromoController),
                 child: AbsorbPointer(
                   child: TextFormField(
                                  controller: _dateFromoController,
                                  style: TextStyle(
                                      color: Theme.of(context).colorScheme.onSecondary),
                                  decoration: InputDecoration(
                                    labelText: 'From Date',
                                    labelStyle:
                                        Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                    suffixIcon:  Icon(
                                      Icons.calendar_today,
                                      color:Theme.of(context).colorScheme.onSecondary
                                      ),
                                  ),
                                  onTap: () =>
                                      _selectDate(context, _dateFromoController),
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
             ),
          )
        ],
      ),
    ));
  }

  Widget buswiseForm(BuildContext context){
   return Form(
    child: Column(
      children: [],
    ));
  }

    Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365*100)),
      lastDate: DateTime.now(),
    );
    if(picked==null){
      return;
    }
    else {
      setState(() {
        controller.text = "${picked.toLocal().day}-${picked.toLocal().month}-${picked.toLocal().year}";
        log(controller.text);
      });
    }
  }
/// **********************************************************************




  Widget cashForm(){
    return Form(
      child: Column(
        children: [
          TextFormField(),
        ],
    ));
  }
}