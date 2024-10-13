import 'dart:ui';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'bgmd.dart';

class BgmdApp extends StatelessWidget {
  const BgmdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsProvider(
      builder: (settings, lightColorScheme, darkColorScheme) {
        return MaterialApp(
          onGenerateTitle: (context) => context.l10n.appName,
          locale: settings.locale,
          themeMode: settings.themeMode,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorScheme: lightColorScheme,
            visualDensity: VisualDensity.standard,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorScheme: darkColorScheme,
            visualDensity: VisualDensity.standard,
          ),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          scrollBehavior: const ScrollBehavior().copyWith(
            dragDevices: PointerDeviceKind.values.toSet(),
            scrollbars: false,
            overscroll: false,
          ),
          navigatorKey: appNavKey,
          navigatorObservers: [Lifecycle.lifecycleRouteObserver],
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
          builder: FlutterSmartDialog.init(
            toastBuilder: (msg) => ToastWidget(msg: msg),
            loadingBuilder: (msg) => LoadingWidget(msg: msg),
            builder: (context, child) {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
              return AnnotatedRegion(
                value: context.fitSystemUiOverlayStyle,
                child: GestureDetector(
                  onTap: hideKeyboard,
                  child: child,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class SettingsProvider extends ConsumerStatefulWidget {
  const SettingsProvider({super.key, required this.builder});

  final Widget Function(
    AppSettings settings,
    ColorScheme lightColorScheme,
    ColorScheme darkColorScheme,
  ) builder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SettingsProviderState();
  }
}

class _SettingsProviderState extends LifecycleAppState<SettingsProvider> {
  final _colorSchemePair = ValueNotifier<ColorSchemePair?>(null);

  @override
  void initState() {
    super.initState();
    _tryGetDynamicColor();
  }

  void _tryGetDynamicColor() {
    getDynamicColorScheme().then((value) {
      _colorSchemePair.value = value;
    });
  }

  @override
  void onResume() {
    _tryGetDynamicColor();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return ValueListenableBuilder(
      valueListenable: _colorSchemePair,
      builder: (context, pair, child) {
        if (settings.dynamicColorEnabled && pair != null) {
          return widget.builder.call(settings, pair.$1, pair.$2);
        }
        final seedColor = settings.seedColor;
        return widget.builder.call(
          settings,
          ColorScheme.fromSeed(seedColor: seedColor),
          ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: Brightness.dark,
          ),
        );
      },
    );
  }
}
