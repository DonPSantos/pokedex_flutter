import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_flutter/app/pokemon_list/pokemon_list_store.dart';
import 'package:pokedex_flutter/configurations/locator_setup.dart';
import 'package:pokedex_flutter/app/pokemon_list/pokemon_list_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokemonListStore store = locator<PokemonListStore>();
  @override
  void initState() {
    super.initState();
    store.getPokemons();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon'),
      ),
      body: AnimatedBuilder(
        animation: store,
        builder: (context, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: (s.width * 0.2),
                ),
                child: TextField(
                  onChanged: (value) {
                    store.getFilteredPokemons(value.toLowerCase());
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
              if (store.state is GettedPokemonListState)
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: (s.width * 0.15),
                    ),
                    child: ListView.builder(
                      itemCount: store.state.filteredList.length,
                      itemBuilder: (context, index) {
                        final pokemon = store.state.filteredList[index];
                        return Card(
                          child: ListTile(
                            onTap: () => context.go('/detail/${pokemon.id}'),
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
                ),
              if (store.state is LoadingPokemonListState)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
    );
  }
}
