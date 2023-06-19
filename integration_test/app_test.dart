import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:pokedex/app/modules/pokemon/presenter/common_components/common_components.dart';
import 'package:pokedex/app/modules/pokemon/presenter/pages/poke_list/tabs/favorites/components/list_view_component.dart'
    as list_view_favorite;
import 'package:pokedex/app/modules/pokemon/presenter/pages/poke_list/tabs/remotes/components/list_view_component.dart'
    as list_view_remote;
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

      final listViewComponent = find.byType(list_view_remote.ListViewComponent);

      expect(listViewComponent, findsOneWidget);
    },
  );

  testWidgets(
    "Verificar se carregou o pokemon individualmente da API",
    (WidgetTester tester) async {
      app.main();

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      final item = find.byType(PokemonListItemComponent).evaluate().first;

      await tester.tapAt(tester.getCenter(find.byWidget(item.widget)));

      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      final dataComponent = find.byType(DataComponent);

      expect(dataComponent, findsOneWidget);
    },
  );

  testWidgets(
    "Salvar o pokemon nos favoritos e verificando se ele aparece na "
    "listagem de favoritos",
    (WidgetTester tester) async {
      app.main();

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      final item = find.byType(PokemonListItemComponent).evaluate().first;
      await tester.tapAt(tester.getCenter(find.byWidget(item.widget)));
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      final iconButton = find.byKey(const Key('favorite-button'));
      await tester.tap(iconButton);
      await tester.pumpAndSettle();

      final favoriteIcon = find
          .byKey(const Key('favorite-icon-key'))
          .evaluate()
          .single
          .widget as Icon;

      expect(favoriteIcon.icon, Icons.favorite_outlined);

      final backButton = find.byKey(const Key('back-button'));
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      final tabBarView =
          find.byType(TabBarView).evaluate().single.widget as TabBarView;
      tabBarView.controller!.animateTo(1);
      await tester.pumpAndSettle();

      final listViewComponent =
          find.byType(list_view_favorite.ListViewComponent);

      expect(listViewComponent, findsOneWidget);
    },
  );
}
