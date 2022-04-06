import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BackgroundVideoComponent extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isBlur;
  final double blur;
  final bool isFilter;
  final Gradient? gradient;
  const BackgroundVideoComponent({
    Key? key,
    required this.controller,
    this.isFilter = false,
    this.isBlur = false,
    this.blur = 6.0,
    this.gradient,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            height: controller.value.size.height,
            width: controller.value.size.width,
            child: VideoPlayer(controller),
          ),
        ),
        Positioned(
          bottom: 0,
          top: 0,
          left: 0,
          right: 0,
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              height: controller.value.size.height,
              width: controller.value.size.width,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 700),
                decoration: isFilter
                    ? BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                      )
                    : gradient != null
                        ? BoxDecoration(gradient: gradient)
                        : null,
                child: isBlur
                    ? BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                        ),
                      )
                    : null,
              ),
            ),
          ),
        )
      ],
    );
  }
}
