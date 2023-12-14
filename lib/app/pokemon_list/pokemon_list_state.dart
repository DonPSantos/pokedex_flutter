import 'package:pokedex_flutter/app/pokemon_list/pokemon_list_model.dart';

abstract class PokemonListState {
  List<PokemonListModel> fullList;
  final List<PokemonListModel> filteredList;
  PokemonListState({
    required this.fullList,
    required this.filteredList,
  });
}

class EmptyPokemonListState extends PokemonListState {
  EmptyPokemonListState()
      : super(fullList: List.empty(), filteredList: List.empty());
}

class LoadingPokemonListState extends PokemonListState {
  LoadingPokemonListState()
      : super(fullList: List.empty(), filteredList: List.empty());
}

class ErrorPokemonListState extends PokemonListState {
  final String message;

  ErrorPokemonListState({required this.message})
      : super(filteredList: List.empty(), fullList: List.empty());
}

class GettedPokemonListState extends PokemonListState {
  GettedPokemonListState(
      {required super.fullList, required super.filteredList});
}
