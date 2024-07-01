
import 'package:flutter/material.dart';

import '../../constants/dimension_custom.dart';
import '../../constants/text_custom.dart';
import '../../repositories/coffee_repository.dart';
import '../../strings/strings_generic.dart';
import '../components/coffe_item_type.dart';

class OfferView extends StatelessWidget {
  const OfferView({super.key});

  @override
  Widget build(BuildContext context) {
    final typesToFind = <String>[
      StringsGeneric.cappuccino,
      StringsGeneric.espresso,
    ];
    final offerCoffee = coffees
        .where(
          (coffee) =>
              coffee.isActive && typesToFind.contains(coffee.beverageType),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextCustom.h1(StringsGeneric.offerTitle),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.circular(kPaddingXL),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: offerCoffee.length,
          itemBuilder: (context, index) {
            final coffee = offerCoffee[index];
            return CoffeeItemType(itemCoffee: coffee);
          },
        ),
      ),
    );
  }
}