import '../../bgmd.dart';

class DisplayModeButton extends ConsumerWidget {
  const DisplayModeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(settingsProvider.select((e) => e.displayMode));
    final isGrid = mode == DisplayMode.grid;
    return IconButton(
      onPressed: () {
        ref.read(settingsProvider.notifier).displayMode = isGrid ? DisplayMode.land : DisplayMode.grid;
      },
      icon: Icon(
        isGrid ? Icons.grid_view : Icons.view_agenda,
      ),
    );
  }
}
