

class FFLibraryValues {
  static FFLibraryValues _instance = FFLibraryValues._internal();

  factory FFLibraryValues() {
    return _instance;
  }

  FFLibraryValues._internal();

  static void reset() {
    _instance = FFLibraryValues._internal();
  }

  String? databaseURL = 'https://withcenter-test-4-default-rtdb.firebaseio.com';
  bool? debugLog = true;
  bool? onlyVerifiedUserSendMessage = false;
}
