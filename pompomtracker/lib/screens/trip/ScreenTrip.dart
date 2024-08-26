import 'package:pompomtracker/core/hook/hook.dart';

class ScreenTrip extends StatefulWidget {
  const ScreenTrip({super.key});

  @override
  State<ScreenTrip> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ScreenTrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border:
                Border.all(color: Theme.of(context).colorScheme.onSecondary)),
      ),
    )));
  }
}
