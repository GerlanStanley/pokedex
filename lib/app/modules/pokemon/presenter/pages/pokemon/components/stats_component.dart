import 'package:flutter/material.dart';

import '../../../../domain/entities/entities.dart';

import 'components.dart';

class StatsComponent extends StatelessWidget {
  final PokemonEntity pokemon;

  const StatsComponent({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.white24,
          width: 1,
        ),
      ),
      child: Column(
        children: pokemon.stats
            .map((element) => StatComponent(
                  stat: element,
                  color: Color(pokemon.types[0].colorDark),
                ))
            .toList(),
      ),
    );
  }
}
