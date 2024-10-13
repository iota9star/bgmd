import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../../bgmd.dart';

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return SliverPinnedAppBar(
      title: context.l10n.search,
    );
  }
}

class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final value = ref.watch(searchProvider(controller.text));
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _Title(),
          SliverPinnedHeader(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.theme.scaffoldBackgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    isDense: true,
                    border: const OutlineInputBorder(),
                    hintText: context.l10n.searchHint,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: controller.clear,
                    ),
                  ),
                  textInputAction: TextInputAction.search,
                  keyboardType: TextInputType.text,
                  onChanged: (_) {
                    ref.invalidate(searchProvider);
                  },
                ),
              ),
            ),
          ),
          if (value.valueNotNull && value.requireValue.$2.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 12.0),
                child: Text(
                  context.l10n.searchResult(value.requireValue.$1, value.requireValue.$2.length),
                  style: context.textTheme.bodySmall,
                ),
              ),
            ),
          value.when(
            data: (v) {
              final data = v.$2;
              if (data.isEmpty) {
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
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                sliver: SliverWaterfallFlow(
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
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            error: (error, _) {
              return const SliverToBoxAdapter();
            },
          ),
          SliverGap(context.navBarHeight + 24.0),
        ],
      ),
    );
  }
}
