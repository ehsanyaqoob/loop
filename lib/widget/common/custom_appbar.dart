// import 'package:nutri/constants/export.dart';

// class GenericAppBar extends StatefulWidget implements PreferredSizeWidget {
//   final String title;
//   final bool showSearch;
//   final Function(String)? onSearchChanged;
//   final String? searchHint;
//   final double logoSize;
//   final VoidCallback? onSettingsTap; // Add this

//   const GenericAppBar({
//     super.key,
//     required this.title,
//     this.showSearch = false,
//     this.onSearchChanged,
//     this.searchHint,
//     this.logoSize = 22.0,
//     this.onSettingsTap, // Add this
//   });

//   @override
//   State<GenericAppBar> createState() => _GenericAppBarState();

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

// class _GenericAppBarState extends State<GenericAppBar> {
//   final TextEditingController _searchController = TextEditingController();
//   bool _isSearching = false;
//   final FocusNode _searchFocusNode = FocusNode();

//   @override
//   void initState() {
//     super.initState();
//     _searchFocusNode.addListener(_onFocusChange);
//   }

//   void _onFocusChange() {
//     if (!_searchFocusNode.hasFocus && _searchController.text.isEmpty) {
//       _toggleSearch();
//     }
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchFocusNode.removeListener(_onFocusChange);
//     _searchFocusNode.dispose();
//     super.dispose();
//   }

//   void _onSearchChanged(String query) {
//     widget.onSearchChanged?.call(query);
//   }

//   void _toggleSearch() {
//     setState(() {
//       _isSearching = !_isSearching;
//       if (!_isSearching) {
//         _searchController.clear();
//         widget.onSearchChanged?.call('');
//         _searchFocusNode.unfocus();
//       } else {
//         // Focus on search field when it appears
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           _searchFocusNode.requestFocus();
//         });
//       }
//     });
//   }

//   void _clearSearch() {
//     _searchController.clear();
//     _onSearchChanged('');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ThemeController>(
//       builder: (themeController) {
//         return AppBar(
//           backgroundColor: kDynamicScaffoldBackground(context),
//           elevation: 0,
//           automaticallyImplyLeading: false,
//           title: _isSearching
//               ? _buildSearchField()
//               : Row(
//                   children: [
//                     // Logo
//                     Container(
//                       height: 44,
//                       width: 44,
//                       decoration: BoxDecoration(
//                         color: kDynamicPrimary(context).withOpacity(0.15),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: SvgPicture.asset(
//                           Assets.fire,
//                           height: widget.logoSize,
//                           width: widget.logoSize * 0.8,
//                           color: kDynamicPrimary(context),
//                         ),
//                       ),
//                     ),

//                     const Gap(12),

//                     // Title
//                     Expanded(
//                       child: MyText(
//                         text: widget.title,
//                         size: 18,
//                         weight: FontWeight.w600,
//                         color: kDynamicText(context),
//                         maxLines: 1,
//                         textOverflow: TextOverflow.ellipsis,
//                       ),
//                     ),

//                     // Action Icons
//                     Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         // Search Icon
//                         if (widget.showSearch && !_isSearching)
//                           IconButton(
//                             icon: SvgPicture.asset(
//                               Assets.searchunfilled,
//                               height: 22,
//                               color: kDynamicIcon(context),
//                             ),
//                             onPressed: _toggleSearch,
//                           ),

//                         // Settings Icon
//                         if (widget.onSettingsTap != null)
//                           IconButton(
//                             icon: SvgPicture.asset(
//                               Assets.settings,
//                               height: 22,
//                               color: kDynamicIcon(context),
//                             ),
//                             onPressed: widget.onSettingsTap,
//                           ),
//                       ],
//                     ),
//                   ],
//                 ),
//         );
//       },
//     );
//   }

