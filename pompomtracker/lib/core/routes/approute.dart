import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/screens/Bus/ScreenBusMaster.dart';
import 'package:pompomtracker/screens/Collection/ScreenCollection.dart';
import 'package:pompomtracker/screens/Conductor/ScreenConductor.dart';
import 'package:pompomtracker/screens/LinkBusRoute/ScreenLinkBusRoute.dart';
import 'package:pompomtracker/screens/route_mas/ScreenRouteMaster.dart';
import 'package:pompomtracker/screens/stop/ScreenStopMaster.dart';
import 'package:pompomtracker/screens/trip/ScreenTrip.dart';

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
  PageTransition linkbusroutescreen = PageTransition(
    child: const ScreenLinkBusRoute(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition conductoscreen = PageTransition(
    child: const ScreenConductor(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
}
