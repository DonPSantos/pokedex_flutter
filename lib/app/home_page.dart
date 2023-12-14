import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_flutter/configurations/locator_setup.dart';
import 'package:pokedex_flutter/app/pokemon_list/pokemon_list_state.dart';
import 'package:pokedex_flutter/app/pokemon_list/pokemon_list_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _listener() => setState(() {});

  @override
  void initState() {
    super.initState();
    locator
        .isReady<PokemonListStore>()
        .then((_) => locator<PokemonListStore>().addListener(_listener));

    locator<PokemonListStore>().getPokemons();
  }

  @override
  void dispose() {
    locator<PokemonListStore>().removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Container();
    var state = locator<PokemonListStore>().state;

    if (state is LoadingPokemonListState) {
      body = const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is ErrorPokemonListState) {
      body = Center(
        child: ElevatedButton(
          onPressed: locator<PokemonListStore>().getPokemons,
          child: Text(state.message),
        ),
      );
    } else if (state is EmptyPokemonListState) {
      body = Center(
        child: ElevatedButton(
          onPressed: locator<PokemonListStore>().getPokemons,
          child: const Text('Toque aqui!'),
        ),
      );
    } else if (state is GettedPokemonListState) {
      print("Notificou");
      body = Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 200),
          child: ListView.builder(
            itemCount: state.filteredList.length,
            itemBuilder: (context, index) {
              final pokemon = state.filteredList[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: ClipRRect(
                      child: Image.network(pokemon.imgUrl),
                    ),
                  ),
                  title: Text(pokemon.name[0].toUpperCase() +
                      pokemon.name.substring(1)),
                ),
              );
            },
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                context.go('/detail/1');
              },
              child: const Text('Teste navegação detail')),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 300, vertical: 50),
            child: TextField(
              onChanged: (value) {
                locator<PokemonListStore>()
                    .getFilteredPokemons(value.toLowerCase());
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              ),
            ),
          ),
          body,
        ],
      ),
    );
  }
}
