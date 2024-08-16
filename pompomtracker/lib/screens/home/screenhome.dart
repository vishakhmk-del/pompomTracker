import 'dart:developer';
import 'package:pompomtracker/provider/loading/loading_provider.dart';

import '../../core/hook/hook.dart';

class Screenhome extends StatefulWidget {
  const Screenhome({super.key});

  @override
  State<Screenhome> createState() => _ScreenhomeState();
}

class _ScreenhomeState extends State<Screenhome> {
  @override
  void initState(){
    super.initState();
    weeklycollection();
  }
  

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        log('BackButton pressed!');
        if (!didPop) {
          //final nav=Navigator.of(context);
          if (didPop) return;
          final result = await showWarning(context);
          print(result);
          if (result != null && result) {
            SystemNavigator.pop(); // This will properly exit the app
          }
        }
      },
      child: Stack(
        children: [
          Scaffold(
              // backgroundColor: Colors.black,
              appBar: AppBar(
                  title: Text(
                "PomPomTracker",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              )),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(50),
                      elevation: 3,
                      shadowColor: Theme.of(context).colorScheme.primary,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Theme.of(context).colorScheme.primary,
                                  Theme.of(context).colorScheme.secondary
                                ])),
                        child: Linechartwidget(),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Future<void> weeklycollection()async{
    final loadingProvider = context.read<LoadingProvider>();
    loadingProvider.toggleLoading();
  }

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Do you want to exit app?",
                style: TextStyle(color: Color.fromARGB(255, 101, 47, 248))),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 158, 89, 248),
                ),
                onPressed: () => Navigator.pop(context, false),
                child: const Text("No", style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 158, 89, 248),
                ),
                onPressed: () =>
                    // SystemNavigator.pop(),
                    Navigator.pop(context, true),
                child: const Text("Yes", style: TextStyle(color: Colors.white)),
              ),
            ],
          ));
}
