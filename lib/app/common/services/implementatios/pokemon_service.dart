import 'package:dio/dio.dart';
import 'package:pokedex_flutter/app/pokemon_detail/pokemon_datail_model.dart';
import 'package:pokedex_flutter/app/pokemon_list/pokemon_list_model.dart';
import 'package:pokedex_flutter/app/common/services/interfaces/ipokemon_service.dart';

class PokemonListService extends IPokemonService {
  final Dio dio;

  PokemonListService.PokemonService({required this.dio});

  Future<List<PokemonListModel>> getAll() async {
    List<PokemonListModel> finalPokemonList = List.empty(growable: true);

    final response =
        await dio.get('https://pokeapi.co/api/v2/pokemon/?limit=860');
    final list = response.data["results"] as List;
    final pokemonIncompletList =
        list.map((i) => PokemonListModel.fromJson(i)).toList();

    for (var pokemon in pokemonIncompletList) {
      var detailResponse = await dio.get(pokemon.url);
      finalPokemonList.add(PokemonListModel.fromJson(detailResponse.data));
    }

    return finalPokemonList;
  }

  Future<PokemonDetailModel> getById(int pokemonId) async {
    try {
      final response =
          await dio.get('https://pokeapi.co/api/v2/pokemon/$pokemonId');

      var pokemonDetail = PokemonDetailModel.fromJson(response.data);

      return pokemonDetail.copyWith(
          types: _getTypes(response), abilities: _getAbilities(response));
    } catch (e) {
      print(e.toString());
      return PokemonDetailModel.empty();
    }
  }

  List<String> _getAbilities(Response response) {
    var abilitiesList = response.data["abilities"] as List;
    List<String> abilitiesNames = List.empty(growable: true);

    for (var element in abilitiesList) {
      abilitiesNames.add(element["ability"]["name"]);
    }

    return abilitiesNames;
  }

  List<String> _getTypes(Response response) {
    var typesList = response.data["types"] as List;
    List<String> typesNames = List.empty(growable: true);

    for (var element in typesList) {
      typesNames.add(element["type"]["name"]);
    }

    return typesNames;
  }
}
