import 'package:loop/export.dart';
import 'package:loop/widget/common/back_press_handler.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InitialProvider>().initAnimation(this);
    });
  }

  @override
  void dispose() {
    context.read<InitialProvider>().disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => BackPressHandler.handleBackPress(context),
      child: Scaffold(
        backgroundColor: context.scaffoldBackground,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: AppSizes.DEFAULT,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  40.height,
                  // Animated Orbit Section
                  Consumer<InitialProvider>(
                    builder: (context, provider, _) {
                      return AnimatedBuilder(
                        animation:
                            provider.rotationController ??
                            AnimationController(vsync: this),
                        builder: (context, child) {
                          final rotation =
                              provider.rotationController?.value != null
                              ? provider.rotationController!.value * 360.0
                              : 0.0;
                          return SizedBox(
                            height: size.width * 0.9,
                            width: size.width * 0.9,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Orbit Ring Lines
                                _buildOrbitRingLine(
                                  115.0,
                                  context.primary.withOpacity(0.3),
                                ),
                                _buildOrbitRingLine(
                                  165.0,
                                  context.primary.withOpacity(0.3),
                                ),

                                _buildCenterImage(),
                                ..._buildOrbitRing(
                                  provider,
                                  rotation,
                                  6,
                                  115.0,
                                  clockwise: true,
                                ),
                                ..._buildOrbitRing(
                                  provider,
                                  rotation,
                                  8,
                                  165.0,
                                  clockwise: false,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),

                  // Text Content - Centered
                  60.height,
                  MyText(
                    textAlign: TextAlign.center,
                    text: 'Inspire People',
                    color: context.text,
                    size: 36.0,
                    weight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                  8.height,
                  MyText(
                    textAlign: TextAlign.center,
                    text:
                        'Share your moments and inspire\nmillions around the world',
                    color: context.subtitle,
                    size: 16.0,
                    weight: FontWeight.w500,
                  ),
                  24.height,
                  // Button - Centered
                  Center(
                    child: MyButton(
                      buttonText: 'Loop',
                      height: 56,
                      width: size.width * 0.85,
                    ),
                  ),
                  30.height,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrbitRingLine(double radius, Color color) {
    return Container(
      height: radius * 2,
      width: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: color,
          width: 1.5,
          strokeAlign: BorderSide.strokeAlignCenter,
        ),
      ),
    );
  }

  Widget _buildCenterImage() {
    return Container(
      height: 100.0,
      width: 100.0,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(22.0)),
      clipBehavior: Clip.hardEdge,
      child: Image.asset(Assets.person4, fit: BoxFit.cover),
    );
  }

  List<Widget> _buildOrbitRing(
    InitialProvider provider,
    double rotation,
    int count,
    double radius, {
    required bool clockwise,
  }) {
    final direction = clockwise ? 1.0 : -1.0;
    final avatarAssets = _getAvatarAssets();

    return List.generate(count, (i) {
      final angle = (360.0 / count) * i + rotation * direction;
      final offset = provider.getOrbitOffset(radius, angle);
      final assetIndex = i % avatarAssets.length;
      return Transform.translate(
        offset: offset,
        child: _buildAvatar(avatarAssets[assetIndex]),
      );
    });
  }

  List<String> _getAvatarAssets() {
    return [
      Assets.person1,
      Assets.person2,
      Assets.person3,
      Assets.person4,
      Assets.person5,
    ];
  }

  Widget _buildAvatar(String asset) {
    return Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
      clipBehavior: Clip.hardEdge,
      child: Image.asset(asset, fit: BoxFit.cover),
    );
  }
}
