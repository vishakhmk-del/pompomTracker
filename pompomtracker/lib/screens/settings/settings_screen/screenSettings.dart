import 'dart:developer';
import 'package:pompomtracker/widgets/gridview/gridviewNew.dart';
import '../../../core/hook/hook.dart';

class ScreenSettings extends StatefulWidget {
  const ScreenSettings({super.key});

  @override
  State<ScreenSettings> createState() => _ScreenSettingsState();
}

class _ScreenSettingsState extends State<ScreenSettings> {
  @override
  void initState() {
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<bool?> popscreen(BuildContext context) async {
    //selectedTaskNotifier.value = StatementType.collectionType;
    context.read<CollectionDrpDwnProvider>().changeSelectedVal(dtWise);

    selectedModeNotifier.value = StatementType.both;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const ScreenMainPage()),
        (Route<dynamic> route) => false);
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
      child: Stack(
        children: [
          BackgroundColorGradient(),
          Scaffold(
            key: _scaffoldKey,
            backgroundColor: Color(0xFFE0F7F1),
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, Approutes().mainScreen);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white)),
              title: const Text(
                "Settings",
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
                  child: const BusGridViewNew(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
