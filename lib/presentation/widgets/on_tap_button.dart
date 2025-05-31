import 'package:flutter/material.dart';

class OnTapButtonWidget extends StatelessWidget {
  const OnTapButtonWidget({
    super.key,
    this.onTap,
    this.size = 50,
    this.iconData,
  });

  final void Function()? onTap;
  final double size;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    assert(size > 0);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Icon(
          iconData ?? Icons.add_box_outlined,
          size: size * 0.6,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
