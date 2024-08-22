import 'package:flutter/material.dart';
import 'package:pompomtracker/core/hook/hook.dart';

const primaryColor = Colors.purple;
const secondaryColor = Color.fromARGB(255, 65, 10, 243);

class MyTheme {
  static final lightTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      // colorScheme: const ColorScheme.light(),
      brightness: Brightness.light,
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.light(
        primary: Color(0xff13bc91),
        onPrimary: Colors.white,
        secondary: Color(0xff12b2ba),
        onSecondary: Colors.black,
        primaryContainer: Color(0xFF5FE0BF),
      ),
      textTheme: const TextTheme(
          labelSmall: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Poppins-Medium'),
          bodySmall: TextStyle(
              color: Colors.black, fontSize: 14, fontFamily: 'Poppins-Medium'),
          titleSmall: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Poppins-Medium'),
          titleMedium: TextStyle(
              color: Colors.white, fontSize: 16, fontFamily: 'Poppins-Medium'),
          titleLarge: TextStyle(
              color: Colors.black54,
              fontSize: 20,
              fontFamily: 'Poppins-Medium')));

  static final darkTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.grey.shade900,
      // colorScheme: const ColorScheme.light(),
      brightness: Brightness.dark,
      primaryColor: secondaryColor,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xff13bc91),
        onPrimary: Colors.white,
        secondary: Color(0xff12b2ba),
        onSecondary: Colors.white,
        primaryContainer: Color(0xFF5FE0BF),
      ),
      textTheme: const TextTheme(
          labelSmall: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Poppins-Medium'),
          bodySmall: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Poppins-Medium'),
          titleSmall: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Poppins-Medium'),
          titleMedium: TextStyle(
              color: Colors.white, fontSize: 16, fontFamily: 'Poppins-Medium'),
          titleLarge: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins-Medium')));

  //common theme
  static ThemeData get googleFormTheme => ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE1E1E1), width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE1E1E1), width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE1E1E1), width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE1E1E1), width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
      );
  static ThemeData get buttonStyleTheme => ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      )));
  static ThemeData get appIconTheme => ThemeData(
          iconTheme: const IconThemeData(
        color: Colors.white,
        size: 20,
      ));
}
// appBarTheme: const AppBarTheme(
//       backgroundColor: Colors.green,
//       shadowColor: Colors.transparent,
//       elevation: 0.0,
//       centerTitle: false,
//       scrolledUnderElevation: 10.0,
//       toolbarHeight: 72.0,
//       titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.normal),
//     // round corners
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
//       ),
//     // icons button theme
//       actionsIconTheme: IconThemeData(color: Colors.white, size: 16.0),
//     )
// elevatedButtonTheme: ElevatedButtonThemeData(
//   // style: ButtonStyle(
//   // padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
//   // ),
//   // shape: WidgetStateProperty.all(RoundedRectangleBorder(
//   //   borderRadius: BorderRadius.circular(20)
//   // )),
//   // backgroundColor: WidgetStateProperty.all(primaryColor),
//   // ),
//   style: ElevatedButton.styleFrom(
//       elevation: 8.0,
//       shadowColor: Colors.green,
//     // define min size of the button in theme
//       minimumSize: const Size(double.infinity, 56.0),
//       backgroundColor: Colors.green,
//       disabledBackgroundColor: Colors.green.withOpacity(0.4),
//       disabledForegroundColor: Colors.grey,
//       padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
//       textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//     ),
// ),
// textTheme:const TextTheme(
//   titleSmall:  TextStyle(
//     color: Colors.white,
//     fontSize: 12,
//     fontFamily: 'Poppins-Medium'
//   ),
//   titleMedium:  TextStyle(
//     color: Colors.white,
//     fontSize: 16,
//     fontFamily: 'Poppins-Medium'
//   ),
//   titleLarge:  TextStyle(
//     color: Colors.white,
//     fontSize: 20,
//     fontFamily: 'Poppins-Medium'
//   )
// )
