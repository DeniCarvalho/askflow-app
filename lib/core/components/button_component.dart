import 'package:flutter/material.dart';

import '../core.dart';

class ButtonComponent extends StatelessWidget {
  final bool enabled;
  final VoidCallback? onPressed;
  final bool loading;
  final Color? bgColor;
  final Color? fgColor;
  final Color? colorLoading;
  final String? text;
  final Widget? child;
  final ButtonStyle? style;
  final bool isDark;
  final MaterialStateProperty<EdgeInsetsGeometry?>? padding;
  final double? fontSize;
  final double? elevation;
  final double? borderRadius;
  final Color? shadowColor;
  final Color? overlayColor;
  const ButtonComponent({
    Key? key,
    this.onPressed,
    this.enabled = true,
    this.loading = false,
    this.bgColor,
    this.fgColor,
    this.colorLoading,
    this.text,
    this.child,
    this.style,
    this.isDark = false,
    this.padding,
    this.fontSize,
    this.elevation,
    this.borderRadius,
    this.shadowColor,
    this.overlayColor,
  })  : assert(
            text != null || child != null, 'Required text or child parameters'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: _childButton(),
        ),
      ),
      style: style ??
          ButtonStyle(
            alignment: Alignment.center,
            padding: padding ??
                MaterialStateProperty.all(EdgeInsets.all(12.responsiveWidth)),
            backgroundColor: MaterialStateProperty.all(
              bgColor != null ? bgColor! :  isDark ? AppColors.light : AppColors.primary),
            overlayColor: MaterialStateProperty.all(overlayColor ?? AppColors.light.withOpacity(0.1)),
            foregroundColor: MaterialStateProperty.all(
               fgColor != null ? fgColor! : !isDark ? AppColors.light : AppColors.primary),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 50),
              ),
            ),
            elevation: MaterialStateProperty.all(elevation ?? 4),
            shadowColor: MaterialStateProperty.all(shadowColor),
          ),
    );
  }

  /// Function to organize the display of the child button
  Widget _childButton() {
    if (loading) {
      return SizedBox(
        height: 18.responsiveHeight,
        width: 18.responsiveWidth,
        child: CircularProgressIndicator(
          color: colorLoading ?? AppColors.light,
          backgroundColor: AppColors.transparent,
          strokeWidth: 2.0,
        ),
      );
    }
    if (child == null) {
      return Text(
        text!,
        style: TextStyle(
          fontSize: fontSize ?? 18.fontSize,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    return child!;
  }
}
