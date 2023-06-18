import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/modules/pokemon/external/hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory = await getApplicationDocumentsDirectory();

  Hive
    ..init(appDocumentDirectory.path)
    ..registerAdapter(PokemonHiveObjectAdapter())
    ..registerAdapter(TypeHiveObjectAdapter())
    ..registerAdapter(StatHiveObjectAdapter());

  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}
