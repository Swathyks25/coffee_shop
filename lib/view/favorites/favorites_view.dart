
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/favorites_bloc.dart';
import '../../bloc/favorites_state.dart';
import '../../constants/dimension_custom.dart';
import '../../constants/text_custom.dart';
import '../../strings/image_generic.dart';
import '../../strings/strings_generic.dart';
import '../components/coffe_item_type.dart';
import '../components/favorites_button.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextCustom.h1(StringsGeneric.favoritesTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
                final favoritesList = state.coffee;
                if (state is FavoritesSuccessState && state.coffee.isNotEmpty) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(kPaddingXL),
                    child: SizedBox(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: favoritesList.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              CoffeeItemType(
                                itemCoffee: favoritesList[index],
                              ),
                              Positioned(
                                right: 10,
                                bottom: 10,
                                // bottom: 0,
                                child: FavoritesButton(
                                  itemCoffees: favoritesList[index],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(ImageGeneric.favoritesEmpty),
                    TextCustom.h2(StringsGeneric.emptyFavorites),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}