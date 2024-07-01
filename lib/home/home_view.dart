import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../constants/dimension_custom.dart';
import '../../strings/strings_generic.dart';
import '../../theme/app_colors.dart';
import '../../view/cart/cart_view.dart';
import '../../view/favorites/favorites_view.dart';
import '../../view/offer/offer_view.dart';
import 'home_coffee_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final currentPage = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigation(context, pageController),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          HomeCoffeeView(),
          FavoritesView(),
          CartView(),
          OfferView(),
        ],
      ),
    );
  }
}

Padding _bottomNavigation(BuildContext context, PageController pageController) {
  return Padding(
    padding: const EdgeInsets.all(kPaddingS),
    child: ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(kPaddingXL),
      ),
      child: GNav(
        backgroundColor: AppColors.whiteColor,
        tabBackgroundColor: AppColors.brownCoffeeColor,
        padding: const EdgeInsets.all(kPadding * 2),
        onTabChange: (index) async {
          await pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
        gap: 8,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: StringsGeneric.homeTitle,
            iconActiveColor: AppColors.whiteColor,
            textColor: AppColors.whiteColor,
          ),
          GButton(
            icon: Icons.favorite,
            text: StringsGeneric.favoritesTitle,
            iconActiveColor: AppColors.whiteColor,
            textColor: AppColors.whiteColor,
          ),
          GButton(
            icon: Icons.shopping_bag,
            text: StringsGeneric.cartTitle,
            iconActiveColor: AppColors.whiteColor,
            textColor: AppColors.whiteColor,
          ),
          GButton(
            icon: Icons.discount,
            text: StringsGeneric.offerTitle,
            iconActiveColor: AppColors.whiteColor,
            textColor: AppColors.whiteColor,
          ),
        ],
      ),
    ),
  );
}
