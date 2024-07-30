import 'package:pompomtracker/core/hook/hook.dart';

class BackgroundColorGradient extends StatelessWidget {
  const BackgroundColorGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.orange.shade50, Colors.orange])),
    );
  }
}
