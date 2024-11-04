import 'package:flutter/material.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  dynamic _dataListTileComponentActionParameter;
  dynamic get dataListTileComponentActionParameter =>
      _dataListTileComponentActionParameter;
  set dataListTileComponentActionParameter(dynamic value) {
    _dataListTileComponentActionParameter = value;
  }

  dynamic _userListTileComponentActionParameter;
  dynamic get userListTileComponentActionParameter =>
      _userListTileComponentActionParameter;
  set userListTileComponentActionParameter(dynamic value) {
    _userListTileComponentActionParameter = value;
  }
}
