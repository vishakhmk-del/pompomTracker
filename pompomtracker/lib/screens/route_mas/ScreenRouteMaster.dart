import 'package:flutter/material.dart';
import 'package:pompomtracker/core/hook/hook.dart';

class ScreenRoutemaster extends StatefulWidget {
  const ScreenRoutemaster({super.key});

  @override
  State<ScreenRoutemaster> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ScreenRoutemaster> {
  final _scafoldkey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _viaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scafoldkey,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    _scafoldkey.currentContext!, Approutes().homescreen);
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(
            'Route Master',
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * .6,
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onSecondary),
                  borderRadius: BorderRadius.circular(12)),
              child: Form(
                key: _formKey,
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
                        TextFormField(
                          controller: _fromController,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                              labelText: 'From Station',
                              labelStyle:
                                  Theme.of(context).textTheme.bodySmall),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter From Station';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _toController,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                              labelText: 'To Station',
                              labelStyle:
                                  Theme.of(context).textTheme.bodySmall),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter To Station';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _viaController,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                              labelText: 'Via',
                              labelStyle:
                                  Theme.of(context).textTheme.bodySmall),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Value';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Theme.of(context).colorScheme.primary,
                                    Theme.of(context).colorScheme.secondary,
                                  ])),
                          child: Theme(
                            data: MyTheme.buttonStyleTheme,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {}
                              },
                              child: Text('SAVE',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
