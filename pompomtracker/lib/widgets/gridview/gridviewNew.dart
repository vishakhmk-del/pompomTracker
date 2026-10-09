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
        SettingsGridWidget(
          title: 'Add Bus',
          imageUrl: 'assets/home/bus_ad.png',
          onTap: () {
            Navigator.pushReplacement(context, Approutes().busmasternewscreen);
          },
        ),
        // SettingsGridWidget(
        //   title: 'Add Route',
        //   imageUrl: 'assets/home/add_route-removebg-preview.png',
        //   onTap: () {
        //     Navigator.pushReplacement(
        //         context, Approutes().routemasterNewscreen);
        //   },
        // ),
        SettingsGridWidget(
          title: 'Permit Bus Link',
          imageUrl: 'assets/home/link_route.png',
          onTap: () {
            Navigator.pushReplacement(
                context, Approutes().linkbusrouteNewscreen);
          },
        ),

        // SettingsGridWidget(
        //   title: 'Add Trip',
        //   imageUrl: 'assets/home/add_trip.png',
        //   onTap: () {
        //     Navigator.pushReplacement(context, Approutes().tripmasterNewscreen);
        //   },
        // ),
        // SettingsGridWidget(
        //   title: 'Add Stop',
        //   imageUrl: 'assets/home/add_stop.png',
        //   onTap: () {
        //     Navigator.pushReplacement(
        //         context, Approutes().stoppmasterNewscreen);
        //   },
        // ),
        SettingsGridWidget(
          title: 'Add Employee',
          imageUrl: 'assets/home/conductor.png',
          onTap: () {
            Navigator.pushReplacement(context, Approutes().employeescreen);
          },
        ),
        // SettingsGridWidget(
        //   title: 'Documents',
        //   imageUrl: 'assets/doc/document.png',
        //   onTap: () {
        //     Navigator.pushReplacement(context, Approutes().docScreen);
        //   },
        // ),
        // SettingsGridWidget(
        //   title: 'Wallet',
        //   imageUrl: 'assets/wallet/wallet.png',
        //   onTap: () {
        //     Navigator.pushReplacement(context, Approutes().wallet);
        //   },
        // ),
        // Stack(
        //   children: [
        //     SettingsGridWidget(
        //       title: 'Wallet',
        //       imageUrl: 'assets/wallet/wallet.png',
        //       onTap: () {
        //         //     Navigator.pushReplacement(context, Approutes().wallet);
        //       },
        //     ),
        //     Positioned(
        //       top: 10,
        //       right: 10,
        //       child: Container(
        //         padding: const EdgeInsets.symmetric(
        //           horizontal: 8,
        //           vertical: 4,
        //         ),
        //         decoration: BoxDecoration(
        //           color: Colors.orange,
        //           borderRadius: BorderRadius.circular(8),
        //         ),
        //         child: const Text(
        //           'COMING SOON',
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 9,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

class SettingsGridWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const SettingsGridWidget({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryFixedColor = Theme.of(context).colorScheme.secondaryFixed;

    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFe0f7f1),
            const Color(0xFFc8e6e0),
          ],
        ),
        border: Border.all(
          color: secondaryFixedColor,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          splashColor: secondaryFixedColor,
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                        isDark
                            ? const Color(0xFF40e4c1)
                            : const Color(0xFF9ff2e0),
                        // Mid-tone
                        const Color(0xff13bc91),
                        // Shadow
                        isDark
                            ? const Color(0xFF0b5e49)
                            : const Color(0xFF0e9d78),
                      ],
                      stops: const [0.0, 0.6, 1.0],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: const Offset(4, 4),
                        blurRadius: 10,
                      ),
                      BoxShadow(
                        color: Colors.white70,
                        offset: const Offset(-4, -4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.black, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
