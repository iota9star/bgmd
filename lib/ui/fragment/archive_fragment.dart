import 'package:animations/animations.dart';
import '../../bgmd.dart';

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return SliverPinnedAppBar(title: context.l10n.archive);
  }
}

class ArchiveFragment extends ConsumerWidget {
  const ArchiveFragment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final years = ref.watch(bangumiYearProvider);
    final slivers = <Widget>[const _Title()];
    for (final year in years) {
      slivers.add(
        MultiSliver(
          pushPinnedChildren: true,
          children: [
            SliverPinnedHeader(
              child: DecoratedBox(
                decoration: BoxDecoration(color: context.theme.scaffoldBackgroundColor),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                  child: Text(
                    year.key.toString(),
                    style: context.textTheme.titleLarge,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final season = year.value[index];
                    return TransitionContainer(
                      next: ProviderScope(
                        overrides: [
                          seasonProvider.overrideWithValue(season),
                        ],
                        child: const SeasonPage(),
                      ),
                      transitionType: ContainerTransitionType.fade,
                      builder: (context, open) {
                        return ScalableCard(
                          onTap: open,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        season.season.labelShort(context),
                                        style: context.textTheme.headlineSmall,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.east,
                                      size: 20.0,
                                    ),
                                  ],
                                ),
                                const Gap(4.0),
                                Text(context.l10n.total(season.num)),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  childCount: year.value.length,
                ),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  childAspectRatio: 1.8,
                  crossAxisSpacing: context.margins,
                  mainAxisSpacing: context.margins,
                ),
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
