import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class TransitionContainer<T> extends StatelessWidget {
  const TransitionContainer({
    super.key,
    this.next,
    this.onClosed,
    this.openElevation = 0.0,
    this.closedElevation = 0.0,
    required this.builder,
    this.openShape = const RoundedRectangleBorder(),
    this.closedShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    ),
    this.transitionType = ContainerTransitionType.fade,
    this.transitionDuration = const Duration(milliseconds: 360),
    this.closedColor,
    this.openColor,
    this.routeSettings,
  });

  final Widget? next;
  final CloseContainerBuilder builder;
  final ShapeBorder closedShape;
  final ShapeBorder openShape;
  final double openElevation;
  final double closedElevation;
  final ContainerTransitionType transitionType;
  final Duration transitionDuration;
  final Color? closedColor;
  final Color? openColor;
  final RouteSettings? routeSettings;
  final ClosedCallback<T?>? onClosed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OpenContainer(
      closedColor: closedColor ?? theme.scaffoldBackgroundColor.withOpacity(0.0),
      openColor: openColor??theme.scaffoldBackgroundColor,
      openElevation: openElevation,
      closedElevation: closedElevation,
      closedShape: closedShape,
      openShape: openShape,
      transitionType: transitionType,
      transitionDuration: transitionDuration,
      openBuilder: (_, __) => next!,
      closedBuilder: builder,
      routeSettings: routeSettings,
      onClosed: onClosed,
    );
  }
}
