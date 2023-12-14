import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex_flutter/app/common/services/implementatios/pokemon_service.dart';
import 'package:pokedex_flutter/app/common/services/interfaces/ipokemon_service.dart';
import 'package:pokedex_flutter/app/pokemon_detail/pokemon_detail_store.dart';
import 'package:pokedex_flutter/app/pokemon_list/pokemon_list_store.dart';

final locator = GetIt.instance;
void setupLocator() {
  locator.registerSingleton<Dio>(Dio());
  locator.registerLazySingleton<IPokemonService>(
      () => PokemonListService.PokemonService(dio: locator()));
  locator.registerSingleton<PokemonListStore>(PokemonListStore(),
      signalsReady: true);
  locator.registerLazySingleton<PokemonDetailStore>(() => PokemonDetailStore());
}
