import 'package:flutter/foundation.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loop/export.dart';
import 'package:loop/features/intials/intial_screen.dart';
import 'package:loop/generated/assets.dart';
import 'package:loop/generated/extensions/extension.dart';
import 'package:loop/widget/common/dot-loader.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _showLoader = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _updateSystemUi();
    _startSplashSequence();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    _animationController.forward();
  }

  void _startSplashSequence() {
    // Show loader after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showLoader = true;
      });
    });

    // Navigate to home after 4 seconds total
    Future.delayed(const Duration(seconds: 4), () {
      _navigateToHome();
    });
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  void _updateSystemUi() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      final bool isDark = themeProvider.isDarkMode;

      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          systemNavigationBarColor: context.background,
          systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          systemNavigationBarDividerColor: Colors.transparent,
        ),
      );

      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: context.isDarkMode ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: context.scaffoldBackground,
            systemNavigationBarIconBrightness: context.isDarkMode ? Brightness.light : Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: context.scaffoldBackground,
            body: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  /// 🌿 Center Logo Animation
                  Center(
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 170,
                              width: 170,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  Assets.fire,
                                  height: 100.0,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            20.height,
                            MyText(
                              text: "Loop",
                              color: context.text,
                              size: 28,
                              weight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// ⏳ Progress loader (bottom)
                  if (_showLoader)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: MediaQuery.of(context).padding.bottom + 50,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MyText(
                              text: "Loading your data...",
                              color: context.subtitle,
                              size: 14,
                              weight: FontWeight.w400,
                            ),
                            8.height,
                            LoopLoader(),
                          ],
                        ),
                      ),
                    ),

                  /// 🌗 Debug theme toggle
                  if (kDebugMode)
                    Positioned(
                      top: 20,
                      right: 20,
                      child: FloatingActionButton(
                        mini: true,
                        backgroundColor: context.surface,
                        onPressed: () => themeProvider.toggleTheme(),
                        child: Icon(
                          context.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                          color: context.icon,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}