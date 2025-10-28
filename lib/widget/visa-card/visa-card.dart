// import 'package:flutter/material.dart';
// import 'package:nutri/constants/export.dart';
// import 'package:intl/intl.dart';
// import 'package:nutri/generated/assets.dart';
// import 'package:nutri/widget/common/my_text_widget.dart';

// class CustomVisaCard extends StatefulWidget {
//   final String name;
//   final String cardNumber;
//   final double balance; // This will now be dynamic
//   final String expiryDate;
//   final String cvv;
//   final VoidCallback? onTopUp;

//   const CustomVisaCard({
//     Key? key,
//     required this.name,
//     required this.cardNumber,
//     required this.balance,
//     required this.expiryDate,
//     required this.cvv,
//     this.onTopUp,
//   }) : super(key: key);

//   @override
//   State<CustomVisaCard> createState() => _CustomVisaCardState();
// }

// class _CustomVisaCardState extends State<CustomVisaCard>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   bool _showCardNumber = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _flipCard() {
//     if (_controller.isCompleted) {
//       _controller.reverse();
//     } else {
//       _controller.forward();
//     }
//   }

//   void _toggleCardNumberVisibility() {
//     setState(() {
//       _showCardNumber = !_showCardNumber;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _flipCard,
//       child: AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) {
//           double angle = _controller.value * 3.1415926535897932;
//           bool isFront = angle <= 3.1415926535897932 / 2;
//           return Transform(
//             transform: Matrix4.identity()
//               ..setEntry(3, 2, 0.001)
//               ..rotateY(angle),
//             alignment: Alignment.center,
//             child: isFront
//                 ? _buildFrontCard()
//                 : Transform(
//                     transform: Matrix4.identity()..rotateY(3.1415926535897932),
//                     alignment: Alignment.center,
//                     child: _buildBackCard(),
//                   ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildFrontCard() {
//     return Container(
//       width: double.infinity,
//       height: 220,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             kPrimaryColor, kPrimaryColor, kPrimaryColor,
//             // kSecondaryColor,
//             // Colors.blue.shade800,
//             // Colors.blue.shade900,
//             // Colors.purple.shade800,
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(25),
//         boxShadow: [
//           BoxShadow(
//             color: kPrimaryColor.withOpacity(0.3),
//             blurRadius: 25,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 MyText(
//                   text: widget.name.toUpperCase(),
//                   color: kWhite,
//                   size: 16,
//                   weight: FontWeight.w600,
//                 ),
//                 Row(
//                   children: [
//                     SvgPicture.asset(Assets.visa, height: 34),
//                     Gap(6),
//                     SvgPicture.asset(Assets.visacard, height: 34, color: kRed),
//                   ],
//                 ),
//               ],
//             ),
//             const Spacer(),
//             GestureDetector(
//               onTap: _toggleCardNumberVisibility,
//               child: MyText(
//                 text: _showCardNumber
//                     ? _formatCardNumberVisible(widget.cardNumber)
//                     : _formatCardNumber(widget.cardNumber),
//                 color: kWhite,
//                 size: 20,
//                 letterSpacing: 3,
//                 weight: FontWeight.w500,
//               ),
//             ),
//             const Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     MyText(
//                       text: 'Your balance',
//                       color: kWhite.withOpacity(0.7),
//                       size: 12,
//                     ),
//                     MyText(
//                       text: _formatBalance(widget.balance),
//                       color: kWhite,
//                       size: 24,
//                       weight: FontWeight.bold,
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     MyText(
//                       text: 'VALID THRU',
//                       color: kWhite.withOpacity(0.7),
//                       size: 10,
//                     ),
//                     MyText(
//                       text: widget.expiryDate,
//                       color: kWhite,
//                       size: 16,
//                       weight: FontWeight.w600,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   width: 40,
//                   height: 30,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     color: kYellowColor,
//                   ),
//                   child: Center(
//                     child: SvgPicture.asset(
//                       Assets.walletfilled,
//                       color: kDynamicIcon(context),
//                     ),
//                   ),
//                 ),
//                 Bounce(
//                   onTap: widget.onTopUp,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 10,
//                     ),
//                     decoration: BoxDecoration(
//                       color: kWhite.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Row(
//                       children: [
//                         MyText(
//                           text: 'Top Up',
//                           color: kWhite,
//                           size: 14,
//                           weight: FontWeight.w600,
//                         ),
//                         Gap(6),
//                         SvgPicture.asset(
//                           Assets.down,
//                           height: 16.0,
//                           color: kRed,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBackCard() {
//     return Container(
//       width: double.infinity,
//       height: 220,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [kPrimaryColor, kPrimaryColor, kPrimaryColor],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(25),
//         boxShadow: [
//           BoxShadow(
//             color: kPrimaryColor.withOpacity(0.3),
//             blurRadius: 25,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(24),
//         child: Column(
//           children: [
//             Container(height: 40, color: kDynamicDivider(context)),
//             const Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     MyText(
//                       text: 'CVV',
//                       color: kWhite.withOpacity(0.7),
//                       size: 12,
//                     ),
//                     Container(
//                       width: 60,
//                       height: 30,
//                       decoration: BoxDecoration(
//                         color: kWhite,
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: Center(
//                         child: MyText(
//                           text: widget.cvv,
//                           color: kBlack,
//                           size: 14,
//                           weight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Container(
//                     height: 35,
//                     decoration: BoxDecoration(
//                       color: kWhite.withOpacity(0.9),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     child: Row(
//                       children: [
//                         MyText(
//                           text: 'Authorized Signature',
//                           color: kDynamicSubtitleText(context),
//                           size: 10,
//                         ),
//                         const Spacer(),
//                         MyText(
//                           text: 'NOT VALID UNLESS SIGNED',
//                           color: kDynamicSubtitleText(context),
//                           size: 8,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 SvgPicture.asset(Assets.visa, height: 30),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _formatCardNumber(String number) {
//     if (number.length < 4) return number;
//     return '••••  ••••  ••••  ${number.substring(number.length - 4)}';
//   }

//   String _formatCardNumberVisible(String number) {
//     if (number.length != 16) return number;
//     return '${number.substring(0, 4)}  ${number.substring(4, 8)}  ${number.substring(8, 12)}  ${number.substring(12)}';
//   }

//   String _formatBalance(double balance) {
//     final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
//     return formatter.format(balance);
//   }
// }
