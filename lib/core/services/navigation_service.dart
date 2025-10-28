import 'package:loop/export.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext? get context => navigatorKey.currentContext;

  String? get currentRoute {
    final route = navigatorKey.currentState;
    if (route != null) {
      return route.toString().split(' ').last.replaceAll("'", "");
    }
    return null;
  }

  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    if (navigatorKey.currentState == null) {
      print('Navigator state is null');
      return Future.value();
    }
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> navigateReplacement(String routeName, {Object? arguments}) {
    if (navigatorKey.currentState == null) {
      print('Navigator state is null');
      return Future.value();
    }
    return navigatorKey.currentState!.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> navigateAndRemoveUntil(String routeName, {Object? arguments}) {
    if (navigatorKey.currentState == null) {
      print('Navigator state is null');
      return Future.value();
    }
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  void goBack() {
    if (navigatorKey.currentState?.canPop() == true) {
      navigatorKey.currentState!.pop();
    }
  }

  void goBackWithResult(dynamic result) {
    if (navigatorKey.currentState?.canPop() == true) {
      navigatorKey.currentState!.pop(result);
    }
  }

  bool canPop() {
    return navigatorKey.currentState?.canPop() ?? false;
  }

  void popUntil(String routeName) {
    navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
  }

  // Helper method to show dialogs without context
  Future<T?> showDialog<T>({
    required WidgetBuilder builder,
    bool barrierDismissible = true,
  }) {
    final context = navigatorKey.currentContext;
    if (context == null) {
      print('Context is null - cannot show dialog');
      return Future.value();
    }
    
    return showGeneralDialog<T>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  // Helper method to show snackbar without context
  void showSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
  }) {
    final context = navigatorKey.currentContext;
    if (context == null) {
      print('Context is null - cannot show snackbar');
      return;
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}