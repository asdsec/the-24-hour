import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:the_24_hour/product/navigation/app_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AutoTabsScaffold(
        appBarBuilder: (context, tabsRouter) {
          return AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                splashRadius: 20,
                icon: const Icon(Icons.more_vert),
              ),
            ],
          );
        },
        routes: const [
          DashBoardRoute(),
          SettingsRoute(),
          ScheduleRoute(),
        ],
        bottomNavigationBuilder: (context, tabsRouter) {
          return BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            selectedFontSize: 12,
            items: const [
              BottomNavigationBarItem(
                label: 'Dashboard',
                icon: Icon(Icons.dashboard_outlined),
                activeIcon: Icon(Icons.dashboard),
              ),
              BottomNavigationBarItem(
                label: 'Schedule',
                icon: Icon(Icons.schedule_outlined),
                activeIcon: Icon(Icons.schedule),
              ),
              BottomNavigationBarItem(
                label: 'Settings',
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
              ),
            ],
          );
        },
      ),
    );
  }
}
