
import 'package:flutter/material.dart';

import '../../constants/dimension_custom.dart';
import '../../../theme/app_colors.dart';

class BorderContainer extends StatelessWidget {
  const BorderContainer({
    required this.child,
    super.key,
    this.color = AppColors.blackColor,
    this.size = 60.0,
  });

  final Widget child;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPaddingXS),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          kDefaultPadding,
        ),
        child: Container(
          height: size,
          width: size,
          color: color.withOpacity(0.5),
          child: Center(child: child),
        ),
      ),
    );
  }
}