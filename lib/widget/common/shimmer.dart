// import 'package:nutri/constants/export.dart';

// class ShimmerWrapper extends StatelessWidget {
//   final Widget shimmerChild;
//   final Widget child;
//   final bool isLoading;

//   const ShimmerWrapper({
//     Key? key,
//     required this.shimmerChild,
//     required this.child,
//     required this.isLoading,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (!isLoading) return child;
//     final baseColor = kDynamicCard(context).withOpacity(0.4);
//     final highlightColor = kDynamicCard(context).withOpacity(0.7);
//     return Shimmer.fromColors(
//       baseColor: baseColor,
//       highlightColor: highlightColor,
//       child: shimmerChild,
//     );
//   }
// }
