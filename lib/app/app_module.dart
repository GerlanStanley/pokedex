import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

import 'core/helpers/http/http.dart';
import 'modules/pokemon/domain/repositories/pokemon_repository.dart';
import 'modules/pokemon/domain/use_cases/contracts/get_all_pokemons_use_case.dart';
import 'modules/pokemon/domain/use_cases/get_all_pokemons_use_case_impl.dart';
import 'modules/pokemon/external/data_sources/local_pokemon_data_source_impl.dart';
import 'modules/pokemon/external/data_sources/remote_pokemon_data_source_impl.dart';
import 'modules/pokemon/infra/data_sources/local_pokemon_data_source.dart';
import 'modules/pokemon/infra/data_sources/remote_pokemon_data_source.dart';
import 'modules/pokemon/infra/repositories/pokemon_repository_impl.dart';
import 'modules/pokemon/pokemon_module.dart';
import 'modules/pokemon/presenter/cubits/get_all_remotes_pokemons/get_all_remotes_pokemons_cubit.dart';
import 'modules/splash/presenter/pages/splash_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        AsyncBind<Box>(
          (i) => Hive.openBox<List>('pokedex'),
        ),
        Bind.lazySingleton<Dio>((i) => Dio()),
        Bind.lazySingleton<Interceptor>((i) => CustomInterceptor()),
        Bind.lazySingleton<HttpHelper>((i) => DioHttpHelperImpl(i(), i())),

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

        //cubits
        Bind.lazySingleton<GetAllRemotesPokemonsCubit>(
          (i) => GetAllRemotesPokemonsCubit(i()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const SplashPage(),
          guards: [AsyncGuard()],
        ),
        ModuleRoute('/pokemon', module: PokemonModule(), guards: [AsyncGuard()])
      ];
}

class AsyncGuard extends RouteGuard {
  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    await Modular.isModuleReady<AppModule>();
    return true;
  }
}
