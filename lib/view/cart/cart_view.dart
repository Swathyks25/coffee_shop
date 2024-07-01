
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/product_bloc.dart';
import '../../bloc/product_state.dart';
import '../../constants/dimension_custom.dart';
import '../../constants/text_custom.dart';
import '../../strings/image_generic.dart';
import '../../routes/routes_path.dart';
import '../../strings/strings_generic.dart';
import '../../../theme/app_colors.dart';
import '../components/coffee_cart.dart';
import '../components/price.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextCustom.h1(StringsGeneric.cartTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _itemCart(),
          _payment(size),
        ],
      ),
    );
  }

  Expanded _itemCart() {
    return Expanded(
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          final productsList = state.products;
          if (state is ProductSuccessState && productsList.isNotEmpty) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(kPaddingXL),
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: productsList.length,
                  itemBuilder: (context, index) {
                    return CoffeeCart(
                      itemProduct: productsList[index],
                    );
                  },
                ),
              ),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageGeneric.cartEmpty),
              TextCustom.h2(StringsGeneric.emptyCart),
            ],
          );
        },
      ),
    );
  }
}

ClipRRect _payment(Size size) {
  return ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(kPaddingXL),
      topRight: Radius.circular(kPaddingXL),
    ),
    child: BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state.products.isNotEmpty) {
          return Container(
            height: 160,
            color: AppColors.whiteColor,
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _valueRow(
                    StringsGeneric.subTotal,
                    formattedPrice(
                      valueProduct(state.products),
                    ),
                  ),
                  _valueRow(
                    StringsGeneric.discount,
                    formattedPrice(
                      valueProductDiscont(state.products),
                    ),
                  ),
                  _valueRow(
                    StringsGeneric.valueFinal,
                    formattedPrice(
                      valueProductFinal(state.products),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () async => GoRouter.of(context)
                          .push(RoutesGeneric.cartFinishRoute),
                      child: TextCustom.body(
                        StringsGeneric.finalizeOrder,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    ),
  );
}

Row _valueRow(String valueType, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TextCustom.body3(valueType),
      if (valueType == StringsGeneric.discount)
        TextCustom.body3('- $value', color: AppColors.greenColor)
      else
        TextCustom.body3(value),
    ],
  );
}