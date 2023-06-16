import 'package:flutter/material.dart';

import 'primary_elevated_button_widget.dart';

class FailureWidget extends StatelessWidget {
  final String message;
  final Function()? onPressed;

  const FailureWidget({
    Key? key,
    required this.message,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400,
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Theme.of(context).textTheme.titleSmall?.color,
              size: 80,
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: Text(
                'Ops',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: PrimaryElevatedButtonWidget(
                text: 'Tentar novamente',
                onPressed: onPressed,
              ),
            )
          ],
        ),
      ),
    );
  }
}
