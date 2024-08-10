import 'dart:developer';
import '../../core/hook/hook.dart';

class Screenhome extends StatelessWidget {
  const Screenhome({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
      child: Stack(children: [
        Scaffold(
            appBar: AppBar(title: const Text("PomPomTracker")),
            body: Center(
              child: Text('home page'),
            )),
      ]),
    );
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
