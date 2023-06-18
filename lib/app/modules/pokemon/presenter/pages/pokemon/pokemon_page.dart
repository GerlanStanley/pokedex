import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/app/core/extensions/extensions.dart';

import '../../../../../core/widgets/cached_network_image_widget.dart';
import '../../../../../core/widgets/failure_widget.dart';
import '../../../../../core/widgets/load_widget.dart';

import '../../../domain/entities/entities.dart';

import '../../common_components/common_components.dart';
import '../../cubits/favorite_pokemon/favorite_pokemon.dart';
import '../../cubits/get_pokemon/get_pokemon.dart';

import 'components/components.dart';

class PokemonPage extends StatefulWidget {
  final PokemonResumedEntity pokemon;

  const PokemonPage({Key? key, required this.pokemon}) : super(key: key);

  @override
  State<PokemonPage> createState() => _PokemonPagePageState();
}

class _PokemonPagePageState extends State<PokemonPage> {
  late final GetPokemonCubit getCubit;
  late final FavoritePokemonCubit favoriteCubit;

  @override
  void initState() {
    super.initState();

    getCubit = Modular.get<GetPokemonCubit>();
    favoriteCubit = Modular.get<FavoritePokemonCubit>();
    getCubit.get(widget.pokemon.name);
  }

  @override
  void dispose() {
    getCubit.close();
    favoriteCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color(widget.pokemon.types[0].colorDark),
                Color(widget.pokemon.types[0].colorLight),
              ],
            ),
          ),
        ),
        Positioned(
          right: -(MediaQuery.of(context).size.width / 1.3 / 3),
          top: -50,
          child: Image.asset(
            'assets/images/pokeball_white.png',
            height: MediaQuery.of(context).size.width / 1.3,
            width: MediaQuery.of(context).size.width / 1.3,
            fit: BoxFit.cover,
            opacity: const AlwaysStoppedAnimation(.15),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: false,
            title: Text(
              '#${widget.pokemon.id.toString().padLeft(3, '0')}',
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .color!
                    .withOpacity(0.8),
                fontSize: 24,
                fontWeight:
                    Theme.of(context).textTheme.displayLarge!.fontWeight,
              ),
            ),
            actions: [
              BlocConsumer(
                bloc: getCubit,
                listener: (context, getState) {
                  if (getState is SuccessGetPokemonState) {
                    favoriteCubit.isFavorite(pokemon: getState.pokemon);
                  }
                },
                builder: (context, getState) {
                  return BlocBuilder(
                    bloc: favoriteCubit,
                    builder: (context, favoriteState) {
                      return favoriteState is! InitialFavoriteState
                          ? IconButton(
                              onPressed: () {
                                favoriteCubit.favorite(
                                  pokemon: (getState as SuccessGetPokemonState)
                                      .pokemon,
                                  value: favoriteState is IsNotFavoriteState,
                                );
                              },
                              icon: Icon(
                                favoriteState is IsFavoriteState
                                    ? Icons.favorite_outlined
                                    : Icons.favorite_outline_outlined,
                              ),
                            )
                          : Container();
                    },
                  );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CachedNetworkImageWidget(
                    image: widget.pokemon.image,
                    height: 220,
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      widget.pokemon.name.capitalize(),
                      style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .color!
                            .withOpacity(0.9),
                        fontSize:
                            Theme.of(context).textTheme.displayLarge!.fontSize,
                        fontWeight: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .fontWeight,
                      ),
                    ),
                  ),
                  BlocBuilder<GetPokemonCubit, GetPokemonState>(
                    bloc: getCubit,
                    builder: (context, state) {
                      if (state is LoadingGetPokemonState) {
                        return const LoadWidget(
                          margin: EdgeInsets.only(top: 80),
                        );
                      } else if (state is FailureGetPokemonState) {
                        return FailureWidget(
                          message: state.error,
                          onPressed: () => getCubit.get(widget.pokemon.name),
                        );
                      } else if (state is SuccessGetPokemonState) {
                        return Column(
                          children: [
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              children: state.pokemon.types
                                  .map((element) => PokemonTypeChipComponent(
                                        type: element,
                                      ))
                                  .toList(),
                            ),
                            const SizedBox(height: 20),
                            DataComponent(pokemon: state.pokemon),
                            const SizedBox(height: 20),
                            StatsComponent(pokemon: state.pokemon),
                          ],
                        );
                      }

                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
