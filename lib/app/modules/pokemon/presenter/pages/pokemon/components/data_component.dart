import 'package:flutter/material.dart';

import '../../../../domain/entities/entities.dart';

import 'components.dart';

class DataComponent extends StatelessWidget {
  final PokemonEntity pokemon;

  const DataComponent({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.white24,
          width: 1,
        )
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DataInfoComponent(
                  title: 'ID',
                  value: '#${pokemon.id.toString().padLeft(3, '0')}',
                ),
              ),
              Expanded(
                child: DataInfoComponent(
                  title: 'BASE EXPERIENCE',
                  value: pokemon.baseExperience.toString(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: DataInfoComponent(
                  title: 'WEIGHT',
                  value: '${pokemon.weight} KG',
                ),
              ),
              Expanded(
                child: DataInfoComponent(
                  title: 'HEIGHT',
                  value: '${pokemon.height} M',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
