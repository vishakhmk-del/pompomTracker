import 'package:intl/intl.dart';
import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/model/weeklycollection/wklycollectnmdltyp2/buswklycollect.dart';
import 'package:pompomtracker/model/weeklycollection/wklycollectnmdltyp2/buswklycollectmdl.dart';

abstract class Commonfn{
  Future wklycolctfn();
}
class Wklycollectfn implements Commonfn{
  Wklycollectfn._internal();
  static Wklycollectfn instance = Wklycollectfn._internal();
  Wklycollectfn factory() {
    return instance;
  }
  ValueNotifier<List<Buswklycollectlist>> wklycollectionNotifier=ValueNotifier([]);
  
  
  @override
  Future wklycolctfn()async{
    
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
      //showLoginerror(_scaffoldKey.currentContext!, 1);
    } else if (wklyresp.statusCode == 200 && wklyrspval.status == 'success') {
      
      print('success');
      final wklylist=wklyrspval.repDetails;

     wklycollectionNotifier.value.clear();
     wklycollectionNotifier.value.addAll( wklylist);
     wklycollectionNotifier.notifyListeners();
    } else if (wklyrspval.status == 'Failed') {
       final wklylist=wklyrspval.repDetails;
        wklycollectionNotifier.value.clear();
        wklycollectionNotifier.value.addAll( wklylist);
        wklycollectionNotifier.notifyListeners();
    //  showLoginerror(_scaffoldKey.currentContext!, 2);
      //return wklylist;
    } else {
      //final wklylist=[];
        wklycollectionNotifier.value.clear();
        wklycollectionNotifier.value.addAll([]);
        wklycollectionNotifier.notifyListeners();
    }
    //final wklylist=[];
        wklycollectionNotifier.value.clear();
        wklycollectionNotifier.value.addAll([]);
        wklycollectionNotifier.notifyListeners();
  }

  
}