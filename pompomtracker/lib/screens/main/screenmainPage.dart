import 'dart:async';
import 'dart:math';
import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/screens/Collection/new/screencollectionNew.dart';
import 'package:pompomtracker/screens/Track/ScreenTrackMyBus.dart';
import 'package:pompomtracker/screens/home/new/screenSettings.dart';
import 'package:pompomtracker/widgets/navBar/navbarDM.dart';

class ScreenMainPage extends StatefulWidget {
  const ScreenMainPage({super.key});

  @override
  State<ScreenMainPage> createState() => _ScreenMainPageState();
}

class _ScreenMainPageState extends State<ScreenMainPage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  Timer? _autoPageTimer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoPageTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentIndex + 1) % tabs.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentIndex = nextPage;
        });
      }
    });
  }

  @override
  void dispose() {
    _autoPageTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }
Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
          title: Text("Do you want to exit app?",
              style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () => Navigator.pop(context, false),
              child: Text("No",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () =>
                  // SystemNavigator.pop(),
                  Navigator.pop(context, true),
              child: Text("Yes",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary)),
            ),
          ],
        ));
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        // log('BackButton pressed!');
        if (!didPop) {
          if (didPop) return;
          final result = await showWarning(context);
          //print(result);
          if (result != null && result) {
            SystemNavigator.pop(); // This will properly exit the app
          }
        }
      },
      child: Scaffold(
        drawer: const NavbarDM(),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Stack(
          children: [
            CustomPaint(
              painter: ArcPainter(),
              child: SizedBox(
                height: screenSize.height / 1.25,
                width: screenSize.width,
              ),
            ),
            Positioned(
              top: screenSize.height / 11,
              right: 5,
              left: 5,
              child: Column(
                children: [
                  SizedBox(
                    height: screenSize.height * 0.57,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: tabs.length,
                      itemBuilder: (BuildContext context, int index) {
                        OnboardingModel tab = tabs[index];
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              tab.title,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Image.asset(
                              tabs[_currentIndex].lottieFile,
                              key: Key('${Random().nextInt(999999999)}'),
                              width: 300,
                              alignment: Alignment.topCenter,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              tab.subtitle,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black45,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      },
                      onPageChanged: (value) {
                        _currentIndex = value;
                        setState(() {});
                      },
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int index = 0; index < tabs.length; index++)
                        _DotIndicator(isSelected: index == _currentIndex),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 250,
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 50),
                  itemCount: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    childAspectRatio: 3.5,
                  ),
                  itemBuilder: (context, index) {
                    final List<String> titles = [
                      'Track my Bus',
                      'Collection',
                      'Reports',
                      'Settings'
                    ];
                    final List<IconData> icons = [
                      Icons.search,
                      Icons.list,
                      Icons.bar_chart,
                      Icons.settings
                    ];
      
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        return InkWell(
                          onTap: () {
                            if(index==0){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const ScreenMapTrack(),
                                ),
                              );
                            }else if(index==2){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const ScreenCollectionNew(),
                                ),
                              );
                            }else if(index==3){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const ScreenSettings(),
                                ),
                              );
                            }
                            
                          },
                          child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.orange,
                                    Color.fromARGB(255, 204, 123, 2)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: index == 0 || index == 2
                                      ? Radius.zero
                                      : const Radius.circular(20),
                                  topRight: index == 1 || index == 3
                                      ? Radius.zero
                                      : const Radius.circular(20),
                                  bottomLeft: index == 0 || index == 2
                                      ? Radius.zero
                                      : const Radius.circular(20),
                                  bottomRight: index == 1 || index == 3
                                      ? Radius.zero
                                      : const Radius.circular(20),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(2, 4),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: index == 0 || index == 2
                                      ? Row(
                                          // mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              titles[index],
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Poppins-Medium',
                                                color: Colors.white,
                                              ),
                                            ),
                                            //  const SizedBox(width: 8),
                                            Icon(icons[index],
                                                color: Colors
                                                    .white), // matches theme
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(icons[index],
                                                color: Colors.white),
                                            Text(
                                              titles[index],
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Poppins-Medium',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        )),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.04,
              left: MediaQuery.of(context).size.width * 0.017,
              right: MediaQuery.of(context).size.width * 0.017,
              child: Stack(
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Color(0xff16324f),
                        size: 30,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path orangeArc = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height - 170)
      ..quadraticBezierTo(
        size.width / 2,
        size.height,
        size.width,
        size.height - 170,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(orangeArc, Paint()..color = const Color(0xff16324f));

    Path whiteArc = Path()
      ..moveTo(0.0, 0.0)
      ..lineTo(0.0, size.height - 185)
      ..quadraticBezierTo(
        size.width / 2,
        size.height - 70,
        size.width,
        size.height - 185,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(whiteArc, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _DotIndicator extends StatelessWidget {
  final bool isSelected;

  const _DotIndicator({Key? key, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 6.0,
        width: 6.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? const Color(0xff0077C8) : const Color(0xff00c7c8),
        ),
      ),
    );
  }
}

class OnboardingModel {
  final String lottieFile;
  final String title;
  final String subtitle;

  OnboardingModel(this.lottieFile, this.title, this.subtitle);
}

List<OnboardingModel> tabs = [
  OnboardingModel(
    'assets/splash/man-buying-bus-ticket.jpg',
    'Make Payment Simple',
    'Pay in seconds,no confusion\njust tap and go.',
  ),
  OnboardingModel(
    'assets/splash/electronic-bus-ticket.jpg',
    'Track Your Bus',
    'Never miss your ride\ntrack your bus in real time,\nevery stop,every turn.',
  ),
  OnboardingModel(
    'assets/splash/images (1).jpg',
    'Enjoy The Trip',
    'The ride is yours,enjoy every moment,\nno extra steps needed.\nEnjoy',
  ),
];
