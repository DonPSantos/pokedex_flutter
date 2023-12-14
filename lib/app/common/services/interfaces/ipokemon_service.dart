import 'package:pokedex_flutter/app/pokemon_detail/pokemon_datail_model.dart';
import 'package:pokedex_flutter/app/pokemon_list/pokemon_list_model.dart';

abstract class IPokemonService {
  Future<List<PokemonListModel>> getAll();

  Future<PokemonDetailModel> getById(int pokemonId);
}
