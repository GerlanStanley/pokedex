import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokedex/app/modules/pokemon/domain/entities/entities.dart';
import 'package:pokedex/app/modules/pokemon/domain/params/params.dart';
import 'package:pokedex/app/modules/pokemon/external/data_sources/local_pokemon_data_source_impl.dart';
import 'package:pokedex/app/modules/pokemon/external/hive/hive.dart';

class MockBox extends Mock implements Box {}

void main() {
  late MockBox mockBox;
  late LocalPokemonDataSourceImpl dataSource;
  late PokemonHiveObject pokemonHive;
  late PokemonEntity pokemon;

  setUp(() {
    mockBox = MockBox();
    dataSource = LocalPokemonDataSourceImpl(mockBox);

    pokemonHive = PokemonHiveObject(
      id: 1,
      name: 'bulbasaur',
      height: 1,
      weight: 1,
      baseExperience: 1,
      image: 'image',
      types: [],
      abilities: [],
      stats: [],
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
          image: 'assets/images',
          color: 0xFFFFFFFF,
        ),
      ],
    );

    registerFallbackValue(const GetAllPokemonsParams(
      limit: 2,
      offset: 0,
      saved: false,
    ));

    registerFallbackValue(const GetPokemonParams(name: 'bulbasaur'));
  });

  group('GetAll', () {
    test('Deve retornar uma List<PokemonResumedEntity>', () async {
      var params = const GetAllPokemonsParams(
        limit: 2,
        offset: 0,
        saved: false,
      );

      when(
        () => mockBox.get(any()),
      ).thenAnswer((_) => [pokemonHive, pokemonHive]);

      var result = await dataSource.getAll(params: params);

      expect(result, isA<List<PokemonResumedEntity>>());
    });
  });

  group('Get', () {
    test('Deve retornar um PokemonEntity', () async {
      var params = const GetPokemonParams(name: 'bulbasaur');

      when(() => mockBox.get(any())).thenAnswer((_) => [pokemonHive]);

      var result = await dataSource.get(params: params);

      expect(result, isA<PokemonEntity>());
    });
  });

  group('Save', () {
    test('Deve retornar um booleano', () async {
      when(() => mockBox.get(any())).thenAnswer((_) => null);
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {
        return;
      });

      var result = await dataSource.save(pokemon: pokemon);

      expect(result, isA<bool>());
    });
  });

  group('Delete', () {
    test('Deve retornar um booleano', () async {
      when(() => mockBox.get(any())).thenAnswer((_) => null);
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {
        return;
      });

      var result = await dataSource.delete(pokemon: pokemon);

      expect(result, isA<bool>());
    });
  });
}
