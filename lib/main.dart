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

  Hive.init(appDocumentDirectory.path);

  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(PokemonHiveObjectAdapter());
  }
  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(TypeHiveObjectAdapter());
  }
  if (!Hive.isAdapterRegistered(3)) {
    Hive.registerAdapter(StatHiveObjectAdapter());
  }

  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}
