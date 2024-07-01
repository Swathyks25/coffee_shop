import 'package:go_router/go_router.dart';
import '../home/home_coffee_view.dart';
import '../home/home_view.dart';
import 'routes_path.dart';
import '../view/cart/cart_finish_view.dart';
import '../view/cart/cart_view.dart';
import '../view/coffee_view.dart';
import '../view/favorites/favorites_view.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      name: RoutesGeneric.homeName,
      path: RoutesGeneric.homeRoute,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      name: RoutesGeneric.homeCoffeeName,
      path: RoutesGeneric.homeCoffeeRoute,
      builder: (context, state) => HomeCoffeeView(),
    ),
    GoRoute(
      name: RoutesGeneric.coffeeViewName,
      path: '${RoutesGeneric.coffeeViewRoute}:id',
      builder: (context, state) => CoffeeView(
        idCoffe: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      name: RoutesGeneric.favoritesName,
      path: RoutesGeneric.favoritesRoute,
      builder: (context, state) => const FavoritesView(),
    ),
    GoRoute(
      name: RoutesGeneric.cartName,
      path: RoutesGeneric.cartRoute,
      builder: (context, state) => const CartView(),
    ),
    GoRoute(
      name: RoutesGeneric.cartFinishName,
      path: RoutesGeneric.cartFinishRoute,
      builder: (context, state) => const CartFinishView(),
    ),
  ],
);
