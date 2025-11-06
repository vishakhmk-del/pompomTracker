import 'package:intl/intl.dart';
class TimeConvertFun{
  TimeConvertFun._internal();
  static TimeConvertFun instance = TimeConvertFun._internal();
  TimeConvertFun factory() {
    return instance;
  }
String formatTo12Hour(String? time) {
  if (time == null || time.isEmpty) return "";

  try {
    // parse "HH:mm" (e.g., "17:45")
    final parsed = DateFormat("HH:mm").parse(time);
    // format as "hh:mm a" (e.g., "05:45 PM")
    return DateFormat("hh:mm a").format(parsed);
  } catch (e) {
    return time; // fallback: return original if parse fails
  }
}

String formatTo24Hour(String? time) {
  if (time == null || time.isEmpty) return "";
  try {
    final parsed = DateFormat("hh:mm a").parse(time); // parse "05:30 PM"
    return DateFormat("HH:mm").format(parsed);        // convert to "17:30"
  } catch (e) {
    return time; // fallback
  }
}

}

