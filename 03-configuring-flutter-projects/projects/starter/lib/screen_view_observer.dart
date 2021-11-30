import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routemaster/routemaster.dart';

typedef ScreenNameExtractor = String? Function(RouteSettings settings);

String? defaultNameExtractor(RouteSettings settings) => settings.name;

class ScreenViewObserver extends RoutemasterObserver {
  ScreenViewObserver({
    this.nameExtractor = defaultNameExtractor,
    Function(PlatformException error)? onError,
  });

  final ScreenNameExtractor nameExtractor;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
    }
  }

  @override
  void didChangeRoute(RouteData routeData, Page page) {}

  void _sendScreenView(PageRoute<dynamic> route) {
    final String? screenName = nameExtractor(route.settings);
    if (screenName != null) {
      //TO-DO add analytics
    }
  }
}
