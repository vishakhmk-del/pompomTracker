import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  TTSService._();
  static final TTSService instance = TTSService._();

  final FlutterTts _tts = FlutterTts();
  bool _initialized = false;
  bool _isSpeaking = false;

  Future<void> initialize() async {
    if (_initialized) return;

    await _tts.setLanguage("en-IN");
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.0);
    await _tts.setVolume(1.0);

    // Set to false to avoid blocking location loop execution
    await _tts.awaitSpeakCompletion(false);

    _tts.setStartHandler(() => _isSpeaking = true);
    _tts.setCompletionHandler(() => _isSpeaking = false);
    _tts.setErrorHandler((_) => _isSpeaking = false);

    _initialized = true;
  }
// Future<void> initialize() async {
//   if (_initialized) return;

//   try {
//     final engines = await _tts.getEngines;
//     print("TTS Engines: $engines");

//     final languages = await _tts.getLanguages;
//     print("TTS Languages: $languages");
//   } catch (e) {
//     print("TTS Exception: $e");
//   }

//   await _tts.setLanguage("en-IN");
//   await _tts.setSpeechRate(0.45);
//   await _tts.setPitch(1.0);
//   await _tts.setVolume(1.0);

//   await _tts.awaitSpeakCompletion(false);

//   _tts.setStartHandler(() {
//     _isSpeaking = true;
//     print("TTS Started");
//   });

//   _tts.setCompletionHandler(() {
//     _isSpeaking = false;
//     print("TTS Completed");
//   });

//   _tts.setErrorHandler((msg) {
//     _isSpeaking = false;
//     print("TTS Error: $msg");
//   });

//   _initialized = true;
// }
  Future<void> speak(String message) async {
    await initialize();
    if (message.trim().isEmpty || _isSpeaking) return;
    await _tts.speak(message);
  }

  Future<void> nextStop(String stopName) async {
    await speak("Attention please. Next stop is $stopName.");
  }

  Future<void> arriving(String stopName) async {
    await speak("Now arriving at $stopName.");
  }

  Future<void> welcome() async {
    await speak("Welcome aboard. Have a pleasant journey.");
  }

  Future<void> thankYou() async {
    await speak("Thank you for travelling with us.");
  }

  Future<void> stop() async {
    await _tts.stop();
    _isSpeaking = false;
  }
}
