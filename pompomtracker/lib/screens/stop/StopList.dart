import 'package:flutter/material.dart';

class ScreenStopList extends StatefulWidget {
  const ScreenStopList({super.key});

  @override
  State<ScreenStopList> createState() => _ScreenStopListState();
}

class _ScreenStopListState extends State<ScreenStopList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child:Text('Stop List')));
  }
}