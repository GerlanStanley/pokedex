import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import 'package:pokedex/app/app_module.dart';
import 'package:pokedex/app/core/widgets/empty_list_widget.dart';
import 'package:pokedex/app/core/widgets/failure_widget.dart';
import 'package:pokedex/app/core/widgets/load_widget.dart';
import 'package:pokedex/app/modules/pokemon/domain/entities/entities.dart';
import 'package:pokedex/app/modules/pokemon/pokemon_module.dart';
import 'package:pokedex/app/modules/pokemon/presenter/cubits/get_all_favorites_pokemons/get_all_favorites_pokemons.dart';
import 'package:pokedex/app/modules/pokemon/presenter/pages/poke_list/tabs/favorites/favorites_tab.dart';
import 'package:pokedex/app/modules/pokemon/presenter/pages/poke_list/tabs/favorites/components/list_view_component.dart';

class MockGetAllFavoritesPokemonsCubit
    extends MockCubit<GetAllFavoritesPokemonsState>
    implements GetAllFavoritesPokemonsCubit {}

void main() {
  MockGetAllFavoritesPokemonsCubit getAllFavoritesPokemonsCubit =
      MockGetAllFavoritesPokemonsCubit();

  late PokemonResumedEntity pokemonResumed;

  setUpAll(() {
    initModules([
      AppModule(),
      PokemonModule()
    ], replaceBinds: [
      Bind.instance<GetAllFavoritesPokemonsCubit>(getAllFavoritesPokemonsCubit),
    ]);

    pokemonResumed = const PokemonResumedEntity(
      id: 1,
      name: 'bulbasaur',
      image: 'image',
      types: [
        TypeEntity(
          name: 'grass',
          image: 'assets/images/grass.png',
          colorLight: 0xFFFFFFFF,
          colorDark: 0xFFFFFFFF,
        ),
      ],
    );
  });

  tearDown(() {
    getAllFavoritesPokemonsCubit.close();
  });

  testWidgets(
    "Deve exibir o widget LoadWidget quando "
    "o estado do cubit for LoadingGetAllFavoritesPokemonsState",
    (WidgetTester tester) async {
      when(() => getAllFavoritesPokemonsCubit.state).thenAnswer(
        (_) => const LoadingGetAllFavoritesPokemonsState(pokemons: []),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: FavoritesTab(),
        ),
      );

      final loadWidget = find.byType(LoadWidget);
      final failureWidget = find.byType(FailureWidget);
      final emptyListComponent = find.byType(EmptyListWidget);
      final listViewComponent = find.byType(ListViewComponent);

      await tester.pump();

      expect(loadWidget, findsOneWidget);
      expect(failureWidget, findsNothing);
      expect(emptyListComponent, findsNothing);
      expect(listViewComponent, findsNothing);
    },
  );

  testWidgets(
    "Deve exibir o widget FailureWidget quando "
    "o estado do cubit for FailureGetAllFavoritesPokemonsState",
    (WidgetTester tester) async {
      when(() => getAllFavoritesPokemonsCubit.state).thenAnswer(
        (_) => const FailureGetAllFavoritesPokemonsState(
          pokemons: [],
          error: '',
        ),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: FavoritesTab(),
        ),
      );

      final loadWidget = find.byType(LoadWidget);
      final failureWidget = find.byType(FailureWidget);
      final emptyListComponent = find.byType(EmptyListWidget);
      final listViewComponent = find.byType(ListViewComponent);

      await tester.pump();

      expect(loadWidget, findsNothing);
      expect(failureWidget, findsOneWidget);
      expect(emptyListComponent, findsNothing);
      expect(listViewComponent, findsNothing);
    },
  );

  testWidgets(
    "Deve exibir o widget EmptyListWidget quando o estado do cubit for "
    "SuccessGetAllFavoritesPokemonsState e a lista for vazia",
    (WidgetTester tester) async {
      when(() => getAllFavoritesPokemonsCubit.state).thenAnswer(
        (_) => const SuccessGetAllFavoritesPokemonsState(
          pokemons: [],
          loadLast: true,
        ),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: FavoritesTab(),
        ),
      );

      final loadWidget = find.byType(LoadWidget);
      final failureWidget = find.byType(FailureWidget);
      final emptyListComponent = find.byType(EmptyListWidget);
      final listViewComponent = find.byType(ListViewComponent);

      await tester.pump();

      expect(loadWidget, findsNothing);
      expect(failureWidget, findsNothing);
      expect(emptyListComponent, findsOneWidget);
      expect(listViewComponent, findsNothing);
    },
  );

  testWidgets(
    "Deve exibir o widget ListViewWidget quando "
    "o estado do cubit for SuccessGetAllFavoritesPokemonsState e a lista contiver dados",
    (WidgetTester tester) async {
      when(() => getAllFavoritesPokemonsCubit.state).thenAnswer(
        (_) => SuccessGetAllFavoritesPokemonsState(
          pokemons: [pokemonResumed],
          loadLast: true,
        ),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FavoritesTab(),
          ),
        ),
      );

      final loadWidget = find.byType(LoadWidget);
      final failureWidget = find.byType(FailureWidget);
      final emptyListComponent = find.byType(EmptyListWidget);
      final listViewComponent = find.byType(ListViewComponent);

      await tester.pump();

      expect(loadWidget, findsNothing);
      expect(failureWidget, findsNothing);
      expect(emptyListComponent, findsNothing);
      expect(listViewComponent, findsOneWidget);
    },
  );
}
