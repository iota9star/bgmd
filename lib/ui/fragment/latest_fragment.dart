import '../../bgmd.dart';

class LatestFragment extends ConsumerWidget {
  const LatestFragment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final season = ref.watch(latestSeasonProvider);
    return ProviderScope(
      overrides: [
        seasonProvider.overrideWithValue(season),
      ],
      child: const SeasonFragment(),
    );
  }
}
