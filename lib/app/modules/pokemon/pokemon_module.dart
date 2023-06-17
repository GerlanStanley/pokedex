import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/pokemon_repository.dart';
import 'domain/use_cases/contracts/delete_pokemon_use_case.dart';
import 'domain/use_cases/contracts/get_all_pokemons_use_case.dart';
import 'domain/use_cases/contracts/get_pokemon_use_case.dart';
import 'domain/use_cases/contracts/save_pokemon_use_case.dart';
import 'domain/use_cases/delete_pokemon_use_case_impl.dart';
import 'domain/use_cases/get_all_pokemons_use_case_impl.dart';
import 'domain/use_cases/get_pokemon_use_case_impl.dart';
import 'domain/use_cases/save_pokemon_use_case_impl.dart';
import 'external/data_sources/local_pokemon_data_source_impl.dart';
import 'external/data_sources/remote_pokemon_data_source_impl.dart';
import 'infra/data_sources/local_pokemon_data_source.dart';
import 'infra/data_sources/remote_pokemon_data_source.dart';
import 'infra/repositories/pokemon_repository_impl.dart';
import 'presenter/cubits/get_all_remotes_pokemons/get_all_remotes_pokemons.dart';
import 'presenter/cubits/get_pokemon/get_pokemon.dart';
import 'presenter/pages/poke_list/poke_list_page.dart';
import 'presenter/pages/pokemon/pokemon_page.dart';

class PokemonModule extends Module {
  @override
  List<Bind> get binds => [
        // data_sources
        Bind.lazySingleton<RemotePokemonDataSource>(
          (i) => RemotePokemonDataSourceImpl(i()),
        ),
        Bind.lazySingleton<LocalPokemonDataSource>(
          (i) => LocalPokemonDataSourceImpl(i()),
        ),

        // repositories
        Bind.lazySingleton<PokemonRepository>(
          (i) => PokemonRepositoryImpl(i(), i()),
        ),

        // use_cases
        Bind.lazySingleton<GetAllPokemonsUseCase>(
          (i) => GetAllPokemonsUseCaseImpl(i()),
        ),
        Bind.lazySingleton<GetPokemonUseCase>(
          (i) => GetPokemonUseCaseImpl(i()),
        ),
        Bind.lazySingleton<SavePokemonUseCase>(
          (i) => SavePokemonUseCaseImpl(i()),
        ),
        Bind.lazySingleton<DeletePokemonUseCase>(
          (i) => DeletePokemonUseCaseImpl(i()),
        ),

        // cubits
        Bind.lazySingleton<GetAllRemotesPokemonsCubit>(
          (i) => GetAllRemotesPokemonsCubit(i()),
        ),
        Bind.factory<GetPokemonCubit>(
          (i) => GetPokemonCubit(i()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const PokeListPage()),
        ChildRoute(
          '/pokemon',
          child: (_, args) => PokemonPage(pokemon: args.data),
        ),
      ];
}
