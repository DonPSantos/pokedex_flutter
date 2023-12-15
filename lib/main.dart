import 'package:flutter/material.dart';
import 'package:pokedex_flutter/configurations/locator_setup.dart';
import 'package:pokedex_flutter/configurations/routes_setup.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp.router(
      routerConfig: RoutesSetup().router,
      title: 'Pokedex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
