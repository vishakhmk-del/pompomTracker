import 'package:pompomtracker/core/hook/hook.dart';

class MyTheme {
  static final darkTheme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme:const ColorScheme.light(),
  );

  static final lightTheme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: Colors.white,
    colorScheme:const ColorScheme.light()
    );
}