import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';

import '../../domain/entities/entities.dart';

class PokemonTypeChipComponent extends StatelessWidget {
  final TypeEntity type;

  const PokemonTypeChipComponent({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Color(type.colorDark),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            type.image,
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 6),
          Text(
            type.name.capitalize(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
