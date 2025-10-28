import 'package:loop/export.dart';

enum ViewState { idle, busy, error, success, empty }

abstract class BaseController with ChangeNotifier {
  ViewState _state = ViewState.idle;
  String? _errorMessage;

  ViewState get state => _state;
  String? get errorMessage => _errorMessage;
  bool get isBusy => _state == ViewState.busy;
  bool get isIdle => _state == ViewState.idle;
  bool get hasError => _state == ViewState.error;
  bool get isSuccess => _state == ViewState.success;
  bool get isEmpty => _state == ViewState.empty;

  void setState(ViewState newState, {String? errorMessage}) {
    _state = newState;
    _errorMessage = errorMessage;
    notifyListeners();
  }

  void setBusy() => setState(ViewState.busy);
  void setIdle() => setState(ViewState.idle);
  void setError(String message) => setState(ViewState.error, errorMessage: message);
  void setSuccess() => setState(ViewState.success);
  void setEmpty() => setState(ViewState.empty);

  Future<void> runAsyncOperation(
    Future<void> Function() operation, {
    bool showBusy = true,
  }) async {
    try {
      if (showBusy) setBusy();
      await operation();
      setIdle();
    } catch (e) {
      setError(e.toString());
      rethrow;
    }
  }
}

abstract class LoaderState {
  ViewState state = ViewState.idle;
  ViewState get viewState => state;
  void setState(ViewState state);
}