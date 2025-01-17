
import 'package:flutter/material.dart';

import '../../constants/dimension_custom.dart';
import '../../../model/coffee.dart';

class ImageCoffee extends StatelessWidget {
  const ImageCoffee({
    required this.itemCoffee,
    required this.height,
    required this.width,
    super.key,
  });

  final Coffee itemCoffee;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kDefaultPadding),
      child: SizedBox(
        height: height,
        width: width,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Image.asset(itemCoffee.imageAssets),
        ),
      ),
    );
  }
}