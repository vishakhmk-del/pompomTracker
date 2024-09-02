import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/screens/Bus/BusList.dart';
import 'package:pompomtracker/screens/Bus/ScreenBusMaster.dart';
import 'package:pompomtracker/screens/Collection/ScreenCollection.dart';
import 'package:pompomtracker/screens/Conductor/ConductorList.dart';
import 'package:pompomtracker/screens/route_mas/BusRouteList.dart';
import 'package:pompomtracker/screens/route_mas/ScreenRouteMaster.dart';
import 'package:pompomtracker/screens/stop/ScreenStopMaster.dart';
import 'package:pompomtracker/screens/stop/StopList.dart';
import 'package:pompomtracker/screens/trip/ScreenTrip.dart';
import 'package:pompomtracker/screens/trip/TripList.dart';

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
  PageTransition busmasterscreen = PageTransition(
    child: const ScreenBusMater(),
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

  PageTransition collectionscreen = PageTransition(
    child: const ScreenCollection(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  PageTransition tripmasterscreen = PageTransition(
    child: const ScreenTrip(),
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

  PageTransition busListScreen = PageTransition(
    child: const ScreenBusList(),
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

  PageTransition tripListScreen = PageTransition(
    child: const ScreenTripList(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  PageTransition busRouteListScreen = PageTransition(
    child: const ScreenBusRouteList(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  PageTransition stopListScreen = PageTransition(
    child: const ScreenStopList(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
}
