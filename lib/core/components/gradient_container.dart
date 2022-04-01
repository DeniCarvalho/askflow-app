import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///
/// Sucessfull completion of onboarding
///
class GradientContainer extends StatelessWidget {
  ///
  /// Body widget
  ///
  final Widget? body;

  final Gradient gradient;

  ///
  /// Constructor
  ///
  const GradientContainer({
    this.body,
    required this.gradient,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        child: body != null ? SafeArea(child: body!) : null,
        decoration: BoxDecoration(
          gradient: gradient,
        ),
      ),
    );
  }
}
