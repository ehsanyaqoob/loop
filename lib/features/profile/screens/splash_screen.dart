import 'package:flutter/foundation.dart';
import 'package:loop/export.dart';
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
  late Animation<double> _logoFadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAppFlow();
    });
  }

  void _startAppFlow() async {
    if (!mounted) return;

    final splashProvider = context.read<SplashProvider>();
    await splashProvider.awaitSplashEnd();

    if (mounted) {
      await Navigate.offAll(AppLinks.leaguesCategory);
    }
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
      ),
    );

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeIn),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackground,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: FadeTransition(
                      opacity: _logoFadeAnimation,
                      child: SvgPicture.asset(
                        Assets.loop,
                        height: 150.0,
                        color: ThemeColors.buttonBackground(context),
                      ),
                    ),
                  ),
                  16.height,
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: MyText(
                      text: "Loop",
                      color: context.text,
                      size: 30,
                      weight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 40,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Consumer<SplashProvider>(
                      builder: (context, provider, child) {
                        return AnimatedOpacity(
                          opacity: provider.showLoader ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              LoopLoader(),
                              12.height,
                              MyText(
                                text: "Loading...",
                                color: context.subtitle.withOpacity(0.7),
                                size: 16.0,
                                weight: FontWeight.w500,
                                letterSpacing: 0.3,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    32.height,
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          MyText(
                            text: "By",
                            color: context.subtitle.withOpacity(0.5),
                            size: 16.0,
                            weight: FontWeight.w400,
                          ),
                          4.height,
                          MyText(
                            text: "flex",
                            color: context.buttonBackground,
                            size: 18.0,
                            weight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (kDebugMode)
              Positioned(
                top: 20,
                right: 20,
                child: Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => themeProvider.toggleTheme(),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: context.surface.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            context.isDarkMode
                                ? Icons.light_mode_outlined
                                : Icons.dark_mode_outlined,
                            color: context.icon,
                            size: 20,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
