
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/dimension_custom.dart';
import '../../constants/text_custom.dart';
import '../../../model/coffee.dart';
import '../../routes/routes_path.dart';
import '../../../theme/app_colors.dart';
import 'image_coffee.dart';
import 'price.dart';

class CoffeeItem extends StatelessWidget {
  const CoffeeItem({
    required this.itemCoffee,
    super.key,
  });

  final Coffee itemCoffee;

  @override
  Widget build(BuildContext context) {
    final realPrice = finalPrice(itemCoffee);
    final discountMessage = textDiscount(itemCoffee);

    return GestureDetector(
      onTap: () async => GoRouter.of(context)
          .push('${RoutesGeneric.coffeeViewRoute}${itemCoffee.id}'),
      child: Padding(
        padding: const EdgeInsets.all(kPaddingM),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(kDefaultPadding),
          child: Container(
            height: 200,
            width: 130,
            color: AppColors.whiteColor,
            child: Padding(
              padding: const EdgeInsets.all(kPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ImageCoffee(
                        itemCoffee: itemCoffee,
                        height: 115,
                        width: 130,
                      ),
                      Positioned(
                        right: 3,
                        top: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(kPaddingM),
                          child: Container(
                            width: 50,
                            color: AppColors.whiteColor,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: AppColors.yellowColor,
                                  size: 20,
                                ),
                                TextCustom.h4(
                                  itemCoffee.rating.toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  gapM,
                  TextCustom.body(itemCoffee.name),
                  gapS,
                  TextCustom.description(itemCoffee.beverageType),
                  gapM,
                  Row(
                    children: [
                      TextCustom.body(realPrice),
                      gapM,
                      TextCustom.sale(discountMessage),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}