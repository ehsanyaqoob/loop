import 'package:loop/export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // App lifecycle provider
        ChangeNotifierProvider(create: (_) => AppLifecycleProvider()),

        // Theme provider
        ChangeNotifierProvider(create: (_) => ThemeProvider()),

        // Splash provider
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        // ChangeNotifierProvider(create: (_) => AuthProvider()),
        // ChangeNotifierProvider(create: (_) => ProfileProvider()),
        // ChangeNotifierProvider(create: (_) => NavProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Loop', 
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            debugShowCheckedModeBanner: false,
            navigatorKey: NavigationService.navigatorKey,
            onGenerateRoute: ExtendedRouteGenerator.generateRoute,
            initialRoute: AppLinks.splash,
            builder: (context, child) {
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: context.isDarkMode ? Brightness.light : Brightness.dark,
                  systemNavigationBarColor: context.scaffoldBackground,
                  systemNavigationBarIconBrightness: context.isDarkMode ? Brightness.light : Brightness.dark,
                  systemNavigationBarDividerColor: Colors.transparent,
                ),
                child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: child,
                ),
              );
            },
          );
        },
      ),
    );
  }
}