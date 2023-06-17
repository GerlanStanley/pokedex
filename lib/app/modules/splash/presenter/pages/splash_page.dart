import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3)).then((_) {
      Modular.to.navigate('/pokemon/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.primary,
      body: Center(
        child: Lottie.asset(
          'assets/lotties/pokeball.json',
          width: 100,
          height: 100,
          animate: true,
          repeat: true,
        ),
      ),
    );
  }
}
