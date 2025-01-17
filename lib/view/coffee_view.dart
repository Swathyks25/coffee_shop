
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../bloc/product_bloc.dart';
import '../bloc/product_events.dart';
import '../bloc/product_state.dart';
import '../constants/dimension_custom.dart';
import '../constants/text_custom.dart';
import '../../model/coffee.dart';
import '../../model/product.dart';
import '../repositories/coffee_repository.dart';
import '../strings/image_generic.dart';
import '../routes/routes_path.dart';
import '../strings/strings_generic.dart';
import '../../theme/app_colors.dart';
import 'components/border_container.dart';
import 'components/favorites_button.dart';
import 'components/price.dart';

class CoffeeView extends StatefulWidget {
  const CoffeeView({
    required this.idCoffe,
    super.key,
  });

  final String idCoffe;

  @override
  State<CoffeeView> createState() => _CoffeeViewState();
}

class _CoffeeViewState extends State<CoffeeView> {
  String _selectedSize = StringsGeneric.medium;
  double _valueSize = 1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final itemCoffees = coffees
        .where((coffee) => coffee.id.toString() == widget.idCoffe)
        .toList()
        .first;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _coffeeContent(size, itemCoffees, context),
          _description(itemCoffees),
          _buy(itemCoffees, size),
        ],
      ),
    );
  }

  SizedBox _coffeeContent(
    Size size,
    Coffee itemCoffees,
    BuildContext context,
  ) {
    final intensity = itemCoffees.intensity;

    return SizedBox(
      height: size.height * 0.60,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(kPaddingXL),
                bottomRight: Radius.circular(kPaddingXL),
              ),
              child: SizedBox(
                height: size.height * 0.60,
                width: size.width,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.asset(itemCoffees.imageAssets),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(kPadding),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(context),
                    child: const BorderContainer(
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await GoRouter.of(context).push(RoutesGeneric.cartRoute);
                    },
                    child: Stack(
                      children: [
                        const BorderContainer(
                          child: Icon(
                            Icons.shopping_bag,
                            color: AppColors.whiteColor,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: BlocBuilder<ProductBloc, ProductState>(
                            builder: (context, state) {
                              if (state is ProductInitialState) {
                                return Container();
                              } else if (state is ProductSuccessState) {
                                return SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: BorderContainer(
                                    child: TextCustom.body(
                                      color: AppColors.whiteColor,
                                      state.products.length.toString(),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            left: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                kPaddingXL,
              ),
              child: Container(
                height: 180,
                color: AppColors.blackColor.withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Expanded(child: TextCustom.h3(itemCoffees.name)),
                          FavoritesButton(itemCoffees: itemCoffees),
                        ],
                      ),
                      TextCustom.h2(
                        itemCoffees.beverageType,
                        color: AppColors.grayColor,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: AppColors.yellowColor,
                            size: 30,
                          ),
                          Expanded(
                            child: TextCustom.h3(
                              itemCoffees.rating.toString(),
                            ),
                          ),
                          BorderContainer(
                            size: 40,
                            color: AppColors.whiteColor,
                            child: SvgPicture.asset(
                              ImageGeneric.graoIcon,
                              height: 30,
                              width: 30,
                            ),
                          ),
                          BorderContainer(
                            size: 40,
                            color: AppColors.whiteColor,
                            child: TextCustom.h1(
                              intensity.toString(),
                              color: intensity >= 7
                                  ? AppColors.redColor
                                  : AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _description(Coffee itemCoffees) {
    return Padding(
      padding: const EdgeInsets.only(
        left: kPaddingXL,
        right: kPaddingXL,
      ),
      child: Column(
        children: [
          TextCustom.h1(StringsGeneric.description),
          gap,
          TextCustom.body(itemCoffees.description),
        ],
      ),
    );
  }

  Column _buy(Coffee coffee, Size size) {
    void addToCart(Product product) {
      context.read<ProductBloc>().add(AddProductEvent(product: product));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton(StringsGeneric.small, 0.8),
              _buildButton(StringsGeneric.medium, 1),
              _buildButton(StringsGeneric.big, 1.2),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(kPaddingXL),
            topRight: Radius.circular(kPaddingXL),
          ),
          child: Container(
            height: size.height * 0.15,
            color: AppColors.whiteColor,
            child: Padding(
              padding: const EdgeInsets.all(kPaddingM),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextCustom.h1(
                        formattedPrice(
                          finalDiscount(coffee) * _valueSize,
                        ),
                      ),
                      if (finalDiscount(coffee) != coffee.price)
                        TextCustom.discount(
                          formattedPrice(coffee.price * _valueSize),
                        )
                      else
                        Container(),
                    ],
                  ),
                  SizedBox(
                    height: 80,
                    width: 220,
                    child: ElevatedButton(
                      onPressed: () {
                        addToCart(
                          Product(
                            coffee: Coffee(
                              id: coffee.id,
                              name: coffee.name,
                              intensity: coffee.intensity,
                              beverageType: coffee.beverageType,
                              price: coffee.price * _valueSize,
                              isActive: coffee.isActive,
                              bestSellers: coffee.bestSellers,
                              imageAssets: coffee.imageAssets,
                              description: coffee.description,
                              rating: coffee.rating,
                            ),
                            size: _selectedSize,
                          ),
                        );
                      },
                      child: TextCustom.h4(
                        StringsGeneric.addCart,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  ElevatedButton _buildButton(String size, double valueSize) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedSize = size;
          _valueSize = valueSize;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedSize == size
            ? AppColors.whiteColor
            : AppColors.brownCoffeeColor,
      ),
      child: TextCustom.body4(
        size,
        color: _selectedSize == size
            ? AppColors.brownCoffeeColor
            : AppColors.whiteColor,
      ),
    );
  }
}