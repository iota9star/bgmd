
import '../../bgmd.dart';

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return SliverPinnedAppBar(title: context.l10n.tabletMode);
  }
}

class TabletModePanel extends ConsumerWidget {
  const TabletModePanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _Title(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final mode = TabletMode.values[index];
                return RadioListTile<TabletMode>(
                  title: Text(mode.label(context)),
                  value: mode,
                  groupValue: settings.tabletMode,
                  onChanged: (value) {
                    settings.tabletMode = mode;
                    Navigator.pop(context);
                  },
                );
              },
              childCount: TabletMode.values.length,
            ),
          ),
        ],
      ),
    );
  }
}
