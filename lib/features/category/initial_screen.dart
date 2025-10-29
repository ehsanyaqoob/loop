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
                                // Orbit Rings
                                ...List.generate(2, (index) {
                                  final radius = index == 0 ? 115.0 : 165.0;
                                  return Container(
                                    height: radius * 2,
                                    width: radius * 2,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: context.primary.withOpacity(0.3),
                                        width: 1.5,
                                      ),
                                    ),
                                  );
                                }),

                                // Center Cricket Element
                                Container(
                                  height: 100.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22.0),
                                    gradient: LinearGradient(
                                      colors: [
                                        context.primary,
                                        context.primary.withOpacity(0.7),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.sports_cricket,
                                    size: 80,
                                    color: ThemeColors.background(context),
                                  ),
                                ),

                                // Inner Ring - Cricket Actions
                                ...List.generate(6, (i) {
                                  final angle = (360.0 / 6) * i + rotation;
                                  final offset = provider.getOrbitOffset(
                                    115.0,
                                    angle,
                                  );
                                  return Transform.translate(
                                    offset: offset,
                                    child: OrbitItem(
                                      asset: [
                                        Assets.person1,
                                        Assets.person2,
                                        Assets.person3,
                                        Assets.person4,
                                        Assets.person5,
                                        Assets.person1,
                                      ][i],
                                      isInnerRing: true,
                                    ),
                                  );
                                }),

                                // Outer Ring - League Badges
                                ...List.generate(8, (i) {
                                  final angle = (360.0 / 8) * i - rotation;
                                  final offset = provider.getOrbitOffset(
                                    165.0,
                                    angle,
                                  );
                                  final colors = [
                                    Colors.blue,
                                    Colors.green,
                                    Colors.yellow,
                                    Colors.red,
                                    Colors.purple,
                                    Colors.orange,
                                    Colors.teal,
                                    Colors.pink,
                                  ];
                                  return Transform.translate(
                                    offset: offset,
                                    child: OrbitItem(
                                      asset: [
                                        Assets.person1,
                                        Assets.person2,
                                        Assets.person3,
                                        Assets.person4,
                                        Assets.person5,
                                        Assets.person1,
                                        Assets.person2,
                                        Assets.person3,
                                      ][i],
                                      isInnerRing: false,
                                      badgeColor: colors[i],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),

                  10.height,
                  MyText(
                    textAlign: TextAlign.center,
                    text: 'Live Cricket Universe',
                    color: context.text,
                    size: 36.0,
                    weight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                  8.height,
                  MyText(
                    textAlign: TextAlign.center,
                    text:
                        'Real-time scores, stats & highlights\nfrom leagues around the world',
                    color: context.subtitle,
                    size: 16.0,
                    weight: FontWeight.w500,
                  ),
                  18.height,
                  // Quick Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...[
                        {'value': '50+', 'label': 'Leagues'},
                        {'value': '1000+', 'label': 'Matches'},
                        {'value': 'Live', 'label': 'Updates'},
                      ].map((stat) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              MyText(
                                text: stat['value']!,
                                color: context.primary,
                                size: 20,
                                weight: FontWeight.bold,
                              ),
                              4.height,
                              MyText(
                                text: stat['label']!,
                                color: context.subtitle,
                                size: 12,
                                weight: FontWeight.w500,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                  18.height,
                  MyButton(
                    buttonText: 'Start Following',
                    height: 56,
                    width: size.width * 0.85,
                    onTap: () {
                     Navigate.toLeaguesCategory();
                    },
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
}

// Child Widget for Orbit Items
class OrbitItem extends StatelessWidget {
  final String asset;
  final bool isInnerRing;
  final Color? badgeColor;

  const OrbitItem({
    super.key,
    required this.asset,
    required this.isInnerRing,
    this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    if (isInnerRing) {
      // Inner ring: Cricket action cards
      return Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: context.primary.withOpacity(0.1),
          border: Border.all(
            color: context.primary.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.asset(asset, fit: BoxFit.cover),
      );
    } else {
      // Outer ring: League badges
      return Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          gradient: LinearGradient(
            colors: [
              badgeColor?.withOpacity(0.8) ?? context.primary.withOpacity(0.8),
              badgeColor?.withOpacity(0.5) ?? context.primary.withOpacity(0.5),
            ],
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.asset(asset, fit: BoxFit.cover),
      );
    }
  }
}
