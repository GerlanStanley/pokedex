import 'package:flutter_modular/flutter_modular.dart';

class PokemonModule extends Module {
  @override
  List<Bind> get binds => [
        /*// data_sources
        Bind.lazySingleton<RemoteUserDataSource>(
          (i) => RemoteUserDataSourceImpl(i()),
        ),
        Bind.lazySingleton<LocalUserDataSource>(
          (i) => LocalUserDataSourceImpl(i()),
        ),

        // repositories
        Bind.lazySingleton<UserRepository>(
          (i) => UserRepositoryImpl(i(), i()),
        ),

        // use_cases
        Bind.lazySingleton<GetRandomUserUseCase>(
          (i) => GetRandomUserUseCaseImpl(i()),
        ),
        Bind.lazySingleton<GetAllUsersSavedUseCase>(
          (i) => GetAllUsersSavedUseCaseImpl(i()),
        ),
        Bind.lazySingleton<SaveUserUseCase>(
          (i) => SaveUserUseCaseImpl(i()),
        ),
        Bind.lazySingleton<DeleteUserUseCase>(
          (i) => DeleteUserUseCaseImpl(i()),
        ),

        // stores
        Bind.factory<GetRandomUserStore>(
          (i) => GetRandomUserStore(i()),
        ),
        Bind.factory<GetAllUsersSavedStore>(
          (i) => GetAllUsersSavedStore(i()),
        ),
        Bind.factory<SaveUserStore>(
          (i) => SaveUserStore(i()),
        ),
        Bind.factory<DeleteUserStore>(
          (i) => DeleteUserStore(i()),
        ),*/
      ];

  @override
  List<ModularRoute> get routes => [
        /*ChildRoute(
          '/',
          child: (_, args) => ProfilePage(localUser: args.data),
        ),
        ChildRoute(
          '/list',
          child: (_, __) => const ListUsersPage(),
        ),*/
      ];
}
