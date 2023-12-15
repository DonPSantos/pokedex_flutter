import 'package:flutter/material.dart';
import 'package:pokedex_flutter/configurations/locator_setup.dart';
import 'package:pokedex_flutter/app/common/services/interfaces/ipokemon_service.dart';
import 'package:pokedex_flutter/app/pokemon_detail/pokemon_detail_state.dart';

class PokemonDetailStore extends ChangeNotifier {
  final _service = locator.get<IPokemonService>();
  PokemonDetailState state = EmptyPokemonDetailState();
  notifyListeners();

  getById(int id) async {
    try {
      final response = await _service.getById(id);
      state = GettedPokemonDetailState(pokemon: response);
      notifyListeners();
    } catch (e) {
      // state = ErrorPokemonListState(message: e.toString());
      print(e.toString());
    }
  }
}
