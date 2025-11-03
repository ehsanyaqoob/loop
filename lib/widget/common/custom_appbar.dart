
import 'package:loop/export.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackTap;
  final bool centerTitle;
  final bool showLeading;
  final double textSize;
  final TextAlign? textAlign;
  final bool showNotificationIcon;
  final bool showAvatarIcon;
  final bool showBasketIcon;
  final bool showMessageIcon;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onBasketTap;
  final VoidCallback? onMessageTap;
  final double elevation;
  final Color? backButtonColor;
  final String? subtitle;
  final String? logoUrl;
  final bool showShareIcon;
  final VoidCallback? onShareTap;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.onBackTap,
    this.centerTitle = true,
    this.showLeading = false,
    this.textSize = 18,
    this.textAlign,
    this.showNotificationIcon = false,
    this.showAvatarIcon = false,
    this.showBasketIcon = false,
    this.showMessageIcon = false,
    this.onNotificationTap,
    this.onAvatarTap,
    this.onBasketTap,
    this.onMessageTap,
    this.elevation = 0,
    this.backButtonColor,
    this.subtitle,
    this.logoUrl,
    this.showShareIcon = false,
    this.onShareTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  Widget _buildBackButton(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: context.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: onBackTap ?? () => Navigator.of(context).pop(),
        icon: Icon(
          Icons.arrow_back,
          color: backButtonColor ?? context.primary,
          size: 20,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildIconButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback? onTap,
    required double size,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 4),
    bool isAvatar = false,
    String? tooltip,
  }) {
    return Padding(
      padding: padding,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: context.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          onPressed: onTap,
          icon: Icon(
            icon,
            size: size,
            color: context.primary,
          ),
          padding: EdgeInsets.zero,
          tooltip: tooltip,
        ),
      ),
    );
  }

  List<Widget> _buildOptionalIcons(BuildContext context) {
    final icons = <Widget>[];

    if (showMessageIcon) {
      icons.add(
        _buildIconButton(
          context: context,
          icon: Icons.message,
          onTap: onMessageTap,
          size: 20,
          tooltip: 'Messages',
        ),
      );
    }

    if (showNotificationIcon) {
      icons.add(
        _buildIconButton(
          context: context,
          icon: Icons.notifications,
          onTap: onNotificationTap,
          size: 20,
          tooltip: 'Notifications',
        ),
      );
    }

    if (showAvatarIcon) {
      icons.add(
        _buildIconButton(
          context: context,
          icon: Icons.person,
          onTap: onAvatarTap,
          size: 20,
          tooltip: 'Profile',
        ),
      );
    }

    if (showShareIcon) {
      icons.add(
        _buildIconButton(
          context: context,
          icon: Icons.share,
          onTap: onShareTap,
          size: 20,
          tooltip: 'Share',
        ),
      );
    }

    return icons;
  }

  Widget _buildLogo(BuildContext context) {
    if (logoUrl == null) return const SizedBox.shrink();
    
    return Container(
      width: 52,
      height: 52,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: CommonImageView(
        url: logoUrl!,
        fit: BoxFit.contain,
        radius: 8,
      ),
    );
  }

  Widget _buildTitleWithSubtitle(BuildContext context) {
    if (title == null) return const SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: title!,
          size: textSize,
          color: context.text,
          weight: FontWeight.w700,
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
        ),
        if (subtitle != null) ...[
          const Gap(6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: context.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on, color: context.primary, size: 12),
                const Gap(4),
                MyText(
                  text: subtitle!,
                  color: context.primary,
                  size: 12,
                  weight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSimpleTitle(BuildContext context) {
    if (title == null) return const SizedBox.shrink();
    
    return MyText(
      text: title!,
      size: textSize,
      color: context.text,
      weight: FontWeight.w700,
      textAlign: textAlign,
      maxLines: 1,
      textOverflow: TextOverflow.ellipsis,
    );
  }

  List<Widget> _buildActionIcons(BuildContext context) {
    final optionalIcons = _buildOptionalIcons(context);
    final customActions = actions ?? [];
    return [...optionalIcons, ...customActions];
  }

  Widget _buildLeagueStyleHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: context.scaffoldBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (showLeading) _buildBackButton(context),
          if (showLeading && logoUrl != null) const Gap(16),
          if (logoUrl != null) _buildLogo(context),
          if (logoUrl != null) const Gap(16),
          Expanded(
            child: _buildTitleWithSubtitle(context),
          ),
          ..._buildActionIcons(context),
        ],
      ),
    );
  }

  Widget _buildStandardHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: context.scaffoldBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (showLeading) _buildBackButton(context),
          if (showLeading) const Gap(16),
          Expanded(
            child: Center(
              child: _buildSimpleTitle(context),
            ),
          ),
          if (showLeading) const SizedBox(width: 44),
          ..._buildActionIcons(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasLogoOrSubtitle = logoUrl != null || subtitle != null;
    
    return hasLogoOrSubtitle 
        ? _buildLeagueStyleHeader(context)
        : _buildStandardHeader(context);
  }
}