//   Widget _buildSearchField() {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             key: const ValueKey('searchField'),
//             width: double.infinity,
//             margin: const EdgeInsets.only(right: 10, top: 26.0),
//             child: MyTextField(
//               controller: _searchController,
//               focusNode: _searchFocusNode,
//               hint: widget.searchHint ?? 'Search...',
//               prefix: SvgPicture.asset(
//                 Assets.searchunfilled,
//                 height: 20,
//                 color: kDynamicIcon(context),
//               ),
//               suffix: _searchController.text.isNotEmpty
//                   ? IconButton(
//                       icon: Icon(
//                         Icons.clear,
//                         color: kDynamicIcon(context),
//                         size: 18,
//                       ),
//                       onPressed: _clearSearch,
//                     )
//                   : null,
//               onChanged: _onSearchChanged,
//               hintColor: kDynamicListTileSubtitle(context),
//             ),
//           ),
//         ),
//         const Gap(8),
//         // Close button
//         IconButton(
//           icon: Icon(Icons.close, color: kDynamicText(context)),
//           onPressed: _toggleSearch,
//         ),
//       ],
//     );
//   }
// }

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String? title;
//   final List<Widget>? actions;
//   final VoidCallback? onBackTap;
//   final bool centerTitle;
//   final bool showLeading;
//   final double textSize;
//   final TextAlign? textAlign;
//   final bool showNotificationIcon;
//   final bool showAvatarIcon;
//   final bool showBasketIcon;
//   final bool showMessageIcon;
//   final VoidCallback? onNotificationTap;
//   final VoidCallback? onAvatarTap;
//   final VoidCallback? onBasketTap;
//   final VoidCallback? onMessageTap;
//   final double elevation;
//   final Color? backButtonColor;

//   const CustomAppBar({
//     super.key,
//     this.title,
//     this.actions,
//     this.onBackTap,
//     this.centerTitle = true,
//     this.showLeading = false,
//     this.textSize = 18,
//     this.textAlign,
//     this.showNotificationIcon = false,
//     this.showAvatarIcon = false,
//     this.showBasketIcon = false,
//     this.showMessageIcon = false,
//     this.onNotificationTap,
//     this.onAvatarTap,
//     this.onBasketTap,
//     this.onMessageTap,
//     this.elevation = 0,
//     this.backButtonColor,
//   });

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);

//   bool get _isRTL {
//     final langCode = Get.locale?.languageCode ?? 'en';
//     return langCode == 'ar' || langCode == 'sa';
//   }

//   // Standardized icon sizes
//   static const double _smallIconSize = 20.0;
//   static const double _mediumIconSize = 24.0;
//   static const double _largeIconSize = 36.0;

//   Widget _buildBackButton(BuildContext context) {
//     return IconButton(
//       onPressed: onBackTap ?? () => Get.back(),
//       icon: Icon(
//         _isRTL ? Icons.arrow_forward : Icons.arrow_back,
//         color: backButtonColor ?? kDynamicIcon(context),
//         size: 24.0, // Standard Material icon size
//       ),
//       padding: const EdgeInsets.all(16),
//       constraints: const BoxConstraints(
//         minWidth: 48,
//         minHeight: 48,
//       ),
//       tooltip: 'Back',
//     );
//   }

//   Widget _buildIconButton({
//     required BuildContext context,
//     required String asset,
//     required VoidCallback? onTap,
//     required double size,
//     EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 4),
//     bool isAvatar = false,
//     String? tooltip,
//   }) {
//     return Padding(
//       padding: padding,
//       child: IconButton(
//         onPressed: onTap ?? () {},
//         icon: SvgPicture.asset(
//           asset,
//           height: size,
//           width: size,
//           colorFilter: isAvatar
//               ? null
//               : ColorFilter.mode(
//                   kDynamicIcon(context),
//                   BlendMode.srcIn,
//                 ),
//         ),
//         padding: const EdgeInsets.all(8),
//         constraints: BoxConstraints(
//           minWidth: size + 16,
//           minHeight: size + 16,
//         ),
//         tooltip: tooltip,
//       ),
//     );
//   }

//   List<Widget> _buildOptionalIcons(BuildContext context) {
//     final icons = <Widget>[];

//     if (showMessageIcon) {
//       icons.add(
//         _buildIconButton(
//           context: context,
//           asset: Assets.personfilled, // Use proper message icon asset
//           onTap: onMessageTap,
//           size: _mediumIconSize,
//           tooltip: 'Messages',
//         ),
//       );
//     }

   

//     if (showNotificationIcon) {
//       icons.add(
//         _buildIconButton(
//           context: context,
//           asset: Assets.notificationfilled, // Use proper notification icon asset
//           onTap: onNotificationTap,
//           size: _mediumIconSize,
//           tooltip: 'Notifications',
//         ),
//       );
//     }

//     if (showAvatarIcon) {
//       icons.add(
//         _buildIconButton(
//           context: context,
//           asset: Assets.personfilled,
//           onTap: onAvatarTap,
//           size: _largeIconSize,
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           isAvatar: true,
//           tooltip: 'Profile',
//         ),
//       );
//     }

