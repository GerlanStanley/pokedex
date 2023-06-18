import 'package:flutter/material.dart';

import '../../../../../../core/constants/constants.dart';

class TabBarComponent extends StatelessWidget {
  final TabController tabController;

  const TabBarComponent({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorsConstants.tabBarBackground,
      borderRadius: BorderRadius.circular(16),
      child: TabBar(
        controller: tabController,
        indicator: UnderlineTabIndicator(
          borderSide: const BorderSide(
            width: 3,
            color: ColorsConstants.tabBarSelectedIcon,
          ),
          insets: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 3,
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        indicatorColor: ColorsConstants.tabBarSelectedIcon,
        indicatorPadding: const EdgeInsets.only(bottom: 10),
        tabs: const [
          Tab(
            icon: Icon(Icons.list_alt_outlined),
            height: 60,
          ),
          Tab(
            icon: Icon(Icons.favorite_outline),
            height: 60,
          ),
        ],
      ),
    );
  }
}
