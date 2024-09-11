
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pompomtracker/core/hook/hook.dart';

class ScreenStopList extends StatefulWidget {
  const ScreenStopList({super.key});

  @override
  State<ScreenStopList> createState() => _ScreenStopListState();
}

class _ScreenStopListState extends State<ScreenStopList> {

  List<String> columns = [];
  List<String?> cells = [];
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
     // await BusListFunctions.instance.getBusDetails();
    });
  }
  Future<bool?> popscreen(BuildContext context) async {
    selectedTaskNotifier.value = StatementType.collectionType;
    selectedModeNotifier.value = StatementType.both;
    Navigator.push(context, Approutes().collectionscreen);
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
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const Screenhome()),
                            (Route<dynamic> route) => false);
                      },
            
          ),
          title: Text(
            'Stop List',
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          ),
        ),
        body: ListView(
          children: [
                  Card(
                      margin: const EdgeInsets.all(10),
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.onSecondary),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        child:Form(
                          key: _formkey,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Theme(
                              data: MyTheme.googleFormTheme,
                              child: Column(children: [],)),
                          ))
                      )),
          ],)
          )
          );
  }
}