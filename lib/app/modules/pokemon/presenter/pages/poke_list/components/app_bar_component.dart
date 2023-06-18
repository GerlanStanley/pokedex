import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  const AppBarComponent({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Colors.transparent,
      alignment: Alignment.centerLeft,
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20),
          child: Image.asset(
            'assets/images/pokemon_logo.png',
            width: 120,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
