import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadWidget extends StatefulWidget {
  final double size;
  final EdgeInsets? margin;

  const LoadWidget({
    Key? key,
    this.size = 100,
    this.margin,
  }) : super(key: key);

  @override
  State<LoadWidget> createState() => _LoadWidgetState();
}

class _LoadWidgetState extends State<LoadWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.size,
        height: widget.size,
        margin: widget.margin,
        padding: EdgeInsets.all(widget.size * 0.05),
        decoration: BoxDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Lottie.asset(
          'assets/lotties/pokeball.json',
          width: 50,
          height: 50,
          animate: true,
          repeat: true,
        ),
      ),
    );
  }
}
