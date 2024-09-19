import 'package:pompomtracker/core/hook/hook.dart';

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
  // PageTransition busmasterscreen = PageTransition(
  //   child: const ScreenBusMater(),
  //   type: PageTransitionType.fade,
  //   alignment: Alignment.center,
  //   curve: Curves.easeInOutBack,
  //   duration: const Duration(microseconds: 500),
  // );
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

  PageTransition busListScreen = PageTransition(
    child: const ScreenBusList(),
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
