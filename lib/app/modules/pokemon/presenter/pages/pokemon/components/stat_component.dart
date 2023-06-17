import 'package:flutter/material.dart';

import '../../../../domain/entities/entities.dart';

class StatComponent extends StatelessWidget {
  final StatEntity stat;
  final Color color;

  const StatComponent({
    Key? key,
    required this.stat,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              stat.name,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: 50,
            child: Center(
              child: Text(
                stat.baseStat.toString(),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: LinearProgressIndicator(
              value: stat.baseStat / 100,
              color: Colors.white.withOpacity(0.9),
              backgroundColor: Colors.white38,
            ),
          ),
        ],
      ),
    );
  }
}
