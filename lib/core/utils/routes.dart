
import 'package:loop/features/intials/intial_screen.dart';
import 'package:loop/features/profile/presentation/screens/splash_screen.dart';
import 'package:loop/export.dart';

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
  static const auth = '/auth';
  static const home = '/home';
  static const navbar = '/navbar';
  static const scan = '/scan';
  static const diary = '/diary';
  static const progress = '/progress';
  static const rewards = '/rewards';
  static const menu = '/menu';
  static const profile = '/profile';
  static const notify = '/notify';
  static const bookmark = '/bookmark';
  static const settings = '/settings';
  static const foodDetail = '/food_detail';
  static const mealPlan = '/meal_plan';
  // NEW: Menu Screen Routes
  static const editProfile = '/edit_profile';
  static const security = '/security';
  static const privacyPolicy = '/privacy_policy';
  static const helpCenter = '/help_center';
  static const inviteFriends = '/invite_friends';
  static const scannscreen = '/scanscreen';
  static const daymealsscreen = '/daymealscreen';
  static const chataiscreen = '/chataiscreen';
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
  page: () =>  InitialScreen(), // Make sure this widget exists
  transitionBuilder: _circularRevealTransitionBuilder,
  transitionDuration: const Duration(milliseconds: 500),
  isOffAll: false,
),

    // AppLinks.onboard: RouteConfig(
    //   name: AppLinks.onboard,
    //   page: () => OnboardingView(),
    //   transitionBuilder: _circularRevealTransitionBuilder,
    //   transitionDuration: const Duration(milliseconds: 500),
    //   isOffAll: false,
    // ),
    
    // AppLinks.auth: RouteConfig(
    //   name: AppLinks.auth,
    //   page: () => AuthScreen(),
    //   transitionBuilder: _circularRevealTransitionBuilder,
    //   transitionDuration: const Duration(milliseconds: 500),
    //   isOffAll: false,
    // ),

    // AppLinks.home: RouteConfig(
    //   name: AppLinks.home,
    //   page: () => HomeScreen(),
    //   transitionBuilder: _circularRevealTransitionBuilder,
    //   transitionDuration: const Duration(milliseconds: 600),
    //   isOffAll: true,
    // ),
    
    // AppLinks.navbar: RouteConfig(
    //   name: AppLinks.navbar,
    //   page: () => NutriNavBar(),
    //   transitionBuilder: _circularRevealTransitionBuilder,
    //   transitionDuration: const Duration(milliseconds: 600),
    //   isOffAll: true,
    // ),

    // AppLinks.notify: RouteConfig(
    //   name: AppLinks.notify,
    //   page: () => NotificationScreen(),
    //   transitionBuilder: _leftToRightTransitionBuilder,
    //   transitionDuration: const Duration(milliseconds: 600),
    //   isOffAll: false,
    // ),

    // AppLinks.bookmark: RouteConfig(
    //   name: AppLinks.bookmark,
    //   page: () => BookMarkScreen(),
    //   transitionBuilder: _leftToRightTransitionBuilder,
    //   transitionDuration: const Duration(milliseconds: 600),
    //   isOffAll: false,
    // ),

    // AppLinks.scan: RouteConfig(
    //   name: AppLinks.scan,
    //   page: () => ScanScreen(),
    //   transitionBuilder: _cupertinoTransitionBuilder,
    //   transitionDuration: const Duration(milliseconds: 450),
    // ),
    
    // AppLinks.progress: RouteConfig(
    //   name: AppLinks.progress,
    //   page: () => ProgressScreen(),
    //   transitionBuilder: _cupertinoTransitionBuilder,
    //   transitionDuration: const Duration(milliseconds: 450),
    // ),
    
    // AppLinks.rewards: RouteConfig(
    //   name: AppLinks.rewards,
    //   page: () => MealScreen(),
    //   transitionBuilder: _cupertinoTransitionBuilder,
    //   transitionDuration: const Duration(milliseconds: 450),
    // ),
    
    // AppLinks.menu: RouteConfig(
    //   name: AppLinks.menu,
    //   page: () => MenuScreen(),
    //   transitionBuilder: _cupertinoTransitionBuilder,
    //   transitionDuration: const Duration(milliseconds: 450),
    // ),

    // // NEW: Menu Screen Routes
    // AppLinks.editProfile: RouteConfig(
    //   name: AppLinks.editProfile,
    //   page: () => EditProfileScreen(),
    //   transitionBuilder: _rightToLeftTransitionBuilder,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    
    // AppLinks.security: RouteConfig(
    //   name: AppLinks.security,
    //   page: () => SecurityScreen(),
    //   transitionBuilder: _rightToLeftTransitionBuilder,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    
    // AppLinks.privacyPolicy: RouteConfig(
    //   name: AppLinks.privacyPolicy,
    //   page: () => PrivacyPolicyScreen(),
    //   transitionBuilder: _rightToLeftTransitionBuilder,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    
    // AppLinks.helpCenter: RouteConfig(
    //   name: AppLinks.helpCenter,
    //   page: () => HelpCenterScreen(),
    //   transitionBuilder: _rightToLeftTransitionBuilder,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    
    // AppLinks.inviteFriends: RouteConfig(
    //   name: AppLinks.inviteFriends,
    //   page: () => InviteFriendsScreen(),
    //   transitionBuilder: _rightToLeftTransitionBuilder,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),

    // // Scan screens
    // AppLinks.scannscreen: RouteConfig(
    //   name: AppLinks.scannscreen,
    //   page: () => ScanScreen(),
    //   transitionBuilder: _rightToLeftTransitionBuilder,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    
    // AppLinks.daymealsscreen: RouteConfig(
    //   name: AppLinks.daymealsscreen,
    //   page: () => DayMealScreen(),
    //   transitionBuilder: _rightToLeftTransitionBuilder,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    
    // AppLinks.chataiscreen: RouteConfig(
    //   name: AppLinks.chataiscreen,
    //   page: () => ChatScreen(),
    //   transitionBuilder: _rightToLeftTransitionBuilder,
    //   transitionDuration: const Duration(milliseconds: 400),
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

  static Widget _leftToRightTransitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }

  static Widget _rightToLeftTransitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(-1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }

  static Widget _cupertinoTransitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
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
      transitionsBuilder: config.transitionBuilder ?? _cupertinoTransitionBuilder,
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

  // Get route configuration by name
  static RouteConfig? getRouteConfig(String routeName) {
    return _routeConfigs[routeName];
  }

  // Check if route exists
  static bool hasRoute(String routeName) {
    return _routeConfigs.containsKey(routeName);
  }

  // Get all route names
  static List<String> get routeNames => _routeConfigs.keys.toList();
}

