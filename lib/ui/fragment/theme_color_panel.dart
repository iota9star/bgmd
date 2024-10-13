import 'package:flex_color_picker/flex_color_picker.dart';

import '../../bgmd.dart';

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return SliverPinnedAppBar(title: context.l10n.selectColor);
  }
}

class ThemeColorPanel extends ConsumerStatefulWidget {
  const ThemeColorPanel({super.key});

  @override
  ConsumerState<ThemeColorPanel> createState() => _ThemeColorPanelState();
}

class _ThemeColorPanelState extends LifecycleAppState<ThemeColorPanel> {
  ColorSchemePair? _colorSchemePair;

  final ParticleController _controller = ParticleController();

  @override
  void initState() {
    super.initState();
    _tryGetDynamicColor();
  }

  void _tryGetDynamicColor() {
    getDynamicColorScheme().then((value) {
      _colorSchemePair = value;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void onResume() {
    _tryGetDynamicColor();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final dynamicColorEnabled = settings.dynamicColorEnabled;
    return Scaffold(
      body: ParticleWrapper(
        controller: _controller,
        child: CustomScrollView(
          slivers: [
            const _Title(),
            if (_colorSchemePair != null)
              SliverToBoxAdapter(
                child: Container(
                  height: 50.0,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          context.l10n.followSystem,
                          style: context.textTheme.titleMedium,
                        ),
                      ),
                      Switch(
                        onChanged: (v) {
                          if (v) {
                            context.theme.brightness == Brightness.light
                                ? _controller.play(_colorSchemePair!.$1.primary)
                                : _controller.play(_colorSchemePair!.$2.primary);
                          }
                          settings.dynamicColorEnabled = v;
                          setState(() {});
                        },
                        value: dynamicColorEnabled,
                      ),
                    ],
                  ),
                ),
              ),
            if (_colorSchemePair == null || !dynamicColorEnabled)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: ColorPicker(
                    color: settings.seedColor,
                    padding: EdgeInsets.zero,
                    pickerTypeLabels: {
                      ColorPickerType.both: context.l10n.primaryColor,
                      ColorPickerType.wheel: context.l10n.custom,
                    },
                    pickersEnabled: const <ColorPickerType, bool>{
                      ColorPickerType.both: true,
                      ColorPickerType.primary: false,
                      ColorPickerType.accent: false,
                      ColorPickerType.bw: false,
                      ColorPickerType.custom: true,
                      ColorPickerType.wheel: true,
                    },
                    enableShadesSelection: false,
                    pickerTypeTextStyle: context.textTheme.labelLarge,
                    onColorChanged: (v) {
                      if (v == settings.seedColor) {
                        return;
                      }
                      settings.seedColor = v;
                      _controller.play(v);
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
