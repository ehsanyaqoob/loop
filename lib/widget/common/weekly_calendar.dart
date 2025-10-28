// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:nutri/constants/export.dart';
// import 'package:nutri/widget/common/my_text_widget.dart';

// class HorizontalWeekCalendar extends StatefulWidget {
//   final DateTime? selectedDate;
//   final ValueChanged<DateTime>? onDateSelected;
//   final Color? primaryColor;
//   final Color? selectedDayColor;
//   final Color? todayColor;
//   final Color? backgroundColor;
//   final double? itemWidth;
//   final double? itemHeight;
//   final double? itemSpacing;
//   final TextStyle? dayTextStyle;
//   final TextStyle? selectedDayTextStyle;
//   final TextStyle? weekdayTextStyle;
//   final TextStyle? todayTextStyle;
//   final int? weeksToShow;
//   final Duration? animationDuration;
//   final bool? showWeekdays;
//   final bool? showMonthLabel;
//   final bool? highlightToday;
//   final double? height;
//   final EdgeInsets? padding;
//   final BoxDecoration? selectedDecoration;
//   final BoxDecoration? todayDecoration;
//   final bool? showMiddleDot;
//   final Color? middleDotColor;
//   final Color? pastDayDotColor;
//   final Color? todayDotColor;
//   final double? dotSize;

//   const HorizontalWeekCalendar({
//     Key? key,
//     this.selectedDate,
//     this.onDateSelected,
//     this.primaryColor,
//     this.selectedDayColor,
//     this.todayColor,
//     this.backgroundColor,
//     this.itemWidth,
//     this.itemHeight,
//     this.itemSpacing,
//     this.dayTextStyle,
//     this.selectedDayTextStyle,
//     this.weekdayTextStyle,
//     this.todayTextStyle,
//     this.weeksToShow,
//     this.animationDuration,
//     this.showWeekdays,
//     this.showMonthLabel,
//     this.highlightToday,
//     this.height,
//     this.padding,
//     this.selectedDecoration,
//     this.todayDecoration,
//     this.showMiddleDot = true,
//     this.middleDotColor,
//     this.pastDayDotColor,
//     this.todayDotColor,
//     this.dotSize = 4.0,
//   }) : super(key: key);

//   @override
//   State<HorizontalWeekCalendar> createState() => _HorizontalWeekCalendarState();
// }

// class _HorizontalWeekCalendarState extends State<HorizontalWeekCalendar> {
//   late DateTime _selectedDate;
//   late ScrollController _scrollController;
//   final DateTime _today = DateTime.now();
//   String? _currentMonth;

//   @override
//   void initState() {
//     super.initState();
//     _selectedDate = widget.selectedDate ?? DateTime.now();
//     _scrollController = ScrollController();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollToSelectedDate(animated: false);
//     });
//   }

