import 'package:flutter/material.dart';

import '../../../../../../../../core/widgets/load_widget.dart';

import '../../../../../../domain/entities/entities.dart';

import '../../../../../common_components/common_components.dart';

class ListViewComponent extends StatelessWidget {
  final List<PokemonResumedEntity> pokemons;
  final bool loadLast;
  final Function() getMore;

  const ListViewComponent({
    Key? key,
    required this.pokemons,
    required this.loadLast,
    required this.getMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        if (notification.metrics.pixels ==
            notification.metrics.maxScrollExtent) {
          //
          getMore();
        }
        return false;
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 20),
        itemCount: pokemons.length + 1,
        itemBuilder: (context, index) {
          if (index == pokemons.length) {
            return loadLast
                ? Container()
                : const LoadWidget(
                    size: 40,
                    margin: EdgeInsets.symmetric(vertical: 20),
                  );
          }

          return PokemonListItemComponent(pokemon: pokemons[index]);
        },
      ),
    );
  }
}
