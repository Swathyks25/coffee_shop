
import 'package:coffee_shop/routes/routes.dart';
import 'package:coffee_shop/strings/strings_generic.dart';
import 'package:coffee_shop/theme/app_theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // var StringsGeneric;
    // var AppTheme;
    // var routes;
     return MaterialApp.router(
      title: StringsGeneric.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerDelegate: routes.routerDelegate,
      routeInformationParser: routes.routeInformationParser,
      routeInformationProvider: routes.routeInformationProvider,
    );
  }
}