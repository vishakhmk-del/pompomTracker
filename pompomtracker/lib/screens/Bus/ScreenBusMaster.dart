import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/provider/theme/theme_constants.dart';

class ScreenBusMater extends StatefulWidget {
  const ScreenBusMater({super.key});

  @override
  State<ScreenBusMater> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ScreenBusMater> {
  final _formkey = GlobalKey<FormState>();
  final _scafoldkey = GlobalKey<ScaffoldState>();
  final _nameControler = TextEditingController();
  final _shortnameControler = TextEditingController();
  final _registartionNoControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldkey,
      body: Center(
          child: Card(
        margin: const EdgeInsets.all(20),
        elevation: 50,
        shadowColor: Theme.of(context).colorScheme.primary,
        child: SizedBox(
          width: 500,
          height: 500,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Theme(
                    data: MyTheme.googleFormTheme,
                    child: Column(
                      children: [
                        const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/bus/busmaster.png'),
                          radius: 50,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: _nameControler,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle:
                                  Theme.of(context).textTheme.labelSmall,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter name';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: _shortnameControler,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                            decoration: InputDecoration(
                              labelText: 'Short Name',
                              labelStyle:
                                  Theme.of(context).textTheme.labelMedium,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Short Name';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: _registartionNoControler,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                            decoration: InputDecoration(
                              labelText: 'Registartion No',
                              labelStyle:
                                  Theme.of(context).textTheme.labelMedium,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Registartion No';
                              } else {
                                return null;
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ),
        ),
      )),
    );
  }
}
