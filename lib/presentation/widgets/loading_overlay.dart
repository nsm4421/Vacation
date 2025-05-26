import 'package:flutter/material.dart';

class LoadingOverlayWidget extends StatelessWidget {
  const LoadingOverlayWidget(
      {super.key, this.message, this.showOverlay = false, required this.child});

  final String? message;
  final bool showOverlay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (showOverlay)
          Positioned.fill(
            child: Container(
              color: Colors.black.withAlpha(40),
              alignment: Alignment.center,
              child: Container(
                width: 280,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const LinearProgressIndicator(),
                    const SizedBox(height: 16),
                    if (message != null)
                      Text(message!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: Colors.white)),
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }
}
