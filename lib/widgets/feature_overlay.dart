import 'package:flutter/material.dart';

import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tec_pass/bloc/customnavbar/customnavbar_bloc.dart';

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
          BlocProvider.of<CustomNavBarBloc>(context).add(Visits());
        }
        if (featureId == 'visits_tab') {
          FeatureDiscovery.completeCurrentStep(context);
          BlocProvider.of<CustomNavBarBloc>(context).add(Profile());
        }
        return await Future.value(true);
      },
      featureId: featureId,
      targetColor: targetColor,
      barrierDismissible: false,
      backgroundColor: Colors.black,
      backgroundOpacity: 0.7,
      title: (title == null) ? null : Text(title!),
      description: Text(description),
      tapTarget: AbsorbPointer(child: tapTarget ?? child),
      child: child,
    );
  }
}
