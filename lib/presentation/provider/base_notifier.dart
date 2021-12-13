import 'package:flutter/foundation.dart';

enum AppState { idle, busy }

class BaseNotifier extends ChangeNotifier {
  AppState _state = AppState.idle;

  void setState(AppState newState) {
    _state = newState;
    notifyListeners();
  }

  void resetState() {
    _state = AppState.busy;
  }

  void setStateBusy() {
    _state = AppState.busy;
    notifyListeners();
  }

  void setStateIdle() {
    _state = AppState.idle;
    notifyListeners();
  }

  void refreshState() {
    notifyListeners();
  }

  bool get isStateBusy => _state != AppState.idle;
}
