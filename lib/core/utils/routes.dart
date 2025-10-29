import 'package:flutter/material.dart';
import 'package:loop/features/category/category_screen.dart';
import 'package:loop/features/category/initial_screen.dart';
import 'package:loop/features/profile/screens/splash_screen.dart';

class RouteConfig {
  final String name;
  final Widget Function() page;
  final RouteTransitionsBuilder? transitionBuilder;
  final Duration? transitionDuration;
  final bool isOffAll;

  const RouteConfig({
    required this.name,
    required this.page,
    this.transitionBuilder,
    this.transitionDuration,
    this.isOffAll = false,
  });
}

class AppLinks {
  static const splash = '/splash_screen';
  static const initial = '/initial';
  static const leaguescategory = '/leaguescategory';
  static const home = '/home'; // Added home screen
}

class AppRoutes {
  static final Map<String, RouteConfig> _routeConfigs = {
    AppLinks.splash: RouteConfig(
      name: AppLinks.splash,
      page: () => SplashScreen(),
      transitionBuilder: _fadeTransitionBuilder,
      transitionDuration: const Duration(milliseconds: 600),
      isOffAll: true,
    ),
    AppLinks.initial: RouteConfig(
      name: AppLinks.initial,
      page: () => InitialScreen(),
      transitionBuilder: _circularRevealTransitionBuilder,
      transitionDuration: const Duration(milliseconds: 500),
      isOffAll: false,
    ),
    AppLinks.leaguescategory: RouteConfig(
      name: AppLinks.leaguescategory,
      page: () => LeaguesCategoryScreen(),
      transitionBuilder: _fadeTransitionBuilder,
      transitionDuration: const Duration(milliseconds: 500),
      isOffAll: false,
    ),
    // AppLinks.home: RouteConfig(
    //   name: AppLinks.home,
    //   page: () => HomeScreen(), // Make sure you have this widget
    //   transitionBuilder: _fadeTransitionBuilder,
    //   transitionDuration: const Duration(milliseconds: 500),
    //   isOffAll: false,
    // ),
  };

  // Transition builders
  static Widget _fadeTransitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  static Widget _circularRevealTransitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        ),
      ),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  // Generate route for MaterialApp
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final routeName = settings.name;
    final config = _routeConfigs[routeName];

    if (config == null) {
      return _errorRoute();
    }

    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => config.page(),
      transitionDuration: config.transitionDuration ?? const Duration(milliseconds: 300),
      transitionsBuilder: config.transitionBuilder ?? _fadeTransitionBuilder,
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Page not found!'),
        ),
      ),
    );
  }

  static RouteConfig? getRouteConfig(String routeName) {
    return _routeConfigs[routeName];
  }

  static bool hasRoute(String routeName) {
    return _routeConfigs.containsKey(routeName);
  }

  static List<String> get routeNames => _routeConfigs.keys.toList();
}

// Centralized Navigation Helper
class Navigate {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  static BuildContext? get context => navigatorKey.currentContext;
  
  static bool get canPop => navigatorKey.currentState?.canPop() ?? false;

  // Main navigation method
  static Future<T?> to<T>(
    String routeName, {
    Map<String, dynamic>? arguments,
    bool isOffAll = false,
  }) async {
    if (navigatorKey.currentState == null) {
      print('Navigator state is null');
      return null;
    }

    final config = AppRoutes.getRouteConfig(routeName);
    if (config == null) {
      print('Route $routeName not found!');
      return null;
    }

    final useOffAll = isOffAll || config.isOffAll;

    if (useOffAll) {
      return await navigatorKey.currentState!.pushAndRemoveUntil<T>(
        _createRoute(routeName, config),
        (route) => false,
      );
    } else {
      return await navigatorKey.currentState!.push<T>(
        _createRoute(routeName, config),
      );
    }
  }

  // Direct screen navigation methods
  static Future<T?> toSplash<T>() => to<T>(AppLinks.splash, isOffAll: true);
  static Future<T?> toInitial<T>() => to<T>(AppLinks.initial);
  static Future<T?> toLeaguesCategory<T>() => to<T>(AppLinks.leaguescategory);
  static Future<T?> toHome<T>() => to<T>(AppLinks.home);

  // Remove all and go to specific screen
  static Future<T?> offAllTo<T>(String routeName, {Map<String, dynamic>? arguments}) {
    return to<T>(routeName, arguments: arguments, isOffAll: true);
  }

  // Go back
  static void back<T>([T? result]) {
    if (canPop) {
      navigatorKey.currentState!.pop<T>(result);
    }
  }

  // Go back until specific route
  static void backUntil(String routeName) {
    navigatorKey.currentState!.popUntil((route) => route.settings.name == routeName);
  }

  // Go back to home
  static void backToHome() {
    if (AppRoutes.hasRoute(AppLinks.home)) {
      backUntil(AppLinks.home);
    } else {
      backUntil(AppLinks.initial);
    }
  }

  // Replace current screen
  static Future<T?> replace<T>(String routeName, {Map<String, dynamic>? arguments}) {
    back();
    return to<T>(routeName, arguments: arguments);
  }

  // Safe navigation with context check
  static Future<T?> safeTo<T>(
    BuildContext context,
    String routeName, {
    Map<String, dynamic>? arguments,
    bool isOffAll = false,
  }) {
    if (!context.mounted) return Future.value(null);
    return to<T>(routeName, arguments: arguments, isOffAll: isOffAll);
  }

  // Create route with proper configuration
  static Route<T> _createRoute<T>(String routeName, RouteConfig config) {
    return PageRouteBuilder<T>(
      settings: RouteSettings(name: routeName),
      pageBuilder: (context, animation, secondaryAnimation) => config.page(),
      transitionDuration: config.transitionDuration ?? const Duration(milliseconds: 300),
      transitionsBuilder: config.transitionBuilder ?? _defaultTransitionBuilder,
    );
  }

  static Widget _defaultTransitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}

// Usage in your MaterialApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loop App',
      navigatorKey: Navigate.navigatorKey,
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: AppLinks.splash,
      debugShowCheckedModeBanner: false,
    );
  }
}


// // From your buttons:
// MyButton(
//   buttonText: 'Start Following',
//   onTap: () {
//     Navigate.toLeaguesCategory(); // Simple one-liner
//   },
// ),

// // Other usage examples:
// ElevatedButton(
//   onPressed: () => Navigate.toInitial(), // Go to initial screen
//   child: Text('Go to Initial'),
// ),

// ElevatedButton(
//   onPressed: () => Navigate.toSplash(), // Go to splash (clears all screens)
//   child: Text('Go to Splash'),
// ),

// ElevatedButton(
//   onPressed: () => Navigate.back(), // Go back
//   child: Text('Back'),
// ),

// ElevatedButton(
//   onPressed: () => Navigate.offAllTo(AppLinks.home), // Clear all and go to home
//   child: Text('Go Home'),
// ),