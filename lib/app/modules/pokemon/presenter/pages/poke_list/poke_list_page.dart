import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../cubits/get_all_remotes_pokemons/get_all_remotes_pokemons_cubit.dart';

import 'components/components.dart';
import 'tabs/favorites/favorites_tab.dart';
import 'tabs/remotes/remotes_tab.dart';

class PokeListPage extends StatefulWidget {
  const PokeListPage({Key? key}) : super(key: key);

  @override
  State<PokeListPage> createState() => _PokeListPageState();
}

class _PokeListPageState extends State<PokeListPage>
    with TickerProviderStateMixin {
  //
  late final GetAllRemotesPokemonsCubit getAllCubit;
  late final TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);

    getAllCubit = Modular.get<GetAllRemotesPokemonsCubit>();
    getAllCubit.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppBarComponent(),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                RemotesTab(getAllCubit: getAllCubit),
                const FavoritesTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: TabBarComponent(tabController: tabController),
    );
  }
}
