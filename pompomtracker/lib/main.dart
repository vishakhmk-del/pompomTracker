import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/provider/loading/loading_provider.dart';

const savekeyname = 'UserLoggedIn';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider<LoadingProvider>(
              create: (context) => LoadingProvider()),
      ChangeNotifierProvider<ThemeProvider>(
        create: (context) => ThemeProvider(),
        builder: (context,child) {
          final themeProvider=Provider.of<ThemeProvider>(context);
          return MaterialApp(
            title: 'PomPomTracker',
            themeMode: themeProvider.themeMode,
            theme: themeProvider.lightScheme,
            darkTheme: themeProvider.darkScheme,
            home: const ScreenSplash(),
          );
        },
        
     ),
   ]    
  );
}
