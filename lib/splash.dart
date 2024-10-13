import 'dart:async';

import 'app.dart';
import 'bgmd.dart';

final splashProvider = FutureProvider((ref) {
  return Future.wait([
    HiveBoxes.init().then((_) async {
      final name = HiveBoxes.settings.get('locale') as String?;
      if (name != null) {
        final split = name.split('_');
        return setJiffyLocale(Locale.fromSubtags(languageCode: split[0], scriptCode: split.getOrNull(1)));
      }
      final locale = getSuggestedLocale();
      final code = locale.scriptCode != null ? '${locale.languageCode}_${locale.scriptCode}' : locale.languageCode;
      return HiveBoxes.settings.put('locale', code).then((_) {
        return setJiffyLocale(locale);
      });
    }).then((_) {
      final future = fetchData().then((v) async {
        await HiveBoxes.data.put('data', v);
        ref.read(bangumiDataProvider.notifier).state = v;
        Log.d('Data fetched');
      });
      if (!HiveBoxes.data.containsKey('data')) {
        return future;
      }
    }),
    Future.delayed(const Duration(milliseconds: 800)),
  ]);
});

class Splash extends ConsumerWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(splashProvider);
    return value.when(
      data: (_) => const BgmdApp(),
      error: (e, s) {
        Log.e(error: e, stackTrace: s);
        return _Error(error: e);
      },
      loading: () => const _Loading(),
    );
  }
}

class _Error extends StatelessWidget {
  const _Error({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final locale = getSuggestedLocale();
    return MaterialApp(
      themeMode: ThemeMode.system,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: locale,
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return Stack(
              children: [
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: context.navBarHeight + 24.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          error.toString(),
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.red,
                          ),
                          maxLines: 8,
                        ),
                        const Gap(8.0),
                        Text(
                          context.l10n.bootError,
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Assets.bgmd.image(width: 100.0),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    final locale = getSuggestedLocale();
    return MaterialApp(
      themeMode: ThemeMode.system,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: locale,
      home: Scaffold(
        body: Center(
          child: Assets.bgmd.image(width: 100.0),
        ),
      ),
    );
  }
}
