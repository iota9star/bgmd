import '../../bgmd.dart';

final selectedTabProvider = StateProvider((ref) {
  return 0;
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final selectedTab = ref.watch(selectedTabProvider);
    final isTablet = context.useTabletLayout(settings.tabletMode);
    final body = IndexedStack(
      index: selectedTab,
      children: const [
        LatestFragment(),
        BangumiFragment(),
        ArchiveFragment(),
        CollectionFragment(),
        SettingsFragment(),
      ],
    );
    return PopScope(
      onPopInvokedWithResult: (ok, result) {
        showSnackbar(
          context,
          context.l10n.exitText,
          SnackBarAction(
            label: context.l10n.exitAction,
            onPressed: exitApp,
          ),
        );
      },
      child: Scaffold(
        floatingActionButton: TransitionContainer(
          next: const SearchPage(),
          closedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          closedElevation: isTablet ? 4.0 : 2.0,
          builder: (context, open) {
            return FloatingActionButton(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
              ),
              onPressed: open,
              enableFeedback: true,
              child: const Icon(Icons.search),
            );
          },
        ),
        bottomNavigationBar: !isTablet
            ? BottomNavigationBar(
                currentIndex: selectedTab,
                onTap: (index) {
                  ref.read(selectedTabProvider.notifier).state = index;
                },
                enableFeedback: true,
                selectedFontSize: 12.0,
                useLegacyColorScheme: false,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.event_outlined),
                    activeIcon: const Icon(Icons.event_note),
                    label: context.l10n.newest,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.menu_open_outlined),
                    activeIcon: const Icon(Icons.vertical_split),
                    label: context.l10n.bangumi,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.grid_3x3_outlined),
                    activeIcon: const Icon(Icons.grid_view),
                    label: context.l10n.archive,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.favorite_border),
                    activeIcon: const Icon(Icons.favorite),
                    label: context.l10n.collection,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.settings_outlined),
                    activeIcon: const Icon(Icons.settings),
                    label: context.l10n.settings,
                  ),
                ],
              )
            : null,
        body: isTablet
            ? Row(
                children: [
                  NavigationRail(
                    labelType: NavigationRailLabelType.selected,
                    destinations: [
                      NavigationRailDestination(
                        icon: const Icon(Icons.event_outlined),
                        selectedIcon: const Icon(Icons.event_note),
                        label: Text(context.l10n.newest),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(Icons.menu_open_outlined),
                        selectedIcon: const Icon(Icons.vertical_split),
                        label: Text(context.l10n.bangumi),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(Icons.grid_3x3_outlined),
                        selectedIcon: const Icon(Icons.grid_view),
                        label: Text(context.l10n.archive),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(Icons.favorite_border),
                        selectedIcon: const Icon(Icons.favorite),
                        label: Text(context.l10n.collection),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(Icons.settings_outlined),
                        selectedIcon: const Icon(Icons.settings),
                        label: Text(context.l10n.settings),
                      ),
                    ],
                    selectedIndex: selectedTab,
                    onDestinationSelected: (index) {
                      ref.read(selectedTabProvider.notifier).state = index;
                    },
                    groupAlignment: -0.96,
                    leading: Assets.bgmd.image(width: 64.0),
                  ),
                  const VerticalDivider(
                    thickness: 0.0,
                    width: 1.0,
                  ),
                  Expanded(child: body),
                ],
              )
            : body,
      ),
    );
  }
}
