// import 'dart:math';
// import 'package:nutri/constants/export.dart';

// class FloatingIcon extends StatefulWidget {
//   final String asset;
//   final double size;
//   final Duration duration;

//   const FloatingIcon({
//     super.key,
//     required this.asset,
//     required this.size,
//     required this.duration,
//   });

//   @override
//   State<FloatingIcon> createState() => _FloatingIconState();
// }

// class _FloatingIconState extends State<FloatingIcon>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _xAnimation;
//   late Animation<double> _yAnimation;
//   late Animation<double> _rotationAnimation;
//   final random = Random();
//   late double startX, startY, endX, endY;

//   @override
//   void initState() {
//     super.initState();
    
//     // Generate random start and end positions across the entire screen
//     _generateRandomPositions();

//     _controller = AnimationController(
//       vsync: this,
//       duration: widget.duration,
//     )..repeat(reverse: true);

//     // X position animation - move horizontally across screen
//     _xAnimation = Tween<double>(
//       begin: startX,
//       end: endX,
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));

//     // Y position animation - move vertically across screen
//     _yAnimation = Tween<double>(
//       begin: startY,
//       end: endY,
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));

//     // Create rotation animation
//     _rotationAnimation = Tween<double>(
//       begin: 0,
//       end: 2 * pi, // Full rotation
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.linear,
//     ));
//   }

//   void _generateRandomPositions() {
//     // Generate random positions that cover the entire screen area
//     // Using larger range to cover full scaffold
//     startX = random.nextDouble() * 400 - 50; // -50 to 350 to go off-screen
//     startY = random.nextDouble() * 800 - 50; // -50 to 750 to go off-screen
    
//     endX = random.nextDouble() * 400 - 50;
//     endY = random.nextDouble() * 800 - 50;
    
//     // Ensure minimum distance between start and end for visible movement
//     final distance = sqrt(pow(endX - startX, 2) + pow(endY - startY, 2));
//     if (distance < 100) {
//       // If too close, regenerate end position
//       endX = startX + (random.nextDouble() * 200 + 100) * (random.nextBool() ? 1 : -1);
//       endY = startY + (random.nextDouble() * 200 + 100) * (random.nextBool() ? 1 : -1);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, _) {
//         return Positioned(
//           left: _xAnimation.value,
//           top: _yAnimation.value,
//           child: Opacity(
//             opacity: 0.15 + (0.1 * sin(_controller.value * pi * 3)), // Faster opacity change
//             child: Transform.rotate(
//               angle: _rotationAnimation.value * 0.5,
//               child: SvgPicture.asset(
//                 widget.asset,
//                 height: widget.size,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }