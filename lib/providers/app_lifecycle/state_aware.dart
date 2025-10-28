
import 'package:loop/export.dart';

class StateAwareWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback? onResume;
  final VoidCallback? onPause;
  final VoidCallback? onInactive;
  final VoidCallback? onDetached;

  const StateAwareWidget({
    super.key,
    required this.child,
    this.onResume,
    this.onPause,
    this.onInactive,
    this.onDetached,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLifecycleProvider>(
      builder: (context, lifecycleProvider, child) {
        // Use the current state from provider
        _handleLifecycleState(lifecycleProvider.currentState);
        
        return child!;
      },
      child: child,
    );
  }

  void _handleLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResume?.call();
        break;
      case AppLifecycleState.paused:
        onPause?.call();
        break;
      case AppLifecycleState.inactive:
        onInactive?.call();
        break;
      case AppLifecycleState.detached:
        onDetached?.call();
        break;
      default:
        break;
    }
  }
}