import 'package:flutter_modular/flutter_modular.dart';

import 'domain/use_cases/contracts/delete_pokemon_use_case.dart';
import 'domain/use_cases/contracts/get_pokemon_use_case.dart';
import 'domain/use_cases/contracts/is_favorite_pokemon_use_case.dart';
import 'domain/use_cases/contracts/save_pokemon_use_case.dart';
import 'domain/use_cases/delete_pokemon_use_case_impl.dart';
import 'domain/use_cases/get_pokemon_use_case_impl.dart';
import 'domain/use_cases/is_favorite_pokemon_use_case_impl.dart';
import 'domain/use_cases/save_pokemon_use_case_impl.dart';
import 'presenter/cubits/favorite_pokemon/favorite_pokemon.dart';
import 'presenter/cubits/get_all_favorites_pokemons/get_all_favorites_pokemons_cubit.dart';
import 'presenter/cubits/get_pokemon/get_pokemon.dart';
import 'presenter/pages/poke_list/poke_list_page.dart';
import 'presenter/pages/pokemon/pokemon_page.dart';

class PokemonModule extends Module {
  @override
  List<Bind> get binds => [
        // use_cases
        Bind.lazySingleton<GetPokemonUseCase>(
          (i) => GetPokemonUseCaseImpl(i()),
        ),
        Bind.lazySingleton<SavePokemonUseCase>(
          (i) => SavePokemonUseCaseImpl(i()),
        ),
        Bind.lazySingleton<DeletePokemonUseCase>(
          (i) => DeletePokemonUseCaseImpl(i()),
        ),
        Bind.lazySingleton<IsFavoritePokemonUseCase>(
          (i) => IsFavoritePokemonUseCaseImpl(i()),
        ),

        // cubits
        Bind.factory<GetAllFavoritesPokemonsCubit>(
          (i) => GetAllFavoritesPokemonsCubit(i()),
        ),
        Bind.factory<GetPokemonCubit>(
          (i) => GetPokemonCubit(i()),
        ),
        Bind.factory<FavoritePokemonCubit>(
          (i) => FavoritePokemonCubit(i(), i(), i()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const PokeListPage()),
        ChildRoute(
          '/pokemon',
          child: (_, args) => PokemonPage(
            pokemon: args.data[0],
            favorite: args.data[1],
          ),
        ),
      ];
}