//   @override
//   void didUpdateWidget(HorizontalWeekCalendar oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.selectedDate != null &&
//         widget.selectedDate != oldWidget.selectedDate) {
//       setState(() {
//         _selectedDate = widget.selectedDate!;
//       });
//       _scrollToSelectedDate(animated: true);
//     }
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _scrollToSelectedDate({bool animated = true}) {
//     final daysSinceStart = _selectedDate.difference(_getStartDate()).inDays;
//     final itemWidth = (widget.itemWidth ?? 56.0) + (widget.itemSpacing ?? 8.0);
//     final scrollPosition = daysSinceStart * itemWidth;

//     if (_scrollController.hasClients) {
//       if (animated) {
//         _scrollController.animateTo(
//           scrollPosition,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//         );
//       } else {
//         _scrollController.jumpTo(scrollPosition);
//       }
//     }
//   }

//   DateTime _getStartDate() {
//     final now = DateTime.now();
//     final weeksToShow = widget.weeksToShow ?? 52;
//     return now.subtract(
//       Duration(days: (weeksToShow ~/ 2) * 7 + now.weekday - 1),
//     );
//   }

//   String _getWeekdayName(int weekday) {
//     return DateFormat('E').format(DateTime(2024, 1, weekday));
//   }

//   bool _isSameDay(DateTime date1, DateTime date2) {
//     return date1.year == date2.year &&
//         date1.month == date2.month &&
//         date1.day == date2.day;
//   }

//   bool _isPastDay(DateTime date) {
//     final today = DateTime(_today.year, _today.month, _today.day);
//     final checkDate = DateTime(date.year, date.month, date.day);
//     return checkDate.isBefore(today);
//   }

//   bool _isToday(DateTime date) {
//     final today = DateTime(_today.year, _today.month, _today.day);
//     final checkDate = DateTime(date.year, date.month, date.day);
//     return checkDate.isAtSameMomentAs(today);
//   }

//   bool _isFutureDay(DateTime date) {
//     final today = DateTime(_today.year, _today.month, _today.day);
//     final checkDate = DateTime(date.year, date.month, date.day);
//     return checkDate.isAfter(today);
//   }

//   Color _getDotColor(DateTime date, Color primaryColor, Color middleDotColor) {
//     if (_isToday(date)) {
//       return widget.todayDotColor ?? middleDotColor;
//     } else if (_isPastDay(date)) {
//       return widget.pastDayDotColor ?? middleDotColor.withOpacity(0.4);
//     }
//     return Colors.transparent;
//   }

//   bool _shouldShowDot(DateTime date, bool showMiddleDot) {
//     if (!showMiddleDot) return false;
//     if (_isFutureDay(date)) return false;
//     return true;
//   }

//   Color _getDayTextColor(
//     DateTime date,
//     bool isSelected,
//     bool isToday,
//     bool highlightToday,
//     Color primaryColor,
//   ) {
//     if (isSelected) {
//       return kLightBackground;
//     } else if (isToday && highlightToday) {
//       return primaryColor;
//     }
//     return kDynamicText(context);
//   }

//   Color _getWeekdayTextColor(
//     DateTime date,
//     bool isSelected,
//     bool isToday,
//     bool highlightToday,
//     Color primaryColor,
//   ) {
//     if (isSelected) {
//       return kLightBackground;
//     } else if (isToday && highlightToday) {
//       return primaryColor;
//     }
//     return kDynamicSubtitleText(context);
//   }

//   FontWeight _getDayFontWeight(
//     bool isSelected,
//     bool isToday,
//     bool highlightToday,
//   ) {
//     if (isSelected || (isToday && highlightToday)) {
//       return FontWeight.bold;
//     }
//     return FontWeight.w600;
//   }

//   FontWeight _getWeekdayFontWeight(
//     bool isSelected,
//     bool isToday,
//     bool highlightToday,
//   ) {
//     if (isSelected || (isToday && highlightToday)) {
//       return FontWeight.w600;
//     }
//     return FontWeight.w500;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final primaryColor = widget.primaryColor ?? Theme.of(context).primaryColor;
//     final itemWidth = widget.itemWidth ?? 56.0;
//     final itemHeight = widget.itemHeight ?? 80.0;
//     final itemSpacing = widget.itemSpacing ?? 8.0;
//     final weeksToShow = widget.weeksToShow ?? 52;
//     final selectedDayColor = widget.selectedDayColor ?? primaryColor;
//     final todayColor = widget.todayColor ?? primaryColor.withOpacity(0.1);
//     final backgroundColor = widget.backgroundColor ?? Colors.transparent;
//     final animationDuration =
//         widget.animationDuration ?? const Duration(milliseconds: 250);
//     final showWeekdays = widget.showWeekdays ?? true;
//     final showMonthLabel = widget.showMonthLabel ?? true;
//     final highlightToday = widget.highlightToday ?? true;
//     final height = widget.height ?? 130.0;
//     final showMiddleDot = widget.showMiddleDot ?? true;
//     final middleDotColor =
//         widget.middleDotColor ?? primaryColor.withOpacity(0.6);
//     final dotSize = widget.dotSize ?? 4.0;

//     final startDate = _getStartDate();
//     final totalDays = weeksToShow * 7;

//     return Container(
//       height: height,
//       color: backgroundColor,
//       padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 12),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (showMonthLabel) ...[
//             SizedBox(
//               height: 28,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 4),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     MyText(
//                       text:
//                           _currentMonth ??
//                           DateFormat('MMMM yyyy').format(_selectedDate),
//                       size: 16.0,
//                       weight: FontWeight.w600,
//                       color: kDynamicText(context),
//                     ),
//                     if (!_isSameDay(_selectedDate, _today))
//                       Bounce(
//                         onTap: () {
//                           setState(() {
//                             _selectedDate = _today;
//                           });
//                           widget.onDateSelected?.call(_today);
//                           _scrollToSelectedDate();
//                           HapticFeedback.lightImpact();
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 4,
//                           ),
//                           decoration: BoxDecoration(
//                             color: kDynamicPrimary(context).withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: MyText(
//                             text: 'Today',
//                             size: 14.0,
//                             weight: FontWeight.w600,
//                             color: kDynamicPrimary(context),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             const Gap(10),
//           ],
//           Expanded(
//             child: NotificationListener<ScrollNotification>(
//               onNotification: (notification) {
//                 if (notification is ScrollUpdateNotification) {
//                   final totalItemWidth = itemWidth + itemSpacing;
//                   final centerIndex =
//                       (_scrollController.offset / totalItemWidth).round();
//                   final centerDate = startDate.add(Duration(days: centerIndex));
//                   final monthStr = DateFormat('MMMM yyyy').format(centerDate);

//                   if (_currentMonth != monthStr) {
//                     setState(() {
//                       _currentMonth = monthStr;
//                     });
//                   }
//                 }
//                 return false;
//               },
//               child: ListView.builder(
//                 controller: _scrollController,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: totalDays,
//                 physics: const BouncingScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   final date = startDate.add(Duration(days: index));
//                   final isSelected = _isSameDay(date, _selectedDate);
//                   final isToday = _isToday(date);
//                   final isPastDay = _isPastDay(date);
//                   final shouldShowDot = _shouldShowDot(date, showMiddleDot);
//                   final dotColor = _getDotColor(
//                     date,
//                     primaryColor,
//                     middleDotColor,
//                   );
//                   final dayTextColor = _getDayTextColor(
//                     date,
//                     isSelected,
//                     isToday,
//                     highlightToday,
//                     primaryColor,
//                   );
//                   final weekdayTextColor = _getWeekdayTextColor(
//                     date,
//                     isSelected,
//                     isToday,
//                     highlightToday,
//                     primaryColor,
//                   );
//                   final dayFontWeight = _getDayFontWeight(
//                     isSelected,
//                     isToday,
//                     highlightToday,
//                   );
//                   final weekdayFontWeight = _getWeekdayFontWeight(
//                     isSelected,
//                     isToday,
//                     highlightToday,
//                   );

//                   return Padding(
//                     padding: EdgeInsets.only(
//                       right: itemSpacing,
//                       left: index == 0 ? 4 : 0,
//                     ),
//                     child: Bounce(
//                       onTap: () {
//                         setState(() {
//                           _selectedDate = date;
//                         });
//                         widget.onDateSelected?.call(date);
//                         HapticFeedback.lightImpact();
//                       },
//                       child: AnimatedContainer(
//                         duration: animationDuration,
//                         curve: Curves.easeInOut,
//                         width: itemWidth,
//                         height: itemHeight,
//                         decoration:
//                             widget.selectedDecoration != null && isSelected
//                             ? widget.selectedDecoration
//                             : (widget.todayDecoration != null &&
//                                       isToday &&
//                                       highlightToday &&
//                                       !isSelected
//                                   ? widget.todayDecoration
//                                   : BoxDecoration(
//                                       color: isSelected
//                                           ? selectedDayColor
//                                           : (isToday && highlightToday
//                                                 ? todayColor
//                                                 : Colors.transparent),
//                                       borderRadius: BorderRadius.circular(
//                                         itemHeight / 2,
//                                       ),
//                                       border:
//                                           isToday &&
//                                               highlightToday &&
//                                               !isSelected
//                                           ? Border.all(
//                                               color: primaryColor,
//                                               width: 1.5,
//                                             )
//                                           : null,
//                                     )),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             // Weekday name (Mon, Tue, etc.)
//                             if (showWeekdays)
//                               MyText(
//                                 text: _getWeekdayName(date.weekday),
//                                 size: 11.0,
//                                 weight: weekdayFontWeight,
//                                 color: weekdayTextColor,
//                                 letterSpacing: 0.3,
//                               ),

//                             // Spacing between weekday and dot
//                             if (showWeekdays) const Gap(4),

//                             // Middle dot
//                             if (shouldShowDot)
//                               Container(
//                                 width: dotSize,
//                                 height: dotSize,
//                                 decoration: BoxDecoration(
//                                   color: dotColor,
//                                   shape: BoxShape.circle,
//                                 ),
//                               ),

//                             // Spacing between dot and date
//                             if (shouldShowDot) const Gap(4) else const Gap(8),

//                             // Date number
//                             MyText(
//                               text: date.day.toString(),
//                               size: 17.0,
//                               weight: dayFontWeight,
//                               color: dayTextColor,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
