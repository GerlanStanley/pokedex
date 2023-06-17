import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/widgets/empty_list_widget.dart';
import '../../../../../../../core/widgets/failure_widget.dart';
import '../../../../../../../core/widgets/load_widget.dart';

import '../../../../cubits/get_all_remotes_pokemons/get_all_remotes_pokemons.dart';

import 'components/components.dart';

class RemotesTab extends StatefulWidget {
  final GetAllRemotesPokemonsCubit getAllCubit;

  const RemotesTab({
    Key? key,
    required this.getAllCubit,
  }) : super(key: key);

  @override
  State<RemotesTab> createState() => _RemotesTabState();
}

class _RemotesTabState extends State<RemotesTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllRemotesPokemonsCubit, GetAllRemotesPokemonsState>(
      bloc: widget.getAllCubit,
      builder: (context, state) {
        if (state is LoadingGetAllRemotesPokemonsState &&
            state.pokemons.isEmpty) {
          //
          return const LoadWidget();
        } else if (state is FailureGetAllRemotesPokemonsState &&
            state.pokemons.isEmpty) {
          //
          return FailureWidget(
            message: state.error,
            onPressed: widget.getAllCubit.getAll,
          );
        } else if (state is SuccessGetAllRemotesPokemonsState &&
            state.pokemons.isEmpty) {
          //
          return const EmptyListWidget(
            iconData: Icons.videogame_asset_outlined,
            title: "No pokemon",
            subtitle: "We couldn't find any pokemon in the database",
          );
        }

        return ListViewComponent(
          pokemons: state.pokemons,
          getMore: widget.getAllCubit.getAll,
        );
      },
    );
  }
}
