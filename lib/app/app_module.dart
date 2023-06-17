import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

import 'core/helpers/http/http.dart';
import 'modules/pokemon/pokemon_module.dart';
import 'modules/splash/presenter/pages/splash_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        AsyncBind<Box>(
          (i) => Hive.openBox('pokedex'),
        ),
        Bind.lazySingleton<Dio>((i) => Dio()),
        Bind.lazySingleton<Interceptor>((i) => CustomInterceptor()),
        Bind.lazySingleton<HttpHelper>((i) => DioHttpHelperImpl(i(), i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SplashPage()),
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
