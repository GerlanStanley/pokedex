import '../../../../core/failures/failures.dart';
import '../../../../core/helpers/http/http.dart';

import '../../domain/entities/entities.dart';
import '../../domain/params/params.dart';
import '../../infra/data_sources/remote_pokemon_data_source.dart';

import '../mappers/pokemon_mapper.dart';

class RemotePokemonDataSourceImpl implements RemotePokemonDataSource {
  final HttpHelper _httpHelper;

  RemotePokemonDataSourceImpl(this._httpHelper);

  @override
  Future<List<PokemonResumedEntity>> getAll({
    required GetAllPokemonsParams params,
  }) async {
    try {
      Map response = await _httpHelper.get(
        '/pokemon'
        '?offset=${params.offset}'
        '&limit=${params.limit}',
      );

      List mapResults = response['results'];

      final mapsUniquesResults = await Future.wait(mapResults.map((e) async {
        return await _httpHelper.get('/pokemon/${e['name']}');
      }).toList());

      for (int i = 0; i < mapsUniquesResults.length; i++) {
        mapResults[i]['id'] = mapsUniquesResults[i]['id'];
        mapResults[i]['sprites'] = mapsUniquesResults[i]['sprites'];
        mapResults[i]['types'] = mapsUniquesResults[i]['types'];
      }

      return PokemonMapper.resumedFromList(mapResults);
    } on Failure {
      rethrow;
    } catch (e, stackTrace) {
      throw ParseFailure(
        message: 'Erro ao mapear o json',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<PokemonEntity> get({
    required GetPokemonParams params,
  }) async {
    try {
      Map response = await _httpHelper.get('/pokemon/${params.name}');
      return PokemonMapper.fromMap(response);
    } on Failure {
      rethrow;
    } catch (e, stackTrace) {
      throw ParseFailure(
        message: 'Erro ao mapear o json',
        stackTrace: stackTrace,
      );
    }
  }
}
