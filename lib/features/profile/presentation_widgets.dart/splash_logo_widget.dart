
import 'package:loop/export.dart';
class SplashLogoWidget extends StatelessWidget {
  final bool isDarkMode;
  final double size;

  const SplashLogoWidget({
    Key? key,
    required this.isDarkMode,
    this.size = 120,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // You can replace this with your actual logo
        // For now, using a placeholder with Flutter's logo
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.primary : AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: const Icon(
            Icons.loop_rounded,
            color: Colors.white,
            size: 60,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          AppConstants.appName,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: isDarkMode 
                    ? AppColors.darkTextPrimary 
                    : AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Connect • Share • Loop',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isDarkMode 
                    ? AppColors.darkTextSecondary 
                    : AppColors.textSecondary,
              ),
        ),
      ],
    );
  }
}