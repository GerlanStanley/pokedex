import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/constants/constants.dart';

import '../../../../core/widgets/empty_list_widget.dart';
import '../../../../core/widgets/failure_widget.dart';
import '../../../../core/widgets/load_widget.dart';
import '../../../pokemon/presenter/cubits/get_all_remotes_pokemons/get_all_remotes_pokemons.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final GetAllRemotesPokemonsCubit getAllCubit;

  @override
  void initState() {
    super.initState();

    getAllCubit = Modular.get<GetAllRemotesPokemonsCubit>();
    getAllCubit.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.primary,
      body: BlocConsumer<GetAllRemotesPokemonsCubit, GetAllRemotesPokemonsState>(
        bloc: getAllCubit,
        listener: (context, state) {
          if (state is SuccessGetAllRemotesPokemonsState&&
              state.pokemons.isNotEmpty) {
            //
            Modular.to.navigate('/pokemon/');
          }
        },
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
              onPressed: getAllCubit.getAll,
              white: true,
            );
          } else if (state is SuccessGetAllRemotesPokemonsState &&
              state.pokemons.isEmpty) {
            //
            return const EmptyListWidget(
              iconData: Icons.workspaces_outline,
              title: "No pokemon",
              subtitle: "We couldn't find any pokemon in the database",
            );
          }

          return Container();
        },
      ),
    );
  }
}
