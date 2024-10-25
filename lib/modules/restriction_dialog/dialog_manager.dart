import 'package:flutter/material.dart';
import 'package:online/modules/restriction_dialog/restrict_user_dialog.dart';

import 'loading_manager.dart';

/// `DialogManager` is a class that manages the display of dialogs in the application.
/// It uses a `LoadingManager` to listen for changes in the loading state and display or hide a restriction dialog accordingly.
class DialogManager {
  /// Creates a new instance of `DialogManager`.
  ///
  /// The constructor takes two parameters:
  /// - `_globalNavigationKey`: A `GlobalKey` for the `NavigatorState`. This is used to access the current `BuildContext`.
  /// - `_loadingManager`: An instance of `LoadingManager`. This is used to listen for changes in the loading state.
  ///
  /// @param _globalNavigationKey A `GlobalKey` for the `NavigatorState`.
  /// @param _loadingManager An instance of `LoadingManager`.
  DialogManager(
      this._globalNavigationKey,
      this._loadingManager,
      );

  /// A `GlobalKey` for the `NavigatorState`.
  /// This is used to access the current `BuildContext`.
  final GlobalKey<NavigatorState> _globalNavigationKey;

  /// An instance of `LoadingManager`.
  /// This is used to listen for changes in the loading state.
  final LoadingManager _loadingManager;

  /// A getter for the global context.
  /// Returns the current `BuildContext` from the `_globalNavigationKey`.
  BuildContext get _globalContext => _globalNavigationKey.currentState!.context;

  /// A method that initializes the `DialogManager`.
  ///
  /// This method listens for changes in the loading state from the `_loadingManager`.
  void init() {
    _loadingManager.loadingStream.listen(_onLoadingStateChanged);
  }

  /// A method that is called when the loading state changes.
  ///
  /// This method logs the new loading state and shows or hides the restriction alert dialog based on the new state.
  ///
  /// @param isLoading A boolean that represents the new loading state.
  void _onLoadingStateChanged(bool isLoading) {
    if (isLoading) {
      showRestrictionAlert(_globalContext);
    } else {
      hideRestrictionAlert(_globalContext);
    }
  }

  /// A method that hides the restriction alert dialog.
  ///
  /// This method is called when the loading state changes to false.
  /// It uses the `Navigator` to pop the restriction alert dialog from the navigation stack.
  ///
  /// @param context The `BuildContext` to use for the `Navigator`.
  void hideRestrictionAlert(BuildContext context) {
    Navigator.of(context).pop();
  }
}