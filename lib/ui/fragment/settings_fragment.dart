import '../../bgmd.dart';

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return SliverPinnedAppBar(title: context.l10n.settings);
  }
}

class SettingsFragment extends StatelessWidget {
  const SettingsFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const _Title(),
        SliverList(
          delegate: SliverChildListDelegate([
            _buildSection(context.theme, context.l10n.ui),
            const ThemeModeMenuItem(),
            const ThemeColorMenuItem(),
            const TabletModeMenuItem(),
            const LanguageMenuItem(),
            _buildSection(context.theme, context.l10n.more),
            const SupportMe(),
            _buildLicense(context),
          ]),
        ),
        const SliverGap(64.0),
      ],
    );
  }

  Widget _buildLicense(BuildContext context) {
    return TransitionContainer(
      builder: (context, open) {
        return RippleTap(
          onTap: open,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            height: 50.0,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    context.l10n.license,
                    style: context.textTheme.titleMedium,
                  ),
                ),
                const Icon(Icons.east_rounded),
              ],
            ),
          ),
        );
      },
      next: LicenseList(),
    );
  }

  Widget _buildSection(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Text(
        title,
        style: theme.textTheme.titleLarge,
      ),
    );
  }
}

class SupportMe extends StatelessWidget {
  const SupportMe({super.key});

  @override
  Widget build(BuildContext context) {
    return RippleTap(
      onTap: () {
        CustomBottomSheet.show(
          context,
          (context) => const CustomBottomSheet(child: DonatePanel()),
        );
      },
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.supportMe,
                style: context.textTheme.titleMedium,
              ),
            ),
            const Icon(Icons.thumb_up_outlined),
          ],
        ),
      ),
    );
  }
}

class LanguageMenuItem extends ConsumerWidget {
  const LanguageMenuItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return RippleTap(
      onTap: () {
        CustomBottomSheet.show(
          context,
          (context) => const CustomBottomSheet(child: LanguagePanel()),
        );
      },
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.language,
                style: context.textTheme.titleMedium,
              ),
            ),
            Text(
              settings.locale.label(context),
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeModeMenuItem extends ConsumerWidget {
  const ThemeModeMenuItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final colors = context.colors;
    final selectedStyle = IconButton.styleFrom(
      foregroundColor: colors.primary,
      backgroundColor: colors.surfaceContainerHighest,
      disabledForegroundColor: colors.onSurface.withOpacity(0.38),
      disabledBackgroundColor: colors.onSurface.withOpacity(0.12),
      hoverColor: colors.primary.withOpacity(0.08),
      focusColor: colors.primary.withOpacity(0.12),
      highlightColor: colors.primary.withOpacity(0.12),
    );
    final themeMode = settings.themeMode;
    return RippleTap(
      onTap: () {},
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.themeMode,
                style: context.textTheme.titleMedium,
              ),
            ),
            Transform.translate(
              offset: const Offset(8.0, 0.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      settings.themeMode = ThemeMode.system;
                    },
                    style: themeMode == ThemeMode.system ? selectedStyle : null,
                    icon: const Icon(Icons.auto_awesome_rounded),
                  ),
                  const Gap(4.0),
                  IconButton(
                    onPressed: () {
                      settings.themeMode = ThemeMode.light;
                    },
                    style: themeMode == ThemeMode.light ? selectedStyle : null,
                    icon: const Icon(Icons.light_mode_rounded),
                  ),
                  const Gap(4.0),
                  IconButton(
                    onPressed: () {
                      settings.themeMode = ThemeMode.dark;
                    },
                    style: themeMode == ThemeMode.dark ? selectedStyle : null,
                    icon: const Icon(Icons.dark_mode_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeColorMenuItem extends ConsumerWidget {
  const ThemeColorMenuItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final Widget child;
    if (settings.dynamicColorEnabled) {
      child = Text(
        context.l10n.followSystem,
        style: context.textTheme.bodyMedium,
      );
    } else {
      final seedColor = settings.seedColor;
      return Container(
        height: 50.0,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.seedColor,
                style: context.textTheme.titleMedium,
              ),
            ),
            Transform.translate(
              offset: const Offset(8.0, 0.0),
              child: IconButton(
                onPressed: () {
                  CustomBottomSheet.show(
                    context,
                    (context) => const CustomBottomSheet(child: ThemeColorPanel()),
                  );
                },
                icon: Icon(
                  Icons.circle_rounded,
                  color: seedColor,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return RippleTap(
      onTap: () {},
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.seedColor,
                style: context.textTheme.titleMedium,
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}

class TabletModeMenuItem extends ConsumerWidget {
  const TabletModeMenuItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return RippleTap(
      onTap: () {
        CustomBottomSheet.show(
          context,
          (context) => const CustomBottomSheet(child: TabletModePanel()),
        );
      },
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.tabletMode,
                style: context.textTheme.titleMedium,
              ),
            ),
            Text(
              settings.tabletMode.label(context),
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
