
import 'package:coffee_shop/bloc/favorites_bloc.dart';
import 'package:coffee_shop/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';

void main() => runApp(const MyApp(

));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
        BlocProvider(
          create: (context) => FavoritesBloc(),
        ),
      ],
      child: const App(),
    );
  }
}