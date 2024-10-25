import 'dart:async';

/// `LoadingManager` is a class that manages the loading state of an application.
/// It uses a `StreamController` to emit the loading state to any listeners.
class LoadingManager {
  // A `StreamController` that manages the loading state.
  final _loadingStreamController = StreamController<bool>();

  // A boolean value that represents whether the loading state is showing.
  bool isShowing = false;

  /// A getter for the loading stream.
  /// Returns a `Stream<bool>` that emits the current loading state.
  Stream<bool> get loadingStream => _loadingStreamController.stream;

  /// A method that sets the loading state to true, indicating that loading is showing.
  void showLoading() => _setLoading(true);

  /// A method that sets the loading state to false, indicating that loading is not showing.
  void hideLoading() => _setLoading(false);

  /// A private method that sets the loading state.
  /// It updates the `isShowing` boolean and adds the new state to the `_loadingStreamController`.
  ///
  /// @param isLoading A boolean that represents the new loading state.
  void _setLoading(bool isLoading) {
    isShowing = isLoading;
    _loadingStreamController.add(isLoading);
  }
}