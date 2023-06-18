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
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    getAllCubit = Modular.get<GetAllRemotesPokemonsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: -(MediaQuery.of(context).size.width / 1.3 / 3),
            top: -50,
            child: Image.asset(
              'assets/images/pokeball_black.png',
              height: MediaQuery.of(context).size.width / 1.3,
              width: MediaQuery.of(context).size.width / 1.3,
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.15),
            ),
          ),
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                const SliverToBoxAdapter(child: AppBarComponent()),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                RemotesTab(getAllCubit: getAllCubit),
                const FavoritesTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: TabBarComponent(tabController: _tabController),
    );
  }
}
