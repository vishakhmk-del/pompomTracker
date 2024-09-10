import 'package:flutter/material.dart';

class ScreenTripList extends StatefulWidget {
  const ScreenTripList({super.key});

  @override
  State<ScreenTripList> createState() => _ScreenTripListState();
}

class _ScreenTripListState extends State<ScreenTripList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child:Text('Trip List')));
  }
}