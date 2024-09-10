

import 'package:pompomtracker/core/hook/hook.dart';

class ScreenBusList extends StatefulWidget {
  const ScreenBusList({super.key});

  @override
  State<ScreenBusList> createState() => _ScreenBusListState();
}

class _ScreenBusListState extends State<ScreenBusList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child:Text('Buslist')));
  }
}