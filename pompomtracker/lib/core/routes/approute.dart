import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/screens/Bus/new/ScreenBusListNew.dart';
import 'package:pompomtracker/screens/Bus/new/ScreenBusMasterNew.dart';
import 'package:pompomtracker/screens/Daily%20Collection/screenDailyCollection.dart';
import 'package:pompomtracker/screens/Emp_Details/employee/Employee/new/ScreenEmployeeNew.dart';
import 'package:pompomtracker/screens/Emp_Details/employee/conductor/new/ScreenconductorListNew.dart';
import 'package:pompomtracker/screens/Emp_Details/employee/driver/new/screendriverViewNew.dart';
import 'package:pompomtracker/screens/LinkBusRoute/new/BusRouteListNew.dart';
import 'package:pompomtracker/screens/LinkBusRoute/new/ScreenLinkBusRouteNew.dart';
import 'package:pompomtracker/screens/home/new/screenSettings.dart';
import 'package:pompomtracker/screens/main/screenmainPage.dart';
import 'package:pompomtracker/screens/route_mas/new/ScreenRouteMasterNew.dart';
import 'package:pompomtracker/screens/stop/new/ScreenStopListNew.dart';
import 'package:pompomtracker/screens/stop/new/ScreenStopMasterNew.dart';
import 'package:pompomtracker/screens/trip/new/ScreeenTriplistNew.dart';
import 'package:pompomtracker/screens/trip/new/ScreenTripMasterNew.dart';

class Approutes {
  PageTransition loginscreen = PageTransition(
    child: const ScreenLogin(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition homescreen = PageTransition(
    child: const Screenhome(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition settingscreen = PageTransition(
    child: const ScreenSettings(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition busmasterscreen = PageTransition(
    child: const ScreenBusMater(
      flag: 0,
    ),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition busmasternewscreen = PageTransition(
    child: const ScreenBusMasterNew(
      flag: 0,
    ),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition routemasterscreen = PageTransition(
    child: const ScreenRoutemaster(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition routemasterNewscreen = PageTransition(
    child: const ScreenRoutemasterNew(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  PageTransition collectionscreen = PageTransition(
    child: const ScreenCollection(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  PageTransition tripmasterscreen = PageTransition(
    child: const ScreenTripMaster(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition tripmasterNewscreen = PageTransition(
    child: const ScreenTripMasterNew(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition stoppmasterscreen = PageTransition(
    child: const ScreenStopMaster(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition stoppmasterNewscreen = PageTransition(
    child: const ScreenStopMasterNew(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  PageTransition linkbusroutescreen = PageTransition(
    child: const ScreenLinkBusRoute(
      flag: 0,
    ),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition linkbusrouteNewscreen = PageTransition(
    child: const ScreenLinkBusRouteNew(
      flag: 0,
    ),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  PageTransition busListScreen = PageTransition(
    child: const ScreenBusList(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  PageTransition busListNewScreen = PageTransition(
    child: const ScreenBusListNew(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  PageTransition conductoscreen = PageTransition(
    child: const ScreenConductor(flag: 0),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition employeescreen = PageTransition(
    child: const ScreenEmployeeNew(flag: 0),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  PageTransition conductorListScreen = PageTransition(
    child: const ScreenConductorList(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition conductorListNewScreen = PageTransition(
    child: const ScreenConductorListNew(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition tripListScreen = PageTransition(
    child: const ScreenTripList(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition tripListNewScreen = PageTransition(
    child: const ScreenTripListNew(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  PageTransition busRouteListScreen = PageTransition(
    child: const BusRouteList(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition busRouteListNewScreen = PageTransition(
    child: const BusRouteListNew(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  PageTransition stopListScreen = PageTransition(
    child: const ScreenStopList(flag: 0),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition stopListScreenNew = PageTransition(
    child: const ScreenStopListNew(flag: 0),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition screenTripEdit = PageTransition(
    child: const ScreenTrip(
      flag: 0,
    ),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition screenDriverView = PageTransition(
    child: const ScreenDriverView(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition screenDriverNewView = PageTransition(
    child: const ScreenDriverViewNew(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  PageTransition employeeAssign = PageTransition(
    child: const ScreenEmployeeAssign(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition mainScreen = PageTransition(
    child: const ScreenMainPage(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
   PageTransition dailycollectionScreen = PageTransition(
    child: const ScreenDailyCollection(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  
}
