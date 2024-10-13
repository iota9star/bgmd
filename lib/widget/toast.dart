import '../bgmd.dart';

class ToastWidget extends StatelessWidget {
  const ToastWidget({super.key, required this.msg});

  final String msg;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8.0,
      ),
      margin: EdgeInsets.only(
        bottom: context.navBarHeight + 40.0,
        left: 24.0,
        right: 24.0,
      ),
      child: Text(
        msg,
        style: context.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onTertiaryContainer,
        ),
      ),
    );
  }
}
