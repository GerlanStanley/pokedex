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
import 'package:pokedex/app/modules/pokemon/presenter/cubits/get_all_remotes_pokemons/get_all_remotes_pokemons.dart';
import 'package:pokedex/app/modules/pokemon/presenter/pages/poke_list/tabs/remotes/components/list_view_component.dart';
import 'package:pokedex/app/modules/pokemon/presenter/pages/poke_list/tabs/remotes/remotes_tab.dart';

class MockGetAllRemotesPokemonsCubit
    extends MockCubit<GetAllRemotesPokemonsState>
    implements GetAllRemotesPokemonsCubit {}

void main() {
  MockGetAllRemotesPokemonsCubit getAllRemotesPokemonsCubit =
      MockGetAllRemotesPokemonsCubit();

  late PokemonResumedEntity pokemonResumed;

  setUpAll(() {
    initModules([
      AppModule(),
      PokemonModule()
    ], replaceBinds: [
      Bind.instance<GetAllRemotesPokemonsCubit>(getAllRemotesPokemonsCubit),
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
    getAllRemotesPokemonsCubit.close();
  });

  testWidgets(
    "Deve exibir o widget LoadWidget quando "
    "o estado do cubit for LoadingGetAllRemotesPokemonsState",
    (WidgetTester tester) async {
      when(() => getAllRemotesPokemonsCubit.state).thenAnswer(
        (_) => const LoadingGetAllRemotesPokemonsState(pokemons: []),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: RemotesTab(getAllCubit: getAllRemotesPokemonsCubit),
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
    "o estado do cubit for FailureGetAllRemotesPokemonsState",
    (WidgetTester tester) async {
      when(() => getAllRemotesPokemonsCubit.state).thenAnswer(
        (_) => const FailureGetAllRemotesPokemonsState(
          pokemons: [],
          error: '',
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: RemotesTab(getAllCubit: getAllRemotesPokemonsCubit),
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
    "SuccessGetAllRemotesPokemonsState e a lista for vazia",
    (WidgetTester tester) async {
      when(() => getAllRemotesPokemonsCubit.state).thenAnswer(
        (_) => const SuccessGetAllRemotesPokemonsState(
          pokemons: [],
          loadLast: true,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: RemotesTab(getAllCubit: getAllRemotesPokemonsCubit),
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
    "o estado do cubit for SuccessGetAllRemotesPokemonsState e a lista contiver dados",
    (WidgetTester tester) async {
      when(() => getAllRemotesPokemonsCubit.state).thenAnswer(
        (_) => SuccessGetAllRemotesPokemonsState(
          pokemons: [pokemonResumed],
          loadLast: true,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RemotesTab(getAllCubit: getAllRemotesPokemonsCubit),
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
