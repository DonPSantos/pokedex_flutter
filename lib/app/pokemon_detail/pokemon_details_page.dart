import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_flutter/app/pokemon_detail/pokemon_detail_state.dart';
import 'package:pokedex_flutter/app/pokemon_detail/widgets/detail_card_widget.dart';
import 'package:pokedex_flutter/configurations/locator_setup.dart';
import 'package:pokedex_flutter/app/pokemon_detail/pokemon_detail_store.dart';

class PokemonDetailsPage extends StatefulWidget {
  final String pokemonId;
  const PokemonDetailsPage({super.key, required this.pokemonId});

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  final PokemonDetailStore store = locator.get<PokemonDetailStore>();

  @override
  void initState() {
    super.initState();
    store.state = EmptyPokemonDetailState();
    store.getById(int.parse(widget.pokemonId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          child: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go("/");
          },
        ),
        title: const Text("Back"),
      ),
      body: AnimatedBuilder(
        animation: store,
        builder: (context, child) {
          return ListView(
            children: [
              if (store.state is EmptyPokemonDetailState)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              if (store.state is GettedPokemonDetailState)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
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
                    Wrap(
                      spacing: 20,
                      alignment: WrapAlignment.center,
                      direction: Axis.horizontal,
                      children: [
                        DetailCardWidget(
                            title: "Tipos",
                            propsList: store.state.pokemon.types),
                        DetailCardWidget(
                            title: "Habilidades",
                            propsList: store.state.pokemon.abilities),
                      ],
                    ),
                  ],
                )
            ],
          );
        },
      ),
    );
  }
}
