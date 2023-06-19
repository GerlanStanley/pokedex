import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:pokedex/app/modules/pokemon/presenter/common_components/common_components.dart';
import 'package:pokedex/app/modules/pokemon/presenter/pages/poke_list/tabs/remotes/components/list_view_component.dart';
import 'package:pokedex/app/modules/pokemon/presenter/pages/pokemon/components/components.dart';
import 'package:pokedex/main.dart' as app;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    "Verificar se carregou a lista de pokemons da API",
    (WidgetTester tester) async {
      app.main();

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      final listViewComponent = find.byType(ListViewComponent);

      expect(listViewComponent, findsOneWidget);
    },
  );

  testWidgets(
    "Verificar se carregou o pokemon individualmente da API",
    (WidgetTester tester) async {
      app.main();

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      final item = find.byType(PokemonListItemComponent);

      tester.tap(item);
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      expect(DataComponent, findsOneWidget);
    },
  );
}
