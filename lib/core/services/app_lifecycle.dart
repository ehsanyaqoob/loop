import 'package:loop/export.dart';

class AppLifecycleProvider with ChangeNotifier, WidgetsBindingObserver {
  AppLifecycleState _currentState = AppLifecycleState.resumed;
  bool _isInForeground = true;

  AppLifecycleState get currentState => _currentState;
  bool get isInForeground => _isInForeground;

  AppLifecycleProvider() {
    WidgetsBinding.instance.addObserver(this);
    debugPrint('🔄 AppLifecycleProvider initialized');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _currentState = state;
    
    switch (state) {
      case AppLifecycleState.resumed:
        _isInForeground = true;
        debugPrint('🎯 App Resumed');
        break;
      case AppLifecycleState.inactive:
        _isInForeground = false;
        debugPrint('⚡ App Inactive');
        break;
      case AppLifecycleState.paused:
        _isInForeground = false;
        debugPrint('⏸️ App Paused');
        break;
      case AppLifecycleState.detached:
        debugPrint('🔴 App Detached');
        break;
      case AppLifecycleState.hidden:
        _isInForeground = false;
        debugPrint('👻 App Hidden');
        break;
    }
    
    notifyListeners();
  }
}