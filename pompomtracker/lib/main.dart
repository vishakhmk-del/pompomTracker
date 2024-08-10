import 'package:pompomtracker/core/hook/hook.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'PomPomTracker',
          themeMode: themeProvider.themeMode,
          theme: themeProvider.lightScheme,
          darkTheme: themeProvider.darkScheme,
          home: const ScreenSplash(),
        );
      }));
}
