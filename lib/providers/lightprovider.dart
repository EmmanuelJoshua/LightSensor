import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:light/light.dart';

class LightProvider extends ChangeNotifier {
  Light _light;
  StreamSubscription _subscription;
  int _luxValue = 0;

  int get luxValue => _luxValue;

  void onData(int luxValue) async {
    _luxValue = luxValue;
    notifyListeners();
  }

  void stopListening() {
    _subscription.cancel();
  }

  void startListening() {
    _light = new Light();
    try {
      _subscription = _light.lightSensorStream.listen(onData);
    } on LightException catch (exception) {
      print(exception);
    }
  }

  String getEquivalent(int luxValue) {
    if (luxValue >= 32000) {
      return 'Direct Sunlight';
    } else if (luxValue >= 10000) {
      return 'Full Daylight';
    } else if (luxValue >= 1000) {
      return 'Overcast Day';
    } else if (luxValue >= 400) {
      return 'Clear Day';
    } else if (luxValue >= 320) {
      return 'Office Lighting';
    } else if (luxValue >= 150) {
      return 'Train Station';
    } else if (luxValue >= 100) {
      return 'Dark Overcast Day';
    } else if (luxValue >= 80) {
      return 'Office Building Hallway';
    } else if (luxValue >= 50) {
      return 'Dark Public Area';
    } else if (luxValue >= 3) {
      return 'Dark';
    } else {
      return 'Very Dark';
    }
  }

  Color getColors(int luxValue){
    if (luxValue >= 32000) {
      return Color(0xFF123232);
    } else if (luxValue >= 10000) {
      return Color(0xFF123232);
    } else if (luxValue >= 1000) {
      return Color(0xFF123232);
    } else if (luxValue >= 400) {
      return Color(0xFF123232);
    } else if (luxValue >= 320) {
      return Color(0xFF123232);
    } else if (luxValue >= 150) {
      return Color(0xFF123232);
    } else if (luxValue >= 100) {
      return Color(0xFF123232);
    } else if (luxValue >= 80) {
      return Color(0xFF123232);
    } else if (luxValue >= 50) {
      return Color(0xFF123232);
    } else if (luxValue >= 3) {
      return Color(0xFF12A436);
    } else {
      return Color(0xFF131C3B);
    }
  }
}
