

import 'package:pompomtracker/core/hook/hook.dart';

class ScreenConductorList extends StatefulWidget {
  const ScreenConductorList({super.key});

  @override
  State<ScreenConductorList> createState() => _ScreenConductorListState();
}

class _ScreenConductorListState extends State<ScreenConductorList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child:Text('Conductor List')));
  }
}