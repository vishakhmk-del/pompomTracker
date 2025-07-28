import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/provider/iconChange/iconChangeProvider.dart';
import 'package:sizer/sizer.dart';
const savekeyname = 'UserLoggedIn';
const savedeviceinfo = '_userDeviceIn';
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
        ChangeNotifierProvider<RadiobuttonProvider>(
            create: (context) => RadiobuttonProvider()),
        ChangeNotifierProvider<CollectionDrpDwnProvider>(
            create: (context) => CollectionDrpDwnProvider()),
        ChangeNotifierProvider<CashstmntDrpDwnProvider>(
            create: (context) => CashstmntDrpDwnProvider()),
        ChangeNotifierProvider<ElevatedBtnProvider>(
            create: (context) => ElevatedBtnProvider()),
        ChangeNotifierProvider<CheckProvider>(
            create: (context) => CheckProvider()),
        ChangeNotifierProvider<DropdownProvider>(
            create: (context) => DropdownProvider()),
        ChangeNotifierProvider<IconChangeProvider>(
            create: (context) => IconChangeProvider()),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
          builder: (context, child) {
            final themeProvider = Provider.of<ThemeProvider>(context);
            return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.noScaling),
            child: Sizer(
              builder: (context, orientation, screenType) {
                return MaterialApp(
                title: 'PomPomTracker',
                themeMode: themeProvider.themeMode,
                theme: themeProvider.lightScheme,
                darkTheme: themeProvider.darkScheme,
                home: const ScreenSplash(),
              );
              }
            ),
            );
          },
        ),
      ]);
}
