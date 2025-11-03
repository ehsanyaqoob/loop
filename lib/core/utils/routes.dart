import 'package:flutter/material.dart';
import 'package:loop/core/models/league_model.dart';
import 'package:loop/features/category/category_screen.dart';
import 'package:loop/features/category/leagues_details_screen.dart';
import 'package:loop/features/profile/screens/splash_screen.dart';

class AppLinks {
  static const splash = '/splash';
  static const leaguesCategory = '/leagues-category';
  static const leaguesDetails = '/leagues-details';
}

enum TransitionType {
  fade,
  slideLeft,
  slideRight,
  slideUp,
  slideDown,
  scale,
  rotate,
}

class RouteConfig {
  final String name;
  final Widget Function(Object? args) page;
  final TransitionType transition;
  final Duration duration;
  final bool offAll;
  const RouteConfig({
    required this.name,
    required this.page,
    this.transition = TransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.offAll = false,
  });
}

class AppLogger {
  static void log(String icon, String msg) {
    final t = DateTime.now().toIso8601String();
    debugPrint("\x1B[32m$icon [$t] $msg\x1B[0m");
  }

  static void open(String r, Object? a) => log("➡️", "OPEN $r args:$a");

  static void push(String r, Object? a) => log("🎯", "PUSH $r args:$a");

  static void offAll(String r, Object? a) => log("🧹", "OFF_ALL $r args:$a");

  static void back() => log("⬅️", "BACK");

  static void appStart(String r) => log("🚀", "APP_START $r");
}

class AppRoutes {
  static final routes = {
    AppLinks.splash: RouteConfig(
      name: AppLinks.splash,
      page: (_) => const SplashScreen(),
      offAll: true,
      transition: TransitionType.fade,
      duration: Duration(milliseconds: 300),
    ),
    AppLinks.leaguesCategory: RouteConfig(
      name: AppLinks.leaguesCategory,
      page: (_) => const LeaguesCategoryScreen(),
      transition: TransitionType.slideLeft,
      duration: Duration(milliseconds: 300),
    ),
    AppLinks.leaguesDetails: RouteConfig(
      name: AppLinks.leaguesDetails,
      page: (args) => LeagueDetailsScreen(league: args as League),
      transition: TransitionType.slideUp,
      duration: Duration(milliseconds: 300),
    ),
  };

  static Route<dynamic> generate(RouteSettings settings) {
    final c = routes[settings.name];
    if (c == null) {
      return MaterialPageRoute(
        builder: (_) =>
            const Scaffold(body: Center(child: Text("Route not found"))),
      );
    }

    AppLogger.open(settings.name ?? "", settings.arguments);

    return PageRouteBuilder(
      settings: settings,
      transitionDuration: c.duration,
      pageBuilder: (_, a, __) => c.page(settings.arguments),
      transitionsBuilder: (_, anim, __, child) {
        switch (c.transition) {
          case TransitionType.fade:
            return FadeTransition(opacity: anim, child: child);
          case TransitionType.slideLeft:
            return SlideTransition(
              position: Tween(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(anim),
              child: child,
            );
          case TransitionType.slideRight:
            return SlideTransition(
              position: Tween(
                begin: const Offset(-1, 0),
                end: Offset.zero,
              ).animate(anim),
              child: child,
            );
          case TransitionType.slideUp:
            return SlideTransition(
              position: Tween(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(anim),
              child: child,
            );
          case TransitionType.slideDown:
            return SlideTransition(
              position: Tween(
                begin: const Offset(0, -1),
                end: Offset.zero,
              ).animate(anim),
              child: child,
            );
          case TransitionType.scale:
            return ScaleTransition(scale: anim, child: child);
          case TransitionType.rotate:
            return RotationTransition(turns: anim, child: child);
        }
      },
    );
  }
}

class Navigate {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext? get context => navigatorKey.currentContext;

  static Future<T?> to<T>(String r, {Object? arguments}) {
    final config = AppRoutes.routes[r];
    if (config?.offAll == true) return offAll(r, arguments: arguments);
    AppLogger.push(r, arguments);
    final nav = navigatorKey.currentState;
    return nav == null
        ? Future.value(null)
        : nav.pushNamed(r, arguments: arguments);
  }

  static Future<T?> offAll<T>(String r, {Object? arguments}) {
    AppLogger.offAll(r, arguments);
    final nav = navigatorKey.currentState;
    return nav == null
        ? Future.value(null)
        : nav.pushNamedAndRemoveUntil(r, (_) => false, arguments: arguments);
  }

  static void back<T>([T? result]) {
    AppLogger.back();
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop(result);
    }
  }

  static void startApp() {
    AppLogger.appStart(AppLinks.splash);
    offAll(AppLinks.splash);
  }
}

// Navigate.offAll(AppLinks.leaguesCategory);
// Navigate.to(AppLinks.leaguesDetails, arguments: league);
// 🚀 APP_START /splash
// ➡️ OPEN /splash args:none
// ⬅️ BACK
// 🎯 PUSH /leagues-category args:none
