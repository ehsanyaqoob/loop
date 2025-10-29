import 'package:loop/core/services/api_services/api_service.dart';
import 'package:loop/core/services/storage-services.dart';
import 'package:loop/export.dart';
import 'package:loop/providers/leagues_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StorageService()),
        ChangeNotifierProvider(
          create: (_) => ApiService(storageService: StorageService()),
        ),
        ChangeNotifierProvider(create: (_) => AppLifecycleProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => InitialProvider()),
        ChangeNotifierProvider(
          create: (context) => LeaguesProvider(
            apiService: Provider.of<ApiService>(context, listen: false),
          ),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Loop',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            debugShowCheckedModeBanner: false,
            navigatorKey: Navigate.navigatorKey,
            onGenerateRoute: AppRoutes.generateRoute,
            initialRoute: AppLinks.splash,
            builder: (context, child) {
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: context.isDarkMode
                      ? Brightness.light
                      : Brightness.dark,
                  systemNavigationBarColor: context.scaffoldBackground,
                  systemNavigationBarIconBrightness: context.isDarkMode
                      ? Brightness.light
                      : Brightness.dark,
                  systemNavigationBarDividerColor: Colors.transparent,
                ),
                child: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: StateAwareWidget(
                    child: child ?? const SizedBox(),
                    onResume: () => debugPrint("App resumed callback fired."),
                    onPause: () => debugPrint("App paused callback fired."),
                    onInactive: () =>
                        debugPrint("App inactive callback fired."),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


// scoring screen for future 
// live matches 