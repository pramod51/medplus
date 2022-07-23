import 'package:flutter/material.dart';
import 'package:medplus/res/palette.dart';

class AppTabBarPlain extends StatefulWidget {
  final List<Tab> tabs;
  final Function(int) onTabClicked;
  final int initialTabIndex;
  final bool isScrollable;

  final double height;

  const AppTabBarPlain({
    Key? key,
    required this.tabs,
    required this.onTabClicked,
    this.initialTabIndex = 0,
    this.isScrollable = true,
    this.height = 32,
  }) : super(key: key);

  @override
  _AppTabBarPlainState createState() => _AppTabBarPlainState();
}

/// Used to create only tabs
class _AppTabBarPlainState extends State<AppTabBarPlain>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.tabs.length, vsync: this);
    tabController?.index = widget.initialTabIndex;
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TabBar(
        controller: tabController,
        indicatorColor: Palette.jacarta,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 2.0,
            color: Palette.textColor,
          ),
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
          color: Palette.secondaryColor,
        ),
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'Montserrat',
          color: Palette.textColor,
        ),
        unselectedLabelColor: Palette.secondaryColor,
        labelColor: Palette.jacarta,
        tabs: widget.tabs,
        onTap: widget.onTabClicked,
        // labelPadding: const EdgeInsets.symmetric(horizontal: 8),
        // indicatorPadding: const EdgeInsets.only(right: 8),
        isScrollable: widget.isScrollable,
      ),
    );
  }
}
