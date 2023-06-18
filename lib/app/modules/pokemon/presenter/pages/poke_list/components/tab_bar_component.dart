import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';

import '../../../../../../core/constants/constants.dart';

class TabBarComponent extends StatelessWidget {
  final TabController tabController;

  const TabBarComponent({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MotionTabBar(
      initialSelectedTab: "List",
      labels: const ["List", "Favorites"],
      icons: const [Icons.list_alt_outlined, Icons.favorite_outline_outlined],
      tabSize: 50,
      tabBarHeight: 55,
      textStyle: const TextStyle(
        fontSize: 12,
        color: ColorsConstants.primary,
        fontWeight: FontWeight.w500,
      ),
      tabIconColor: ColorsConstants.primary,
      tabIconSize: 28.0,
      tabIconSelectedSize: 26.0,
      tabSelectedColor: ColorsConstants.primary,
      tabIconSelectedColor: Colors.white,
      tabBarColor: ColorsConstants.tabBarBackground,
      onTabItemSelected: (int value) {
        tabController.index = value;
      },
    );
  }
}
