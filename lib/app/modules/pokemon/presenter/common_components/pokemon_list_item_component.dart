import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/widgets/cached_network_image_widget.dart';

import '../../domain/entities/entities.dart';

import 'common_components.dart';

class PokemonListItemComponent extends StatelessWidget {
  final PokemonResumedEntity pokemon;
  final bool favorite;
  final Function()? refresh;

  const PokemonListItemComponent({
    Key? key,
    required this.pokemon,
    required this.favorite,
    this.refresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        bool? result = await Modular.to
            .pushNamed('./pokemon', arguments: [pokemon, favorite]);

        if (refresh != null && result != null && result) {
          refresh!();
        }
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Hero(
                tag: "card-${favorite ? 'favorite' : ''}-${pokemon.id}",
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(pokemon.types[0].colorLight),
                        Color(pokemon.types[0].colorDark),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '#${pokemon.id.toString().padLeft(3, '0')}',
                        style: const TextStyle(
                          color: Color(0xFF555555),
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        pokemon.name.capitalize(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: pokemon.types
                            .map(
                              (element) =>
                                  PokemonTypeChipComponent(type: element),
                            )
                            .toList(),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: -20,
              bottom: -10,
              child: Hero(
                tag: "pokeball-${favorite ? 'favorite' : ''}-${pokemon.id}",
                child: Image.asset(
                  'assets/images/pokeball_white.png',
                  height: 160,
                  width: 160,
                  fit: BoxFit.cover,
                  opacity: const AlwaysStoppedAnimation(.15),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Hero(
                tag: "image-${favorite ? 'favorite' : ''}-${pokemon.id}",
                child: CachedNetworkImageWidget(
                  image: pokemon.image,
                  height: 130,
                  width: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
