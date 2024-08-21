import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:pompomtracker/model/weeklycollection/wklycollectnmdltyp2/buswklycollect.dart';
import 'package:pompomtracker/model/weeklycollection/wklycollectnmdltyp2/buswklycollectmdl.dart';
import 'package:pompomtracker/provider/loading/loading_provider.dart';

import '../../core/hook/hook.dart';

class Screenhome extends StatefulWidget {
  const Screenhome({super.key});

  @override
  State<Screenhome> createState() => _ScreenhomeState();
}

class _ScreenhomeState extends State<Screenhome> {

  List<Buswklycollectlist> wklyclctlist=[];
  @override
  void initState(){
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //  wklyclctlist=await weeklycollection();
    // });
    
  }
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  

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
             key: _scaffoldKey,
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
                        child: Linechartwidget(repDetails: wklyclctlist,),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Future<List<Buswklycollectlist>> weeklycollection()async{
    final loadingProvider = context.read<LoadingProvider>();
    loadingProvider.toggleLoading();
    final sharevalue=await SharedPrefManager.instance.getSharedData();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    print(formattedDate);
    final wklyrqst=Weeklycollectionreq.req(
      userId: sharevalue!.userId,
      curDate: '2024-06-29');
      final wklyresp = await Busdata().weeklycollection(wklyrqst);
      final resultAsjson = jsonDecode(wklyresp.toString());
      final wklyrspval = Buswklycollction.fromJson(resultAsjson as Map<String, dynamic>);
      if (wklyresp == null) {
      showLoginerror(_scaffoldKey.currentContext!, 1);
    } else if (wklyresp.statusCode == 200 &&
        wklyrspval.status == 'success') {
      
      print('success');
      final wklylist=wklyrspval.repDetails;

     return wklylist;
    } else if (wklyrspval.status == 'Failed') {
      showLoginerror(_scaffoldKey.currentContext!, 2);
      return [];
    } else {
      showLoginerror(_scaffoldKey.currentContext!, 3);
      return [];
    }
    return [];
  }

  Future showLoginerror(BuildContext? context, stat) async {
    
    if (stat == 2) {
      Fluttertoast.showToast(
          msg: "NO DATA FOUND",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 15.0);
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

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

