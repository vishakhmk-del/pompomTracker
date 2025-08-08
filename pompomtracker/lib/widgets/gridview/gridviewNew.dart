import 'package:pompomtracker/core/hook/hook.dart';

class BusGridViewNew extends StatelessWidget {
  const BusGridViewNew({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 150,
      ),
      children: [
        InkWell(
          splashColor: Theme.of(context).colorScheme.secondaryFixed,
          onTap: () {
            Navigator.pushReplacement(context, Approutes().busmasternewscreen);
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF1f1f1f)
                      : const Color(0xFFe0f7f1),
                  Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF0f0f0f)
                      : const Color(0xFFc8e6e0),
                ],
              ),
              // boxShadow: [
              //   BoxShadow(
              //     color: Theme.of(context).brightness == Brightness.dark
              //         ? Colors.black45
              //         : Colors.black26,
              //     offset: const Offset(4, 4),
              //     blurRadius: 8,
              //   ),
              //   BoxShadow(
              //     color: Theme.of(context).brightness == Brightness.dark
              //         ? Colors.grey.shade800
              //         : Colors.white70,
              //     offset: const Offset(-4, -4),
              //     blurRadius: 8,
              //   ),
              // ],
              border: Border.all(
                color: Theme.of(context).colorScheme.secondaryFixed,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        center: const Alignment(-0.3, -0.3),
                        radius: 0.8,
                        colors: [
                          // Highlight
                          Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF40e4c1)
                              : const Color(0xFF9ff2e0),
                          // Mid-tone
                          const Color(0xff13bc91),
                          // Shadow
                          Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF0b5e49)
                              : const Color(0xFF0e9d78),
                        ],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black54
                              : Colors.black26,
                          offset: const Offset(4, 4),
                          blurRadius: 10,
                        ),
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade800
                              : Colors.white70,
                          offset: const Offset(-4, -4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/home/bus_ad.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Text(
                  "Add Bus",
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        InkWell(
          splashColor: Theme.of(context).colorScheme.secondaryFixed,
          onTap: () {
            Navigator.pushReplacement(
                context, Approutes().routemasterNewscreen);
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF1f1f1f)
                      : const Color(0xFFe0f7f1),
                  Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF0f0f0f)
                      : const Color(0xFFc8e6e0),
                ],
              ),
              // boxShadow: [
              //   BoxShadow(
              //     color: Theme.of(context).brightness == Brightness.dark
              //         ? Colors.black45
              //         : Colors.black26,
              //     offset: const Offset(4, 4),
              //     blurRadius: 8,
              //   ),
              //   BoxShadow(
              //     color: Theme.of(context).brightness == Brightness.dark
              //         ? Colors.grey.shade800
              //         : Colors.white70,
              //     offset: const Offset(-4, -4),
              //     blurRadius: 8,
              //   ),
              // ],
              border: Border.all(
                color: Theme.of(context).colorScheme.secondaryFixed,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        center: const Alignment(-0.3, -0.3),
                        radius: 0.8,
                        colors: [
                          // Highlight
                          Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF40e4c1)
                              : const Color(0xFF9ff2e0),
                          // Mid-tone
                          const Color(0xff13bc91),
                          // Shadow
                          Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF0b5e49)
                              : const Color(0xFF0e9d78),
                        ],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black54
                              : Colors.black26,
                          offset: const Offset(4, 4),
                          blurRadius: 10,
                        ),
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade800
                              : Colors.white70,
                          offset: const Offset(-4, -4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/home/add_route-removebg-preview.png',
                        width: 55,
                        height: 55,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Add Route',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          splashColor: Theme.of(context).colorScheme.secondaryFixed,
          onTap: () {
            Navigator.pushReplacement(
                context, Approutes().linkbusrouteNewscreen);
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF1f1f1f)
                      : const Color(0xFFe0f7f1),
                  Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF0f0f0f)
                      : const Color(0xFFc8e6e0),
                ],
              ),
              // boxShadow: [
              //   BoxShadow(
              //     color: Theme.of(context).brightness == Brightness.dark
              //         ? Colors.black45
              //         : Colors.black26,
              //     offset: const Offset(4, 4),
              //     blurRadius: 8,
              //   ),
              //   BoxShadow(
              //     color: Theme.of(context).brightness == Brightness.dark
              //         ? Colors.grey.shade800
              //         : Colors.white70,
              //     offset: const Offset(-4, -4),
              //     blurRadius: 8,
              //   ),
              // ],
              border: Border.all(
                color: Theme.of(context).colorScheme.secondaryFixed,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        center: const Alignment(-0.3, -0.3),
                        radius: 0.8,
                        colors: [
                          // Highlight
                          Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF40e4c1)
                              : const Color(0xFF9ff2e0),
                          // Mid-tone
                          const Color(0xff13bc91),
                          // Shadow
                          Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF0b5e49)
                              : const Color(0xFF0e9d78),
                        ],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black54
                              : Colors.black26,
                          offset: const Offset(4, 4),
                          blurRadius: 10,
                        ),
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade800
                              : Colors.white70,
                          offset: const Offset(-4, -4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/home/link_route.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Link Bus Route',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          splashColor: Theme.of(context).colorScheme.secondaryFixed,
          onTap: () {
            Navigator.pushReplacement(context, Approutes().tripmasterNewscreen);
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF1f1f1f)
                      : const Color(0xFFe0f7f1),
                  Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF0f0f0f)
                      : const Color(0xFFc8e6e0),
                ],
              ),
              // boxShadow: [
              //   BoxShadow(
              //     color: Theme.of(context).brightness == Brightness.dark
              //         ? Colors.black45
              //         : Colors.black26,
              //     offset: const Offset(4, 4),
              //     blurRadius: 8,
              //   ),
              //   BoxShadow(
              //     color: Theme.of(context).brightness == Brightness.dark
              //         ? Colors.grey.shade800
              //         : Colors.white70,
              //     offset: const Offset(-4, -4),
              //     blurRadius: 8,
              //   ),
              // ],
              border: Border.all(
                color: Theme.of(context).colorScheme.secondaryFixed,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        center: const Alignment(-0.3, -0.3),
                        radius: 0.8,
                        colors: [
                          // Highlight
                          Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF40e4c1)
                              : const Color(0xFF9ff2e0),
                          // Mid-tone
                          const Color(0xff13bc91),
                          // Shadow
                          Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF0b5e49)
                              : const Color(0xFF0e9d78),
                        ],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Theme.of(context).brightness == Brightness.dark
                      //         ? Colors.black54
                      //         : Colors.black26,
                      //     offset: const Offset(4, 4),
                      //     blurRadius: 10,
                      //   ),
                      //   BoxShadow(
                      //     color: Theme.of(context).brightness == Brightness.dark
                      //         ? Colors.grey.shade800
                      //         : Colors.white70,
                      //     offset: const Offset(-4, -4),
                      //     blurRadius: 10,
                      //   ),
                      // ],
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/home/add_trip.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Add Trip',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          splashColor: Theme.of(context).colorScheme.secondaryFixed,
          onTap: () {
            Navigator.pushReplacement(
                context, Approutes().stoppmasterNewscreen);
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF1f1f1f)
                      : const Color(0xFFe0f7f1),
                  Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF0f0f0f)
                      : const Color(0xFFc8e6e0),
                ],
              ),
              // boxShadow: [
              //   BoxShadow(
              //     color: Theme.of(context).brightness == Brightness.dark
              //         ? Colors.black45
              //         : Colors.black26,
              //     offset: const Offset(4, 4),
              //     blurRadius: 8,
              //   ),
              //   BoxShadow(
              //     color: Theme.of(context).brightness == Brightness.dark
              //         ? Colors.grey.shade800
              //         : Colors.white70,
              //     offset: const Offset(-4, -4),
              //     blurRadius: 8,
              //   ),
              // ],
              border: Border.all(
                color: Theme.of(context).colorScheme.secondaryFixed,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        center: const Alignment(-0.3, -0.3),
                        radius: 0.8,
                        colors: [
                          // Highlight
                          Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF40e4c1)
                              : const Color(0xFF9ff2e0),
                          // Mid-tone
                          const Color(0xff13bc91),
                          // Shadow
                          Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF0b5e49)
                              : const Color(0xFF0e9d78),
                        ],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black54
                              : Colors.black26,
                          offset: const Offset(4, 4),
                          blurRadius: 10,
                        ),
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade800
                              : Colors.white70,
                          offset: const Offset(-4, -4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/home/add_stop.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Add Stop',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          splashColor: Theme.of(context).colorScheme.secondaryFixed,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ScreenConductor(flag: 0),
              ),
            );
            Navigator.pushReplacement(context, Approutes().employeescreen);
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF1f1f1f)
                      : const Color(0xFFe0f7f1),
                  Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF0f0f0f)
                      : const Color(0xFFc8e6e0),
                ],
              ),
              // boxShadow: [
              //   BoxShadow(
              //     color: Theme.of(context).brightness == Brightness.dark
              //         ? Colors.black45
              //         : Colors.black26,
              //     offset: const Offset(4, 4),
              //     blurRadius: 8,
              //   ),
              //   BoxShadow(
              //     color: Theme.of(context).brightness == Brightness.dark
              //         ? Colors.grey.shade800
              //         : Colors.white70,
              //     offset: const Offset(-4, -4),
              //     blurRadius: 8,
              //   ),
              // ],
              border: Border.all(
                color: Theme.of(context).colorScheme.secondaryFixed,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        center: const Alignment(-0.3, -0.3),
                        radius: 0.8,
                        colors: [
                          // Highlight
                          Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF40e4c1)
                              : const Color(0xFF9ff2e0),
                          // Mid-tone
                          const Color(0xff13bc91),
                          // Shadow
                          Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF0b5e49)
                              : const Color(0xFF0e9d78),
                        ],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black54
                              : Colors.black26,
                          offset: const Offset(4, 4),
                          blurRadius: 10,
                        ),
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade800
                              : Colors.white70,
                          offset: const Offset(-4, -4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/home/conductor.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Add Employee',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
