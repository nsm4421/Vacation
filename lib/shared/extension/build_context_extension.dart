import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  _showSnackBar({
    required BuildContext context,
    required String message,
    required Color bgColor,
    TextStyle? textStyle,
    bool showCloseIcon = true,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: textStyle),
        showCloseIcon: showCloseIcon,
        backgroundColor: bgColor,
        duration: duration ?? Duration(seconds: 2),
      ),
    );
  }

  showSuccessSnackBar(String message, {bool showCloseIcon = true}) async {
    await _showSnackBar(
      context: this,
      message: message,
      bgColor: Theme.of(this).colorScheme.primaryContainer,
      textStyle: Theme.of(this).textTheme.bodyMedium?.copyWith(
        color: Theme.of(this).colorScheme.onPrimaryContainer,
      ),
      showCloseIcon: showCloseIcon,
    );
  }

  showErrorSnackBar(String message, {bool showCloseIcon = true}) async {
    await _showSnackBar(
      context: this,
      message: message,
      bgColor: Theme.of(this).colorScheme.errorContainer,
      textStyle: Theme.of(this).textTheme.bodyMedium?.copyWith(
        color: Theme.of(this).colorScheme.onErrorContainer,
      ),
      showCloseIcon: showCloseIcon,
    );
  }

  unfocus() => FocusScope.of(this).unfocus();
}
