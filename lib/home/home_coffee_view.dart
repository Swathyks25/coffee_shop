import 'package:flutter/material.dart';
import '../../constants/dimension_custom.dart';
import '../../constants/text_custom.dart';
import '../../model/coffee.dart';
import '../../repositories/coffee_repository.dart';
import '../../strings/image_generic.dart';
import '../../strings/strings_generic.dart';
import '../../theme/app_colors.dart';
import '../../view/components/category_coffee.dart';
import '../../view/components/coffee_item.dart';

class HomeCoffeeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> imageList = [
      'image1.jpg',
      'image2.jpg',
      'image3.jpg',
    ];
    final activeCoffees = coffees.where((coffee) => coffee.isActive).toList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextCustom.h1(StringsGeneric.appName ?? ''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _news(context),
          _bestSellers(context, activeCoffees),
          CategoryCoffee(activeCoffees: activeCoffees),
        ],
      ),
    );
  }

  Container _news(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
      height: size.height * 0.18,
      width: size.width - 20,
      child: Container(
        child: Stack(
          children: [
            Positioned(
              top: 30,
              left: 20,
              child: SizedBox(
                height: 110,
                width: size.width * 0.70,
                child: TextCustom.body4(
                  StringsGeneric.phrase,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            Positioned(
              top: 85,
              left: 20,
              child: Container(
                width: 150,
                height: 35,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(kPaddingM),
                ),
                child: Center(
                  child: TextCustom.body3(
                    StringsGeneric.offdiscount,
                  ),
                ),
              ),
            ),
            Positioned(
              right: -10,
              bottom: -10,
              child: SizedBox(
                height: 120,
                width: size.width * 0.3,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Image.asset(ImageGeneric.coffeeNews),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Column _bestSellers(
  BuildContext context,
  List<Coffee> items,
) {
  final size = MediaQuery.of(context).size;
  final bestCoffees = items.where((coffee) => coffee.bestSellers).toList();
  return Column(
    children: [
      gap,
      TextCustom.body4(StringsGeneric.bestSellers),
      gapM,
      SizedBox(
        height: size.height * 0.27,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: bestCoffees.length,
          itemBuilder: (context, index) {
            final coffee = bestCoffees[index];
            return CoffeeItem(itemCoffee: coffee);
          },
        ),
      ),
    ],
  );
}
