import 'package:pompomtracker/core/hook/hook.dart';

class BackgroundGradient extends StatelessWidget {
  const BackgroundGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff00c7c8),
            Color(0xff0077C8),
          ],
        ),
      ),
    );
  }
}
