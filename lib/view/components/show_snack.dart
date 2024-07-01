
import 'package:flutter/material.dart';

import '../../constants/text_custom.dart';
import '../../../theme/app_colors.dart';

SnackBar showSnack(String text) {
  return SnackBar(
    backgroundColor: AppColors.brownCoffeeColor,
    content: Center(
      child: TextCustom.h2(
        text,
        color: AppColors.whiteColor,
      ),
    ),
  );
}