import 'package:hive_flutter/hive_flutter.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../../bgmd.dart';

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return SliverPinnedAppBar(title: context.l10n.collection);
  }
}

class CollectionFragment extends StatelessWidget {
  const CollectionFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const _Title(),
        ValueListenableBuilder(
          valueListenable: HiveBoxes.collections.listenable(),
          builder: (context, v, child) {
            if (v.isEmpty) {
              return SliverFillRemaining(
                child: Align(
                  alignment: const Alignment(0.0, -0.2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('🍃', style: context.textTheme.displayLarge),
                      const Gap(12.0),
                      Text(context.l10n.noDataFound, style: context.textTheme.bodySmall),
                    ],
                  ),
                ),
              );
            }
            final data = v.values.toList();
            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              sliver: MultiSliver(
                children: [
                  SliverToBoxAdapter(child: Text(context.l10n.collectionNum(data.length))),
                  const SliverGap(8.0),
                  SliverWaterfallFlow(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ProviderScope(
                          overrides: [
                            bangumiProvider.overrideWithValue(data[index]),
                          ],
                          child: const BangumiItemCard(),
                        );
                      },
                      childCount: data.length,
                    ),
                    gridDelegate: SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200.0,
                      mainAxisSpacing: context.margins,
                      crossAxisSpacing: context.margins,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
