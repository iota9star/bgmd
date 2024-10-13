import '../bgmd.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.child,
    this.height,
    this.heightFactor = 0.618,
  });

  final Widget child;
  final double? height;
  final double heightFactor;

  static Future<T?> show<T>(
    BuildContext context,
    WidgetBuilder builder, {
    Color? barrierColor,
    bool isScrollControlled = true,
    bool enableDrag = true,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      barrierColor: barrierColor,
      backgroundColor: Colors.transparent,
      builder: builder,
      elevation: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final clipRRect = ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(28.0)),
      child: child,
    );
    final isFullScreen = heightFactor == 1.0;
    return Material(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
      borderRadius: isFullScreen
          ? null
          : const BorderRadius.only(
              topLeft: Radius.circular(28.0),
              topRight: Radius.circular(28.0),
            ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 16.0 + appNavKey.currentContext!.navBarHeight,
          top: isFullScreen ? appNavKey.currentContext!.statusBarHeight + 16.0 : 16.0,
        ),
        child: height != null
            ? SizedBox(
                height: height,
                child: clipRRect,
              )
            : FractionallySizedBox(
                heightFactor: heightFactor,
                child: clipRRect,
              ),
      ),
    );
  }
}
