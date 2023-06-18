import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../core/widgets/empty_list_widget.dart';
import '../../../../../../../core/widgets/failure_widget.dart';
import '../../../../../../../core/widgets/load_widget.dart';

import '../../../../cubits/get_all_favorites_pokemons/get_all_favorites_pokemons.dart';

import 'components/list_view_component.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({Key? key}) : super(key: key);

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  late final GetAllFavoritesPokemonsCubit getAllCubit;

  @override
  void initState() {
    super.initState();

    getAllCubit = Modular.get<GetAllFavoritesPokemonsCubit>();
    getAllCubit.getAll();
  }

  @override
  void dispose() {
    getAllCubit.close();
    super.dispose();
  }

  void refresh() {
    getAllCubit.getAll(reset: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllFavoritesPokemonsCubit,
        GetAllFavoritesPokemonsState>(
      bloc: getAllCubit,
      builder: (context, state) {
        if (state is LoadingGetAllFavoritesPokemonsState &&
            state.pokemons.isEmpty) {
          //
          return const LoadWidget();
        } else if (state is FailureGetAllFavoritesPokemonsState &&
            state.pokemons.isEmpty) {
          //
          return FailureWidget(
            message: state.error,
            onPressed: getAllCubit.getAll,
            white: false,
          );
        } else if (state is SuccessGetAllFavoritesPokemonsState &&
            state.pokemons.isEmpty) {
          //
          return const EmptyListWidget(
            iconData: Icons.workspaces_outline,
            title: "No pokémon",
            subtitle: "You haven't saved any pokémon to favorites yet.",
          );
        }

        return ListViewComponent(
          pokemons: state.pokemons,
          loadLast: (state is SuccessGetAllFavoritesPokemonsState)
              ? state.loadLast
              : false,
          getMore: getAllCubit.getAll,
          refresh: refresh,
        );
      },
    );
  }
}
