import 'package:pokedex_flutter/app/pokemon_detail/pokemon_datail_model.dart';

class PokemonDetailState {
  final PokemonDetailModel pokemon;

  PokemonDetailState({required this.pokemon});
}

class EmptyPokemonDetailState extends PokemonDetailState {
  EmptyPokemonDetailState() : super(pokemon: PokemonDetailModel.empty());
}

class GettedPokemonDetailState extends PokemonDetailState {
  GettedPokemonDetailState({required super.pokemon});
}
