import '../../bgmd.dart';

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return SliverPinnedAppBar(title: context.l10n.language);
  }
}

class LanguagePanel extends ConsumerWidget {
  const LanguagePanel({super.key});

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
                final locale = AppLocalizations.supportedLocales[index];
                return RadioListTile<Locale>(
                  title: Text(locale.label(context)),
                  value: locale,
                  groupValue: settings.locale,
                  onChanged: (value) {
                    settings.locale =
                        value ?? AppLocalizations.supportedLocales[0];
                    Navigator.pop(context);
                  },
                );
              },
              childCount: AppLocalizations.supportedLocales.length,
            ),
          ),
        ],
      ),
    );
  }
}
