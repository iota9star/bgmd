import '../../bgmd.dart';

class SeasonFragment extends ConsumerWidget {
  const SeasonFragment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final season = ref.watch(seasonProvider);
    final slivers = <Widget>[
      SliverPinnedAppBar(
        title: season.season.label(context, season.year),
        actions: const [DisplayModeButton()],
      ),
    ];
    for (final week in season.week) {
      slivers.add(
        MultiSliver(
          pushPinnedChildren: true,
          children: [
            SliverPinnedHeader(
              child: Transform.translate(
                offset: const Offset(0.0, -1.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.theme.scaffoldBackgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    child: Text(
                      week.weekday.label(context, week.items.length),
                      style: context.textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
            ),
            ProviderScope(
              overrides: [itemsProvider.overrideWithValue(week.items)],
              child: const SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                sliver: BangumiListFragment(),
              ),
            ),
          ],
        ),
      );
    }
    slivers.add(SliverGap(context.navBarHeight + 24.0));
    return CustomScrollView(
      slivers: slivers,
    );
  }
}
