part of 'widgets.dart';

class CustomFeatureOverlay extends StatelessWidget {
  const CustomFeatureOverlay({
    required this.featureId,
    required this.child,
    required this.description,
    this.title,
    this.tapTarget,
    this.targetColor = Colors.white,
  });

  final String featureId;
  final Widget child;
  final Widget? tapTarget;
  final String? title;
  final String description;
  final Color targetColor;

  @override
  Widget build(BuildContext context) {
    return DescribedFeatureOverlay(
      onComplete: () async {
        if (featureId == 'place_exit_widget') {
          FeatureDiscovery.completeCurrentStep(context);
          BlocProvider.of<NavbarCubit>(context).emit(1);
        }
        if (featureId == 'visits_tab') {
          FeatureDiscovery.completeCurrentStep(context);
          BlocProvider.of<NavbarCubit>(context).emit(2);
        }
        return await Future.value(true);
      },
      onDismiss: () async {
        FeatureDiscovery.dismissAll(context);
        return true;
      },
      featureId: featureId,
      targetColor: targetColor,
      barrierDismissible: true,
      backgroundColor: Colors.black,
      backgroundOpacity: 0.7,
      title: (title == null) ? null : Text(title!),
      description: Text(description),
      tapTarget: AbsorbPointer(child: tapTarget ?? child),
      child: child,
    );
  }
}
