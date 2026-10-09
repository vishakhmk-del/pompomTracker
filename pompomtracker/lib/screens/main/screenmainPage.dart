import 'dart:async';
import 'dart:math';
import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/function/documents/documentFun.dart';
import 'package:pompomtracker/screens/Collection/new/screencollectionNew.dart';
// import 'package:pompomtracker/screens/documents/screenDoc.dart';
import 'package:pompomtracker/screens/documents/screenDocList.dart';
import 'package:pompomtracker/screens/wallet/screenWallet.dart';
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
  int? notCount;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await SecurityCheck.checkAndExitIfCompromised(context);
      _startAutoScroll();
      final value = await SharedPrefManager.instance.getSharedData();
      final req = BusMasterReq(
        userId: value!.userId,
      );

      if (!mounted) return;

      notCount = await DocumentsFun.instance.documentNotification(req, context);
    });
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
                height: screenSize.height / 1.29,
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
                    height: screenSize.height * 0.535,
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
                height: 280,
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 50),
                  itemCount: 6,
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
                      'Settings',
                      'Documents',
                      'Wallet'
                    ];
                    final List<IconData> icons = [
                      Icons.search,
                      Icons.list,
                      Icons.bar_chart,
                      Icons.settings,
                      Icons.document_scanner,
                      Icons.wallet
                    ];

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        return InkWell(
                          onTap: () {
                            if (index == 0) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const ScreenListMyBus(),
                                ),
                              );
                            } else if (index == 1) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ScreenDailyCollection(),
                                ),
                              );
                            } else if (index == 2) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ScreenCollectionNew(),
                                ),
                              );
                            } else if (index == 3) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const ScreenSettings(),
                                ),
                              );
                            } else if (index == 4) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const ScreenDocList(),
                                ),
                              );
                            } else if (index == 5) {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => const WalletScreen(),
                              //   ),
                              // );
                            }
                          },
                          child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Colors.orange,
                                        Color.fromARGB(255, 204, 123, 2),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft:
                                          index == 0 || index == 2 || index == 4
                                              ? Radius.zero
                                              : const Radius.circular(20),
                                      topRight:
                                          index == 1 || index == 3 || index == 5
                                              ? Radius.zero
                                              : const Radius.circular(20),
                                      bottomLeft:
                                          index == 0 || index == 2 || index == 4
                                              ? Radius.zero
                                              : const Radius.circular(20),
                                      bottomRight:
                                          index == 1 || index == 3 || index == 5
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
                                    child: index == 0 ||
                                            index == 2 ||
                                            index == 4
                                        ? Row(
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
                                              Icon(
                                                icons[index],
                                                color: Colors.white,
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(
                                                icons[index],
                                                color: Colors.white,
                                              ),
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
                                          ),
                                  ),
                                ),
                                if (index == 5)
                                  Positioned(
                                    top: -9,
                                    left: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFFF5A5F),
                                            Color(0xFFE53935),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1.5,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.22),
                                            blurRadius: 5,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.schedule_rounded,
                                            color: Colors.white,
                                            size: 11,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'COMING SOON',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 8,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: 'Poppins-Medium',
                                              letterSpacing: 0.4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                // Notification badge - Documents only
                                if (index == 4 &&
                                    notCount != null &&
                                    notCount! > 0)
                                  Positioned(
                                    top: -8,
                                    right: -8,
                                    child: Container(
                                      constraints: const BoxConstraints(
                                        minWidth: 24,
                                        minHeight: 24,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: notCount! > 99
                                            ? BoxShape.rectangle
                                            : BoxShape.circle,
                                        borderRadius: notCount! > 99
                                            ? BorderRadius.circular(12)
                                            : null,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          notCount! > 99 ? '99+' : '$notCount',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
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
