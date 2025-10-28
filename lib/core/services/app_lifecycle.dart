import 'package:loop/export.dart';

/// Represents different lifecycle states of the app.
enum AppLifecycleStatus {
  resumed,
  inactive,
  paused,
  detached,
  hidden,
}

/// A ChangeNotifier that listens to and exposes app lifecycle events globally.
class AppLifecycleProvider extends ChangeNotifier with WidgetsBindingObserver {
  AppLifecycleStatus _status = AppLifecycleStatus.resumed;

  AppLifecycleStatus get status => _status;
  bool get isForeground => _status == AppLifecycleStatus.resumed;
  bool get isPaused => _status == AppLifecycleStatus.paused;
  bool get isInactive => _status == AppLifecycleStatus.inactive;
  bool get isDetached => _status == AppLifecycleStatus.detached;
  bool get isHidden => _status == AppLifecycleStatus.hidden;

  AppLifecycleProvider() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _status = AppLifecycleStatus.resumed;
        _onAppResumed();
        break;
      case AppLifecycleState.inactive:
        _status = AppLifecycleStatus.inactive;
        _onAppInactive();
        break;
      case AppLifecycleState.paused:
        _status = AppLifecycleStatus.paused;
        _onAppPaused();
        break;
      case AppLifecycleState.detached:
        _status = AppLifecycleStatus.detached;
        _onAppDetached();
        break;
      case AppLifecycleState.hidden:
        _status = AppLifecycleStatus.hidden;
        _onAppHidden();
        break;
    }
    notifyListeners();
  }

  /// Custom callbacks — you can perform actions here that should
  /// happen across the app lifecycle (save data, restore, etc.)
  void _onAppResumed() {
    debugPrint('🔄 App resumed - restoring state');
  }

  void _onAppInactive() {
    debugPrint('⏸️ App inactive - temporary save');
  }

  void _onAppPaused() {
    debugPrint('🚫 App paused - persist important data');
  }

  void _onAppDetached() {
    debugPrint('💀 App detached - final cleanup');
  }

  void _onAppHidden() {
    debugPrint('👻 App hidden - background mode');
  }

  /// Force manual save if needed
  void forceSaveState() {
    debugPrint('💾 Force saving app state');
  }
}

/// A wrapper widget that listens for lifecycle changes and triggers callbacks.
class StateAwareWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback? onResume;
  final VoidCallback? onPause;
  final VoidCallback? onInactive;

  const StateAwareWidget({
    super.key,
    required this.child,
    this.onResume,
    this.onPause,
    this.onInactive,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLifecycleProvider>(
      builder: (context, lifecycle, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _handleLifecycleState(lifecycle.status);
        });
        return child;
      },
    );
  }

  void _handleLifecycleState(AppLifecycleStatus status) {
    switch (status) {
      case AppLifecycleStatus.resumed:
        onResume?.call();
        break;
      case AppLifecycleStatus.paused:
        onPause?.call();
        break;
      case AppLifecycleStatus.inactive:
        onInactive?.call();
        break;
      default:
        break;
    }
  }
}
