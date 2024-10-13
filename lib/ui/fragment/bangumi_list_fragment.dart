import 'package:waterfall_flow/waterfall_flow.dart';

import '../../bgmd.dart';

class BangumiListFragment extends ConsumerWidget {
  const BangumiListFragment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemsProvider);
    final displayMode = ref.watch(settingsProvider.select((e) => e.displayMode));
    return displayMode == DisplayMode.grid
        ? SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisSpacing: context.margins,
              crossAxisSpacing: context.margins,
              childAspectRatio: 0.6,
              maxCrossAxisExtent: 120.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = items[index];
                return ProviderScope(
                  overrides: [itemProvider.overrideWithValue(item)],
                  child: const BangumiGridCard(),
                );
              },
              childCount: items.length,
            ),
          )
        : SliverWaterfallFlow(
            gridDelegate: SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
              mainAxisSpacing: context.margins,
              crossAxisSpacing: context.margins,
              maxCrossAxisExtent: 250.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = items[index];
                return ProviderScope(
                  overrides: [itemProvider.overrideWithValue(item)],
                  child: const BangumiLandCard(),
                );
              },
              childCount: items.length,
            ),
          );
  }
}
