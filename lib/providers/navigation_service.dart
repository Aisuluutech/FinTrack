import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class NavigationService {
  GlobalKey <NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  Future <Future <Object?>> push (Widget page) async {
    return navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => page));
  }

  void pop () {
    navigatorKey.currentState?.pop();
  }
}

final navigationProvider = Provider<NavigationService>((ref) {
  return NavigationService();
});