//     return icons;
//   }

//   Widget _buildTitle() {
//     if (title == null) return const SizedBox.shrink();
    
//     return MyText(
//       text: title!,
//       size: textSize,
//       color: kDynamicText(Get.context!),
//       weight: FontWeight.w700,
//       textAlign: textAlign ?? (_isRTL ? TextAlign.right : TextAlign.left),
//       maxLines: 1,
//       textOverflow: TextOverflow.ellipsis,
//     );
//   }

//   List<Widget> _buildActionIcons(BuildContext context) {
//     final optionalIcons = _buildOptionalIcons(context);
//     final customActions = actions ?? [];

//     if (_isRTL) {
//       return [...customActions, ...optionalIcons];
//     } else {
//       return [...optionalIcons, ...customActions];
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: kDynamicScaffoldBackground(context),
//       automaticallyImplyLeading: false,
//       centerTitle: centerTitle,
//       elevation: elevation,
//       shadowColor: kDynamicShadow(context),
//       leading: showLeading ? _buildBackButton(context) : null,
//       leadingWidth: showLeading ? 48 : 0, // Consistent leading width
//       titleSpacing: showLeading ? 0 : 16,
//       title: _buildTitle(),
//       actions: _buildActionIcons(context),
//     );
//   }
// }
// // ============================================================================
// // EXTENSION: Search AppBar (Optional - use when search is needed)
// // ============================================================================

// class SearchableAppBar extends StatefulWidget implements PreferredSizeWidget {
//   final String title;
//   final Function(String) onSearchChanged;
//   final List<Widget>? actions;
//   final VoidCallback? onBackTap;
//   final bool showLeading;
//   final String? searchHint;

//   const SearchableAppBar({
//     super.key,
//     required this.title,
//     required this.onSearchChanged,
//     this.actions,
//     this.onBackTap,
//     this.showLeading = false,
//     this.searchHint,
//   });

//   @override
//   State<SearchableAppBar> createState() => _SearchableAppBarState();

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

// class _SearchableAppBarState extends State<SearchableAppBar> {
//   bool _isSearching = false;
//   late final TextEditingController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController();
//     _controller.addListener(_onSearchChanged);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _onSearchChanged() => widget.onSearchChanged(_controller.text);

//   void _toggleSearch() {
//     setState(() {
//       _isSearching = !_isSearching;
//       if (!_isSearching) {
//         _controller.clear();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: kDynamicScaffoldBackground(context),
//       automaticallyImplyLeading: false,
//       leading: (_isSearching || widget.showLeading)
//           ? InkWell(
//               onTap: _isSearching
//                   ? _toggleSearch
//                   : (widget.onBackTap ?? Get.back),
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: CommonImageView(
//                   imagePath: Assets.arrowback,
//                   height: 16,
//                   color: kDynamicIcon(context),
//                 ),
//               ),
//             )
//           : null,
//       titleSpacing: 0,
//       title: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 300),
//         child: _isSearching
//             ? _buildSearchField(context)
//             : MyText(
//                 text: widget.title,
//                 size: 18,
//                 color: kDynamicText(context),
//                 weight: FontWeight.w700,
//               ),
//       ),
//       actions: _isSearching
//           ? null
//           : [
//               IconButton(
//                 icon: SvgPicture.asset(
//                   Assets.searchunfilled,
//                   height: 20,
//                   color: kDynamicIcon(context),
//                 ),
//                 onPressed: _toggleSearch,
//               ),
//               if (widget.actions != null) ...widget.actions!,
//             ],
//     );
//   }

//   Widget _buildSearchField(BuildContext context) {
//     return Container(
//       key: const ValueKey('searchField'),
//       margin: const EdgeInsets.only(right: 10, top: 26),
//       child: MyTextField(
//         controller: _controller,
//         keyboardType: TextInputType.text,
//         hint: widget.searchHint ?? 'Search ${widget.title}...',
//         prefix: SvgPicture.asset(
//           Assets.searchunfilled,
//           height: 20,
//           color: kDynamicIcon(context),
//         ),
//         suffix: _controller.text.isNotEmpty
//             ? Bounce(
//                 onTap: _controller.clear,
//                 child: Icon(
//                   Icons.clear,
//                   size: 20,
//                   color: kDynamicIcon(context),
//                 ),
//               )
//             : null,
//         autoFocus: true,
//       ),
//     );
//   }
// }
