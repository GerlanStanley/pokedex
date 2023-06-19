import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import 'package:pokedex/app/app_module.dart';
import 'package:pokedex/app/core/widgets/failure_widget.dart';
import 'package:pokedex/app/core/widgets/load_widget.dart';
import 'package:pokedex/app/modules/pokemon/domain/entities/entities.dart';
import 'package:pokedex/app/modules/pokemon/pokemon_module.dart';
import 'package:pokedex/app/modules/pokemon/presenter/cubits/favorite_pokemon/favorite_pokemon.dart';
import 'package:pokedex/app/modules/pokemon/presenter/cubits/get_pokemon/get_pokemon.dart';
import 'package:pokedex/app/modules/pokemon/presenter/pages/pokemon/components/components.dart';
import 'package:pokedex/app/modules/pokemon/presenter/pages/pokemon/pokemon_page.dart';

class MockGetPokemonCubit extends MockCubit<GetPokemonState>
    implements GetPokemonCubit {}

class MockFavoritePokemonCubit extends MockCubit<FavoritePokemonState>
    implements FavoritePokemonCubit {}

void main() {
  MockGetPokemonCubit getPokemonCubit = MockGetPokemonCubit();
  MockFavoritePokemonCubit favoritePokemonCubit = MockFavoritePokemonCubit();
  late PokemonResumedEntity pokemonResumed;
  late PokemonEntity pokemon;

  setUpAll(() {
    initModules([
      AppModule(),
      PokemonModule()
    ], replaceBinds: [
      Bind.instance<GetPokemonCubit>(getPokemonCubit),
      Bind.instance<FavoritePokemonCubit>(favoritePokemonCubit),
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

    pokemon = const PokemonEntity(
      id: 1,
      name: 'bulbasaur',
      height: 1,
      weight: 1,
      image: 'image',
      baseExperience: 1,
      abilities: [],
      stats: [],
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
    getPokemonCubit.close();
    favoritePokemonCubit.close();
  });

  testWidgets(
    "Deve exibir o widget LoadWidget quando "
    "o estado do cubit for LoadingGetPokemonState",
    (WidgetTester tester) async {
      when(() => getPokemonCubit.state)
          .thenAnswer((_) => LoadingGetPokemonState());

      when(() => favoritePokemonCubit.state)
          .thenAnswer((_) => IsFavoriteState());

      await tester.pumpWidget(
        MaterialApp(
          home: PokemonPage(pokemon: pokemonResumed, favorite: false),
        ),
      );

      final loadWidget = find.byType(LoadWidget);
      final failureWidget = find.byType(FailureWidget);
      final dataComponent = find.byType(DataComponent);

      await tester.pump();

      expect(loadWidget, findsOneWidget);
      expect(failureWidget, findsNothing);
      expect(dataComponent, findsNothing);
    },
  );

  testWidgets(
    "Deve exibir o widget FailureWidget quando "
    "o estado do cubit for FailureGetPokemonState",
    (WidgetTester tester) async {
      when(() => getPokemonCubit.state)
          .thenAnswer((_) => FailureGetPokemonState(error: ''));

      when(() => favoritePokemonCubit.state)
          .thenAnswer((_) => IsFavoriteState());

      await tester.pumpWidget(
        MaterialApp(
          home: PokemonPage(pokemon: pokemonResumed, favorite: false),
        ),
      );

      final loadWidget = find.byType(LoadWidget);
      final failureWidget = find.byType(FailureWidget);
      final dataComponent = find.byType(DataComponent);

      await tester.pump();

      expect(loadWidget, findsNothing);
      expect(failureWidget, findsOneWidget);
      expect(dataComponent, findsNothing);
    },
  );

  testWidgets(
    "Deve exibir o widget DataComponent quando "
    "o estado do cubit for LoadingGetPokemonState",
    (WidgetTester tester) async {
      when(() => getPokemonCubit.state)
          .thenAnswer((_) => SuccessGetPokemonState(pokemon: pokemon));

      when(() => favoritePokemonCubit.state)
          .thenAnswer((_) => IsFavoriteState());

      await tester.pumpWidget(
        MaterialApp(
          home: PokemonPage(pokemon: pokemonResumed, favorite: false),
        ),
      );

      final loadWidget = find.byType(LoadWidget);
      final failureWidget = find.byType(FailureWidget);
      final dataComponent = find.byType(DataComponent);

      await tester.pump();

      expect(loadWidget, findsNothing);
      expect(failureWidget, findsNothing);
      expect(dataComponent, findsOneWidget);
    },
  );

  testWidgets(
    "Deve exibir o icone de favorito quando "
    "o estado do cubit for IsFavoriteState",
    (WidgetTester tester) async {
      when(() => getPokemonCubit.state)
          .thenAnswer((_) => SuccessGetPokemonState(pokemon: pokemon));

      when(() => favoritePokemonCubit.state)
          .thenAnswer((_) => IsFavoriteState());

      await tester.pumpWidget(
        MaterialApp(
          home: PokemonPage(pokemon: pokemonResumed, favorite: false),
        ),
      );

      final favoriteIcon = find
          .byKey(const Key('favorite-icon-key'))
          .evaluate()
          .single
          .widget as Icon;

      await tester.pump();

      expect(favoriteIcon.icon, Icons.favorite_outlined);
    },
  );
}
