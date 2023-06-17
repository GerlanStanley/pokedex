import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget {
  const AppBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Stack(
        children: [
          SafeArea(
            top: true,
            child: Image.asset(
              'assets/images/pokemon_logo.png',
              width: 200,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: -50,
            right: -70,
            child: Image.asset(
              'assets/images/pokeball_black.png',
              height: 200,
              opacity: const AlwaysStoppedAnimation(.15),
            ),
          ),
        ],
      ),
    );
  }
}
