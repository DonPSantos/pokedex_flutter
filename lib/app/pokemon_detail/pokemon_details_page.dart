import 'package:flutter/material.dart';
import 'package:pokedex_flutter/app/pokemon_detail/pokemon_detail_state.dart';
import 'package:pokedex_flutter/configurations/locator_setup.dart';
import 'package:pokedex_flutter/app/pokemon_detail/pokemon_detail_store.dart';

class PokemonDetailsPage extends StatefulWidget {
  final String pokemonId;
  const PokemonDetailsPage({super.key, required this.pokemonId});

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  final store = locator.get<PokemonDetailStore>();

  void _listener() => () {
        setState(() {});
      };
  @override
  void initState() {
    super.initState();
    store.addListener(_listener);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      store.getById(int.parse(widget.pokemonId));
    });
  }

  @override
  void dispose() {
    store.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var store = locator<PokemonDetailStore>();
    Widget body = Container();

    if (store.state is EmptyPokemonDetailState) {
      body = const Center(
        child: CircularProgressIndicator(),
      );
    } else if (store.state is GettedPokemonDetailState) {
      Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  child: Image.network(store.state.pokemon.urlFront),
                ),
                ClipRRect(
                  child: Image.network(store.state.pokemon.urlBack),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return body;
  }
}
