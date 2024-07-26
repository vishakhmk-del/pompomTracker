
import 'package:pompomtracker/core/hook/hook.dart';


class ScreenSplash extends StatelessWidget {
  const ScreenSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end:Alignment.bottomRight,
          colors: [Colors.orange.shade100,Colors.orange]
          )
      ),
        child: Center(
          child: Lottie.asset('assets/animatedsplash/Animation - bus.json',
          width: MediaQuery.of(context).size.width/1.8,
          //height: MediaQuery.of(context).size.height/2
          ),
        ),
      );
      
  }
}
