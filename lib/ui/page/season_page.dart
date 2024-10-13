import '../../bgmd.dart';

class SeasonPage extends ConsumerWidget {
  const SeasonPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: SeasonFragment(),
    );
  }
}
