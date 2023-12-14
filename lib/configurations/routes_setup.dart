import 'package:go_router/go_router.dart';
import 'package:pokedex_flutter/app/common/pages/not_found_page.dart';
import 'package:pokedex_flutter/app/home_page.dart';
import 'package:pokedex_flutter/app/pokemon_detail/pokemon_details_page.dart';

class RoutesSetup {
  final router = GoRouter(
    errorBuilder: ((context, state) => const NotFoundPage()),
    initialLocation: "/",
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/detail/:id',
        builder: (context, state) =>
            PokemonDetailsPage(pokemonId: state.pathParameters['id']!),
      ),
    ],
  );
}