class NavigationHelper {
  static final NavigationService _navigationService = NavigationService();

  // Generic navigation method that uses route configurations
  static Future<void> navigateTo(
    String routeName, {
    Map<String, dynamic>? arguments,
    bool? isOffAll,
  }) async {
    final config = AppRoutes.getRouteConfig(routeName);

    if (config == null) {
      print('Route $routeName not found!');
      return;
    }

    final useOffAll = isOffAll ?? config.isOffAll;

    if (useOffAll) {
      await _navigationService.navigateAndRemoveUntil(routeName, arguments: arguments);
    } else {
      await _navigationService.navigateTo(routeName, arguments: arguments);
    }
  }

  // Predefined navigation methods for convenience - ONLY WORKING ROUTES
  static Future<void> toSplash() => navigateTo(AppLinks.splash);
  static Future<void> toOnboarding() => navigateTo(AppLinks.initial);
  static Future<void> tonotification() => navigateTo(AppLinks.notify);
  static Future<void> tobookmark() => navigateTo(AppLinks.bookmark);
  static Future<void> toProfile() => navigateTo(AppLinks.profile);
  static Future<void> toAuth() => navigateTo(AppLinks.auth);
  static Future<void> toHome() => navigateTo(AppLinks.home);
  static Future<void> toNavBar() => navigateTo(AppLinks.navbar);
  static Future<void> toScan() => navigateTo(AppLinks.scan);
  static Future<void> toProgress() => navigateTo(AppLinks.progress);
  static Future<void> toRewards() => navigateTo(AppLinks.rewards);
  static Future<void> toMenu() => navigateTo(AppLinks.menu);
  static Future<void> toEditProfile() => navigateTo(AppLinks.editProfile);
  static Future<void> toSecurity() => navigateTo(AppLinks.security);
  static Future<void> toPrivacyPolicy() => navigateTo(AppLinks.privacyPolicy);
  static Future<void> toHelpCenter() => navigateTo(AppLinks.helpCenter);
  static Future<void> toInviteFriends() => navigateTo(AppLinks.inviteFriends);
  static Future<void> toScanScreen() => navigateTo(AppLinks.scannscreen);
  static Future<void> toDayMealScreen() => navigateTo(AppLinks.daymealsscreen);
  static Future<void> toChatAiScreen() => navigateTo(AppLinks.chataiscreen);

  // Custom transition methods (override default configs)
  static Future<void> toOnboardingWithCircularReveal() {
    return navigateTo(AppLinks.initial);
  }

  // Direct widget navigation for special cases
  static Future<void> navigateToWidget(
    Widget Function() page, {
    bool offAll = false,
  }) {
    if (offAll) {
      return _navigationService.navigateAndRemoveUntil('/custom', arguments: {'widget': page});
    } else {
      return _navigationService.navigateTo('/custom', arguments: {'widget': page});
    }
  }

  // Utility methods
  static void back<T>([T? result]) => _navigationService.goBackWithResult(result);

  static void backUntil(String routeName) => _navigationService.popUntil(routeName);

  static void backToHome() {
    if (AppRoutes.hasRoute(AppLinks.home)) {
      backUntil(AppLinks.home);
    } else {
      backUntil(AppLinks.initial);
    }
  }

  static void reloadCurrent() {
    final currentRoute = _navigationService.currentRoute;
    if (currentRoute != null && AppRoutes.hasRoute(currentRoute)) {
      _navigationService.navigateAndRemoveUntil(currentRoute);
    }
  }

  // Get current route info
  static String? get currentRoute => _navigationService.currentRoute;
  static bool get canPop => _navigationService.canPop();

  // Clear all screens and go to specific route
  static Future<void> clearStackAndGoTo(String routeName) {
    if (AppRoutes.hasRoute(routeName)) {
      return _navigationService.navigateAndRemoveUntil(routeName);
    }
    return Future.value();
  }
}

// Custom route for widget navigation
Route<dynamic> _generateCustomRoute(RouteSettings settings) {
  final arguments = settings.arguments as Map<String, dynamic>?;
  final widgetBuilder = arguments?['widget'] as Widget Function()?;

  if (widgetBuilder != null) {
    return MaterialPageRoute(
      builder: (context) => widgetBuilder(),
      settings: settings,
    );
  }

  return AppRoutes.generateRoute(settings);
}

// Updated RouteGenerator to handle custom routes
class ExtendedRouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == '/custom') {
      return _generateCustomRoute(settings);
    }
    return AppRoutes.generateRoute(settings);
  }
}