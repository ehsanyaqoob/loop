// import 'package:nutri/constants/export.dart';

// class CustomCheckbox extends StatefulWidget {
//   final String? text;
//   final String? text2;
//   final Color? textColor; // dynamic text color
//   final Color? activeColor; // when checked
//   final Color? inactiveColor; // when unchecked
//   final Color? borderColor; // border color
//   final Color? checkColor; // check icon color
//   final Function(bool) onChanged;
//   final bool? value;

//   const CustomCheckbox({
//     super.key,
//     this.text,
//     this.text2,
//     this.textColor,
//     this.activeColor,
//     this.inactiveColor,
//     this.borderColor,
//     this.checkColor, // new parameter for check icon color
//     required this.onChanged,
//     this.value,
//   });

//   @override
//   _CustomCheckboxState createState() => _CustomCheckboxState();
// }

// class _CustomCheckboxState extends State<CustomCheckbox> {
//   late bool _isChecked;

//   @override
//   void initState() {
//     super.initState();
//     _isChecked = widget.value ?? false;
//   }

//   @override
//   void didUpdateWidget(CustomCheckbox oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.value != null && widget.value != _isChecked) {
//       setState(() {
//         _isChecked = widget.value!;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isArabic = Get.locale?.languageCode == 'ar';

//     /// Resolve dynamic colors
//     final Color activeColor = widget.activeColor ?? kPrimaryColor;
//     final Color inactiveColor =
//         widget.inactiveColor ?? kDynamicScaffoldBackground(context);
//     final Color borderColor = widget.borderColor ?? kDynamicBorder(context);
//     final Color textColor = widget.textColor ?? kDynamicText(context);
//     final Color checkColor = widget.checkColor ?? kDynamicIconOnPrimary(context) ?? Colors.white;

//     final checkbox = Bounce(
//       onTap: () {
//         setState(() {
//           _isChecked = !_isChecked;
//         });
//         widget.onChanged(_isChecked);
//       },
//       child: Container(
//         width: 20,
//         height: 20,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8.0),
//           color: _isChecked ? activeColor : inactiveColor,
//           border: Border.all(
//             color: _isChecked ? activeColor : borderColor,
//             width: 1,
//           ),
//         ),
//         child: _isChecked
//             ? Icon(Icons.check, color: checkColor, size: 16)
//             : null,
//       ),
//     );

//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _isChecked = !_isChecked;
//         });
//         widget.onChanged(_isChecked);
//       },
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: isArabic
//             ? [
//                 if (widget.text != null || widget.text2 != null) ...[
//                   Text.rich(
//                     TextSpan(
//                       children: [
//                         if (widget.text != null)
//                           TextSpan(
//                             text: widget.text,
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: textColor,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         if (widget.text2 != null)
//                           TextSpan(
//                             text: widget.text2,
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: textColor,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                 ],
//                 checkbox,
//               ]
//             : [
//                 checkbox,
//                 if (widget.text != null || widget.text2 != null) ...[
//                   const SizedBox(width: 10),
//                   Text.rich(
//                     TextSpan(
//                       children: [
//                         if (widget.text != null)
//                           TextSpan(
//                             text: widget.text,
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: textColor,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         if (widget.text2 != null)
//                           TextSpan(
//                             text: widget.text2,
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: textColor,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ],
//       ),
//     );
//   }
// }

// // class CustomCheckbox2 extends StatefulWidget {
// //   final String? text;
// //   final String? text2;

// //   final Color? textcolor;
// //   final Function(bool) onChanged;

// //   const CustomCheckbox2({
// //     super.key,
// //     this.text,
// //     this.text2,

// //     required this.onChanged,
// //     this.textcolor,
// //   });

// //   @override
// //   _CustomCheckBox2State createState() => _CustomCheckBox2State();
// // }

// // class _CustomCheckBox2State extends State<CustomCheckbox2> {
// //   bool _isChecked = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     final isArabic = Get.locale?.languageCode == 'ar';

// //     return Row(
// //       children: [
// //         if (!isArabic) ...[
// //           Expanded(
// //             child: Row(
// //               children: [
// //                 Bounce(
// //                   onTap: () {
// //                     setState(() {
// //                       _isChecked = !_isChecked;
// //                     });
// //                     widget.onChanged(_isChecked);
// //                   },
// //                   child: Container(
// //                     width: 20,
// //                     height: 20,
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(4),
// //                       color: _isChecked ? kPrimaryColor : kWhite,
// //                       border: Border.all(
// //                         color: _isChecked ? kPrimaryColor : kDynamicBorder(context),
// //                         width: 1,
// //                       ),
// //                     ),
// //                     child: _isChecked
// //                         ? Icon(Icons.check, color: kWhite, size: 16)
// //                         : null,
// //                   ),
// //                 ),
// //                 SizedBox(width: 10),
// //                 Flexible(
// //                   child: Row(
// //                     spacing: 4,
// //                     children: [
// //                       MyText(
// //                         text: widget.text ?? '',
// //                         letterSpacing: 0,
// //                         size: 12,
// //                         color: kSubText,
// //                         weight: FontWeight.w400,
// //                       ),
// //                       MyText(
// //                         text: widget.text2 ?? '',
// //                         size: 14,
// //                         color: kBlack,
// //                         letterSpacing: 0,
// //                         weight: FontWeight.w400,
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ] else ...[
// //           Expanded(
// //             child: Row(
// //               children: [
// //                 Flexible(
// //                   child: Row(
// //                     spacing: 4,
// //                     children: [
// //                       MyText(
// //                         text: widget.text ?? '',
// //                         letterSpacing: 0,
// //                         size: 12,
// //                         color: kBlack,
// //                         weight: FontWeight.w400,
// //                       ),
// //                       MyText(
// //                         text: widget.text2 ?? '',
// //                         size: 14,
// //                         color: kBlack,
// //                         letterSpacing: 0,
// //                         weight: FontWeight.w400,
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 SizedBox(width: 10),
// //                 Bounce(
// //                   onTap: () {
// //                     setState(() {
// //                       _isChecked = !_isChecked;
// //                     });
// //                     widget.onChanged(_isChecked);
// //                   },
// //                   child: Container(
// //                     width: 20,
// //                     height: 20,
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(4),
// //                       color: _isChecked ? kPrimaryColor : kWhite,
// //                       border: Border.all(
// //                         color: _isChecked ? kPrimaryColor : kDynamicBorder(context),
// //                         width: 1,
// //                       ),
// //                     ),
// //                     child: _isChecked
// //                         ? Icon(Icons.check, color: kWhite, size: 16)
// //                         : null,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ],
// //     );
// //   }
// // }
