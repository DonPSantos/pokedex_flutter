import 'package:flutter/material.dart';
import 'package:pokedex_flutter/configurations/locator_setup.dart';
import 'package:pokedex_flutter/app/common/services/interfaces/ipokemon_service.dart';
import 'package:pokedex_flutter/app/pokemon_list/pokemon_list_state.dart';

class PokemonListStore extends ChangeNotifier {
  final service = locator.get<IPokemonService>();
  PokemonListState state = EmptyPokemonListState();

  getPokemons() async {
    state = LoadingPokemonListState();
    notifyListeners();

    try {
      final response = await service.getAll();

      state = GettedPokemonListState(
          fullList: response, filteredList: response.getRange(0, 9).toList());
      notifyListeners();
      print("Get Success");
    } catch (e) {
      state = ErrorPokemonListState(message: e.toString());
      notifyListeners();
    }
  }

  getFilteredPokemons(String name) async {
    if (name.length > 2) {
      var fixedList = state.fullList;
      var filter = state.fullList.where((e) => e.name.contains(name)).toList();
      state = GettedPokemonListState(
          fullList: state.fullList, filteredList: filter);
      notifyListeners();
    } else {
      state = GettedPokemonListState(
          fullList: state.fullList, filteredList: state.fullList);
      notifyListeners();
    }
  }
}
